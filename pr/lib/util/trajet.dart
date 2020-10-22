class Trajet {
  final String nom;
  final List<String> station;
  final String poindepart;
  final String pointfinal;
  final String nombredestation;
  final String id;
  List<String> line;
  List<double> listimeline;
  Trajet(
      {this.nom,
      this.id,
      this.station,
      this.poindepart,
      this.pointfinal,
      this.nombredestation,
      this.line,
      this.listimeline});

  Trajet.fromMap(Map<String, dynamic> data, String id)
      : nom = data['num'],
        line = data['line'],
        listimeline = data['listimeline'],
        poindepart = data['pointdepart'],
        pointfinal = data['poinfinal'],
        station = data['station'],
        nombredestation = data['nombredestation'],
        id = id;
  Map<String, dynamic> toMap() {
    return {
      'num': nom,
      'listimeline': listimeline,
      'line': line,
      'pointdepart': poindepart,
      'poinfinal': pointfinal,
      'station': station,
      'nombredestation': nombredestation,
    };
  }
}
