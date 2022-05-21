import 'dart:convert';

EncryptResponse dataencryptResponse(String str) =>
    EncryptResponse.fromJson(json.decode(str));

class EncryptResponse {
  EncryptResponse({
    required this.data,
  });
  late final Data? data;

  EncryptResponse.fromJson(Map<String, dynamic> json){
    data = json['data'] !=null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _datanew = <String, dynamic>{};
    _datanew['data'] = data!.toJson();
    return _datanew;
  }
}

class Data {
  Data({
    required this.duration,
    required this.distance,
    required this.dataactv,
    required this.kal,
    required this.lastlatitude,
    required this.lastlongitude,
    required this.date,
  });
  late final String duration;
  late final double distance;
  late final String dataactv;
  late final String kal;
  late final double lastlatitude;
  late final double lastlongitude;
  late final String date;

  Data.fromJson(Map<String, dynamic> json){
    duration = json['duration'];
    distance = json['distance'];
    dataactv = json['dataactv'];
    kal = json['kal'];
    lastlatitude = json['lastlatitude'];
    lastlongitude = json['lastlongitude'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _datanew = <String, dynamic>{};
    _datanew['duration'] = duration;
    _datanew['distance'] = distance;
    _datanew['dataactv'] = dataactv;
    _datanew['kal']= kal;
    _datanew['lastlatitude'] = lastlatitude;
    _datanew['lastlongitude'] = lastlongitude;
    _datanew['date'] = date;
    return _datanew;
  }
}