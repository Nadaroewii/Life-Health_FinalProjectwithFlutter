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
        id: json['id'],
        duration: json['duration'],
        distance: json['distance'],
        dataact: json['dataact'],
        kal: json['kal'],
        lastlatitude: json['lastlatitude'],
        lastlongitude: json['lastlongitude'],
    );
  }

}