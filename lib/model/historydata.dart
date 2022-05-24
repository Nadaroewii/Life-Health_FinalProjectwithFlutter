class Historydata{
  final String id;
  final String duration;
  final String distance;
  final String dataact;
  final String kal;
  final String lastlatitude;
  final String lastlongitude;

  Historydata({
    required this.id,
    required this.duration,
    required this.distance,
    required this.dataact,
    required this.kal,
    required this.lastlatitude,
    required this.lastlongitude
});

  factory Historydata.fromJson(Map<String, dynamic> json){
    return Historydata(
        id: json['id'] as String,
        duration: json['duration'] as String,
        distance: json['distance'] as String,
        dataact: json['dataact'] as String,
        kal: json['kal'] as String,
        lastlatitude: json['lastlatitude'] as String,
        lastlongitude: json['lastlongitude'] as String,
    );
  }

}