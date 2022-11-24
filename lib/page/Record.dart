import 'dart:core';
import 'dart:math';
import 'package:flspai/page/mulai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flspai/services/shared_services.dart';
import 'package:flutter_js/extensions/xhr.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async';
import 'package:location/location.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:flspai/model/historydata.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:flspai/services/api_services.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class RecordData extends StatefulWidget {
  RecordData({Key? key}) : super(key: key);
  @override
  State<RecordData> createState() => _RecordDataState();
}

class _RecordDataState extends State<RecordData> {
  List<Historydata> listdata = [];
  APIService apiservice = APIService();
  //late Future<Historydata> historydata;
  getData() async {
    listdata = await apiservice.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
    // historydata = APIService.getData();
  }

  //
  // bool isAPIcallProcess = false;
  // APIService apiservice = APIService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: fromCssColor('#FFDC97'),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LifeHealth',
                style: TextStyle(
                    fontSize: 21,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                    color: Colors.brown),
              ),
            ],
          ),
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
        body: Column(children: [
          Text(
            'History Data',
            style: TextStyle(
                fontSize: 21,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                height: 2.0,
                color: Colors.black),
          ),
          ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                    child: Text('Activity Type : ' +
                        listdata[index].dataact.toString() +
                        ' / ' +
                        ' Duration : ' +
                        listdata[index].duration.toString() +
                        ' / ' +
                        ' Distance : ' +
                        listdata[index].distance.toString() +
                        ' / ' +
                        ' Calories Burned : ' +
                        listdata[index].kal.toString() +
                        ' / ' +
                        ' Last Latitude : ' +
                        listdata[index].lastlatitude.toString() +
                        ' / ' +
                        ' Last Longitude : ' +
                        listdata[index].lastlongitude.toString()));
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: listdata.length),
          SizedBox(height: 30),
          Center(
              child: FormHelper.submitButton("Retrieve Data", () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Start()));
          },
                  btnColor: Colors.brown,
                  borderColor: Colors.white,
                  txtColor: Colors.white,
                  borderRadius: 10)),
          SizedBox(height: 30),
          Center(
              child: FormHelper.submitButton("Log Out", () {
            SharedService.logout(context);
          },
                  btnColor: Colors.brown,
                  borderColor: Colors.white,
                  txtColor: Colors.white,
                  borderRadius: 10)),
        ]));
  }
}
