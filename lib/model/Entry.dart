import 'package:flutter/material.dart';

class Entry {

  String date;
  String duration;
  double speed;
  String dataactv;
  double distance;
  double waktutot;
  double lastlatitude;
  double lastlongitude;

  Entry({
    required this.date,
    required this.duration,
    required this.speed,
    required this.dataactv,
    required this.distance,
    required this.waktutot,
    required this.lastlatitude,
    required this.lastlongitude
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date,
      'duration': duration,
      'speed': speed,
      'dataactv' : dataactv,
      'distance': distance,
      'waktutot' : waktutot,
      'lastlatitude': lastlatitude,
      'lastlongitude': lastlongitude
    };


    return map;
  }
  static Entry fromMap(Map<String, dynamic> map) {
    return Entry(
        date: map['date'],
        duration: map['duration'],
        speed: map['speed'],
        dataactv: map['dataactv'],
        distance: map['distance'],
        waktutot: map['waktutot'],
        lastlatitude: map['lastlatitude'],
        lastlongitude: map['lastlongitude']
        );
  }
}