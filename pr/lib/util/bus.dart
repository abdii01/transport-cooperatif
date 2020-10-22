class Bus {
  final String number;
  final String statut;
  final String id;
  final String nombredevoyage;
  String listimealler;
  String listimeretourd;
  String liststationtrajetaller;
  String listedestationtajerretour;
  final String nomstation;
  final String nomdutrajetretour;
  final String nomtragetaller;
  Bus(
      {this.number,
      this.statut,
      this.id,
      this.listedestationtajerretour,
      this.listimealler,
      this.listimeretourd,
      this.liststationtrajetaller,
      this.nombredevoyage,
      this.nomdutrajetretour,
      this.nomstation,
      this.nomtragetaller});

  Bus.fromMap(Map<String, dynamic> data, String id)
      : number = data['num'],
        statut = data['statut'],
        nomstation = data['nomstation'],
        nomdutrajetretour = data['nomdutrajetretour'],
        nomtragetaller = data['nomtragetaller'],
        nombredevoyage = data['nombredevoyage'],
        listimealler = data['listimealler'],
        listimeretourd = data['listimeretourd'],
        liststationtrajetaller = data['liststationtrajetaller'],
        listedestationtajerretour = data['listedestationtajerretour'],
        id = id;
  Map<String, dynamic> toMap() {
    return {
      'num': number,
      'statut': statut,
      'nomstation': nomstation,
      'nomdutrajetretour': nomdutrajetretour,
      'nomtragetaller': nomtragetaller,
      'nombredevoyage': nombredevoyage,
      'listimealler': listimealler,
      'listimeretourd': listimeretourd,
      'liststationtrajetaller': liststationtrajetaller,
      'listedestationtajerretour': listedestationtajerretour,
    };
  }
}
