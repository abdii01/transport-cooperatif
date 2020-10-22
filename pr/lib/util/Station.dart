class Station {
  final String number;
  final String localistion;
  final String type;
  final String id;

  Station({this.number, this.localistion, this.type, this.id});

  Station.fromMap(Map<String, dynamic> data, String id)
      : number = data['num'],
        localistion = data['statut'],
        type = data['type'],
        id = id;
  Map<String, dynamic> toMap() {
    return {
      "num": number,
      "statut": localistion,
      "type": type,
    };
  }
}
