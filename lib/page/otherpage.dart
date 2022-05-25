// ignore_for_file: avoid_print, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flspai/ai_file/tfprocessor.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flspai/page/finishdata.dart';
import 'package:flspai/model/Start.dart';
import 'package:flspai/model/Entry.dart';

class OtherPage extends StatefulWidget {
  final Mulai mulai;
  const OtherPage({Key? key, required this.mulai}) : super(key: key);

  @override
  State<OtherPage> createState() => _OtherPageState(mulai:mulai);
}

class _OtherPageState extends State<OtherPage> {
  late Mulai mulai;
  _OtherPageState({required this.mulai}) : super();
final Set<Polyline> polyline = {};
Location _location = Location();
late GoogleMapController _mapController;
LatLng _center = const LatLng(0, 0);
List<LatLng> route = [];

double _dist = 0;
late String _displayTime;
late int _time;
late int _lastTime;
double _speed = 0;
double _avgSpeed = 0;
int _speedCounter = 0;
late final double finishlat;
late final double finishlong;

final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  //Accelerometer Event
  AccelerometerEvent accelerometerState = AccelerometerEvent(0.0, 0.0, 0.0);
  String _accelerometer = "";

  //Gyroscope Event
  GyroscopeEvent gyroscopeState = GyroscopeEvent(0.0, 0.0, 0.0);
  String _gyroscope = "";

  //Ai Stuff
  final ModelProcessor _model = ModelProcessor();
  String _aiResult = "";
  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  void updateValues() {
    //print("Updated !");

    var r = _model.run(accelerometerState, gyroscopeState);
    String msg = "";
    if (r == ModelResult.jalanCepat) {
      msg = "Jalan Cepat";
    } else if (r == ModelResult.jalanBiasa) {
      msg = "Jalan Biasa";
    } else {
      msg = "Unknown";
    }

    setState(() {
      _accelerometer =
          "x: ${accelerometerState.x}\n y: ${accelerometerState.y}\n z: ${accelerometerState.z}";
      _gyroscope =
          "x: ${gyroscopeState.x}\n y: ${gyroscopeState.y}\n z: ${gyroscopeState.z}";
      _aiResult = msg;
    });
  }

  //init overide
  @override
  void initState() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    super.initState();

    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      // [AccelerometerEvent (x: 0.0, y: 9.8, z: 0.0)]
      accelerometerState = AccelerometerEvent(event.x, event.y, event.z);
      updateValues();
    });

    gyroscopeEvents.listen((GyroscopeEvent event) {
      // [GyroscopeEvent (x: 0.0, y: 0.0, z: 0.0)]
      gyroscopeState = event;
      updateValues();
    });

    _model.initModel();
  }

void _onMapCreated(GoogleMapController controller) {
  _mapController = controller;
  double appendDist;

  _location.onLocationChanged.listen((event) {
    LatLng loc = LatLng(event.latitude!, event.longitude!);
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: loc, zoom: 15)));
    if (route.length > 0) {
      appendDist = Geolocator.distanceBetween(route.last.latitude,
          route.last.longitude, loc.latitude, loc.longitude);
      _dist = _dist + appendDist;
      int timeDuration = (_time - _lastTime);
      if (_lastTime != null && timeDuration != 0) {
        _speed = (appendDist / (timeDuration / 100)) * 3.6;
        if (_speed != 0) {
          _avgSpeed = _avgSpeed + _speed;
          _speedCounter++;
        }
      }
    }
    _lastTime = _time;
    route.add(loc);

    polyline.add(Polyline(
        polylineId: PolylineId(event.toString()),
        visible: true,
        points: route,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        color: Colors.deepOrange));
    //setState(() {});
  });
}

final _isHours = true;

Duration duration = Duration();
void tesTapButton() {
}


@override
Widget build(BuildContext context) =>
    Scaffold(
        appBar: AppBar(
          backgroundColor: fromCssColor('#FFDC97'),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LifeHealth',
                style:
                TextStyle(fontSize: 21,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                    color: Colors.brown),
              ),
            ],),
        ),
        bottomSheet: Container(
          width: double.infinity,
          color: Colors.brown,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
        body: Container(
        width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
          child: Column(children: [
          Container(
          height: 400,
          child: GoogleMap(
          polylines: polyline,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(target: _center, zoom: 19),
          )
          ),
          Container(
          padding: EdgeInsets.all(20),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(height: 10),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Column(
          children: [
          Text("Speed (KM/H)",
          style: TextStyle(fontSize: 12,
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,
          height: 2.0,
          color: Colors.black)),
          Text(_speed.toStringAsFixed(2),
          style: TextStyle(fontSize: 12,
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,
          height: 2.0,
          color: Colors.black))
          ],
          ),
          Column(
          children: [
          Text("Time",
          style: TextStyle(fontSize: 12,
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,
          height: 2.0,
          color: Colors.black)),
          StreamBuilder<int>(
          stream: _stopWatchTimer.rawTime,
          initialData: 0,
          builder: (context, snap) {
          _time = snap.data!;
          _displayTime =
          StopWatchTimer.getDisplayTimeHours(
          _time) +
          ":" +
          StopWatchTimer.getDisplayTimeMinute(
          _time) +
          ":" +
          StopWatchTimer.getDisplayTimeSecond(
          _time);
          return Text(_displayTime,
          style: TextStyle(fontSize: 12,
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,
          height: 2.0,
          color: Colors.black));
          },
          )
          ],
          ),
          Column(
          children: [
          Text("Distance (KM)",
          style: TextStyle(fontSize: 12,
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,
          height: 2.0,
          color: Colors.black)),
          Text((_dist / 1000).toStringAsFixed(2),
          style: TextStyle(fontSize: 12,
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,
          height: 2.0,
          color: Colors.black))
          ],
          )
          ],
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("Jenis Aktivitas",
            style: TextStyle(fontSize: 12,
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
            height: 2.0,
            color: Colors.black)),
            Text(_aiResult,
            style: TextStyle(fontSize: 12,
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
            height: 2.0,
            color: Colors.black))
            ]
),
]),
),
  Container(
    height: 150,
    child: Column(
        children: [
          Divider(),
          IconButton(
            icon: Icon(
              Icons.stop_circle_outlined,
              size: 50,
              color: Colors.redAccent,
            ),
            padding: EdgeInsets.all(0),
            onPressed: () async {
              Entry entry = Entry(
                  date: DateFormat.yMMMMd('en_US').format(DateTime
                      .now()),
                  duration: _displayTime,
                  speed:
                  _speedCounter == 0 ? 0 : _avgSpeed / _speedCounter,
                  dataactv: _aiResult,
                  distance: _dist,
                  waktutot: ((double.parse(StopWatchTimer.getDisplayTimeHours(_time))) * 60 ) + double.parse(StopWatchTimer.getDisplayTimeMinute(_time)) + ((double.parse(StopWatchTimer.getDisplayTimeSecond(_time))) / 60 ),
                  lastlatitude:  route.last.latitude,
                  lastlongitude: route.last.longitude
              );
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      DataFinish(entry: entry, mulai: mulai,)));
            },
          ),
        ]),),
]
),))
);
}
