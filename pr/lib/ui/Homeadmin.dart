import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/util/Station.dart';
import 'package:myfinalpfe/util/firestoreservicestation.dart';

class Checkstation {
  numeroexustounom(String a) {
    return Firestore.instance
        .collection('Station')
        .where("num", isEqualTo: a)
        .getDocuments();
  }
}

class Homesation extends StatefulWidget {
  String id;
  String nomstation;
  Homesation({Key key, this.id, this.nomstation}) : super(key: key);

  @override
  _Homesation createState() => _Homesation();
}

class _Homesation extends State<Homesation> {
  List<Station> station;
  List name;
  List statut;
  FocusNode _numberfocsunofe = new FocusNode();
  FocusNode _loctionfocus = new FocusNode();
  FocusNode _passwordfocs = new FocusNode();

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _numTextEditingController = new TextEditingController();
  TextEditingController _localistionEditorcontoler =
      new TextEditingController();

  TextEditingController _passwordEditorcontoler = new TextEditingController();
  bool _enabled = false;

  var _statucurencies = ['work', 'dont work'];
  var statutselectededd = 'work';
  String lenumerovalue, lestatutvalue;
  Firestore db = Firestore.instance;
  String a = "y";
  String t;
  testnameexist(String a) async {
    await Checkstation().numeroexustounom(a).then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        setState(() {
          a = "a";
        });
      }
    });
  }

  List<String> listdestation = new List<String>();
  List<String> listdeslocalistion = new List<String>();

  int j;
  final DocumentReference documentReference =
      Firestore.instance.document("Station");
  Future getsation() async {
    Firestore db = Firestore.instance;
    QuerySnapshot qr = await db.collection('Station').getDocuments();
    return qr.documents;
  }

  Future getsationns() async {
    Firestore db = Firestore.instance;
    await db
        .collection('Station')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++)
        listdestation.add(snapshot.documents[i].data['num']);
    });
    await db
        .collection('Station')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++)
        listdeslocalistion.add(snapshot.documents[i].data['statut']);
    });
  }

  @override
  void initState() {
    super.initState();

    getsationns();
  }

  get isedimote => widget.id != null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Station'),
      ),
      body: FutureBuilder(
          future: getsation(),
          builder: (_, snapshot) {
            if (snapshot.hasError || !snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );

            Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, intdex) {
                      for (j = 0; j < snapshot.data.length; j++) {
                        listdestation.add(snapshot.data[j].data["num"]);
                      }
                    }));

            return Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      textInputAction: TextInputAction.send,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_numberfocsunofe);
                        setState(() {
                          a = _numTextEditingController.text;
                        });
                      },
                      controller: _numTextEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "give nmae to the station";
                        if (!testifthestationexist(value))
                          return "this name exist";
                      },
                      decoration: InputDecoration(
                        labelText: "name",
                        icon: Icon(Icons.home),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_loctionfocus);
                      },
                      controller: _localistionEditorcontoler,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "give your  station loction";
                        if (!testiftheslocalistionexist(value))
                          return "this localistion exist";
                      },
                      decoration: InputDecoration(
                        labelText: "localisation",
                        icon: Icon(Icons.add_location),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_passwordfocs);
                      },
                      controller: _passwordEditorcontoler,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "enter your password";
                        if (!validateMobile(value)) {
                          return "your password have to be 8 ca";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "password",
                        icon: Icon(Icons.vpn_key),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    FlatButton(
                        child: Text('UPDATE'),
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                        onPressed: () async {
                          if (_localistionEditorcontoler.text.isEmpty ||
                              _numTextEditingController.text.isEmpty ||
                              _passwordEditorcontoler.text.isEmpty) {
                            await youhavefullallcone(context);
                          } else {
                            if (!testifthestationexist(
                                _numTextEditingController.text)) {
                              await checkythenameofthestation(context);
                            } else {
                              if (!validateMobile(
                                  _passwordEditorcontoler.text)) {
                                await checkpassword(context);
                              } else {
                                Station station = Station(
                                  number: _numTextEditingController.text,
                                  localistion: _localistionEditorcontoler.text,
                                );
                                await firestrorestation()
                                    .addStation(station)
                                    .then((value) {
                                  Navigator.of(context)
                                      .pushNamed('/addnewstation');
                                });
                              }
                            }
                          }
                        }),
                  ],
                ));
          }),
    );
  }

  Future<bool> checkythenameofthestation(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text("name of station exist choose other name"),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.black,
                  child: Text("ok"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }

  Future<bool> youhavefullallcone(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text("you have to give all information"),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.black,
                  child: Text("ok"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }

  Future<bool> theloctiongivenexist(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text(" there is alredy in loction at you loction  "),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.black,
                  child: Text("ok"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }

  Future<bool> checkpassword(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text(" the passworve have to be 8 charracters "),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.black,
                  child: Text("ok"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }

  bool testifthestationexist(String a) {
    for (var j = 0; j < listdestation.length; j++) {
      if (listdestation[j] == a) {
        return false;
      }
    }
    return true;
  }

  bool testiftheslocalistionexist(String a) {
    for (var j = 0; j < listdeslocalistion.length; j++) {
      if (listdeslocalistion[j] == a) {
        return false;
      }
    }
    return true;
  }

  bool validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length < 8)
      return false;
    else
      return true;
  }
}
