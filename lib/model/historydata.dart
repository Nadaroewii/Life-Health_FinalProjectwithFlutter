class Historydata {
  final String? id;
  final String? duration;
  final String? distance;
  final String? dataact;
  final String? kal;
  final String? lastlatitude;
  final String? lastlongitude;

  Historydata(
      {required this.id,
      required this.duration,
      required this.distance,
      required this.dataact,
      required this.kal,
      required this.lastlatitude,
      required this.lastlongitude});

  factory Historydata.fromJson(Map<String, dynamic> json) {
    return Historydata(
      id: json['id'].toString(),
      duration: json['duration'].toString(),
      distance: json['distance'].toString(),
      dataact: json['dataact'].toString(),
      kal: json['kal'].toString(),
      lastlatitude: json['lastlatitude'].toString(),
      lastlongitude: json['lastlongitude'].toString(),
    );
  }
}
