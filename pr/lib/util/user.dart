class user {
  String nom;
  String prenom;
  String age;
  String email;
  String password;
  String id;
  user({this.nom, this.age, this.email, this.password, this.prenom, this.id});

  user.fromMap(Map<String, dynamic> data, String id)
      : nom = data['nom'],
        prenom = data['prenom'],
        password = data['password'],
        email = data['email'],
        age = data['age'],
        id = id;
  Map<String, dynamic> toMap() {
    return {
      "nom": nom,
      "prenom": prenom,
      "password": password,
      "email": email,
      "age": age,
    };
  }
}
