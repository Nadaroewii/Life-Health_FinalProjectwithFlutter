import 'dart:convert';
// class EncryptRequest {
//   EncryptRequest({
//     required this.duration,
//     required this.distance,
//     required this.dataactv,
//     required this.kal,
//     required this.lastlatitude,
//     required this.lastlongitude,
//   });
//   late final String duration;
//   late final double distance;
//   late final String dataactv;
//   late final String kal;
//   late final double lastlatitude;
//   late final double lastlongitude;
//
//   EncryptRequest.fromJson(Map<String, dynamic> json) {
//     duration = json['duration'];
//     distance = json['distance'];
//     dataactv = json['dataactv'];
//     kal = json['kal'];
//     lastlatitude = json['lastlatitude'];
//     lastlongitude = json['lastlongitude'];
//   }
//   Map<String, dynamic> toJson() {
//     final _datanew = <String, dynamic>{};
//     _datanew['duration'] = duration;
//     _datanew['distance'] = distance;
//     _datanew['dataactv'] = dataactv;
//     _datanew['kal']= kal;
//     _datanew['lastlatitude'] = lastlatitude;
//     _datanew['lastlongitude'] = lastlongitude;
//     return _datanew;
//   }
// }

//Encrypt encryptFromJson(String str) => Encrypt.fromJson(json.decode(str));

//String encryptToJson(Encrypt data) => json.encode(data.toJson());

class Encrypt {
  final String duration;
  final String distance;
  final String dataactv;
  final String kal;
  final String lastlatitude;
  final String lastlongitude;

  const Encrypt({
    required this.duration,
    required this.distance,
    required this.dataactv,
    required this.kal,
    required this.lastlatitude,
    required this.lastlongitude});

  factory Encrypt.fromJson(Map<String, dynamic> json) {
      return Encrypt(
      duration: json['duration'],
      distance: json['distance'],
      dataactv: json['dataactv'],
      kal: json['kal'],
      lastlatitude: json['lastlatitude'],
      lastlongitude: json['lastlongitude'],
      );
  }

}
