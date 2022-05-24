import 'dart:core';
import 'dart:math';
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
  APIService apiService = APIService();

  getData() async{
    listdata = await apiService.getData();
    setState(() {});
  }
  @override
  void initState() {
    getData();
    super.initState();
  }

  //
  // bool isAPIcallProcess = false;
  // APIService apiservice = APIService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fromCssColor('#FFDC97'),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'LifeHealth',
              style:
              TextStyle(fontSize: 24,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  height: 3.0,
                  color: Colors.brown),
            ),
          ],),
      ),
          body: Column(
          children: [
          ListView.separated(
            scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(child: Text(
                    'Activity Type : ' + listdata[index].dataact
                        + ' / ' + ' Duration : ' + listdata[index].duration + ' / ' + ' Distance : ' +
                        listdata[index].distance + ' / ' + ' Calories Burned : ' + listdata[index].kal + ' / ' + ' Last Latitude : '
                        + listdata[index].lastlatitude + ' / ' + ' Last Longitude : ' + listdata[index].lastlongitude)
                );
              },
              separatorBuilder: (context, index){
                return Divider();
            }, itemCount: listdata.length),
      SizedBox(height: 30),
      Center(
          child: FormHelper.submitButton(
              "Log Out",
                  () {
                SharedService.logout(context);
              },
              btnColor: Colors.brown,
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10)
      ),
])
    );
    }
  }

