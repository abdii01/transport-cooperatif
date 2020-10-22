class stationreltimedatabase {
  final String time;
  final String nom;
  final String id;

  stationreltimedatabase({this.time, this.nom, this.id});

  stationreltimedatabase.fromMap(Map<String, dynamic> data, String id)
      : time = data['time'],
        nom = data['nom'],
        id = id;
  Map<String, dynamic> toMap() {
    return {
      "time": time,
    };
  }
}
