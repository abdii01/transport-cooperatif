import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';
import 'package:myfinalpfe/ui/addnewtrjet.dart';
import 'package:myfinalpfe/util/servicetrajet.dart';
import 'package:myfinalpfe/util/trajet.dart';

class Makingkine extends StatefulWidget {
  String nom;
  String pointdupepart;
  String pointdarriver;
  String nombredestation;
  String id;

  Makingkine(
      {Key key,
      this.nom,
      this.id,
      this.pointdupepart,
      this.pointdarriver,
      this.nombredestation})
      : super(key: key);

  @override
  _Makingkine createState() => _Makingkine();
}

class _Makingkine extends State<Makingkine> {
  List<String> _iNTETRMIDIATEstation = List<String>();
  List<bool> inputs = new List<bool>();
  double distance;
  List<String> listdestationselecter = List<String>();
  List<String> listdesstationintermidiare = List<String>();
  List<String> listnomdststrajet = List<String>();
  List<String> _correctionlisdesattionselecer = List<String>();
  List<String> _listdeslocalistaion = List<String>();
  List<String> _listdestattionnnn = List<String>();
  List<String> _listmytrajet = List<String>();
  Future getsationns2() async {
    Firestore db = Firestore.instance;

    await db
        .collection('Station')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        if (snapshot.documents[i].data['type'] == "INTETRMIDIATE") {
          _iNTETRMIDIATEstation.add(snapshot.documents[i].data['num']);
        }
      }
    });
    await db
        .collection('Station')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        _listdeslocalistaion.add(snapshot.documents[i].data['statut']);
        _listdestattionnnn.add(snapshot.documents[i].data['num']);
      }
    });
  }

  Future getsationns() async {
    Firestore db = Firestore.instance;
    await db.collection('trajet').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        listdesstationintermidiare
            .add(snapshot.documents[i].data['station'].toString());
      }
    });
  }

  Future getsationns1() async {
    Firestore db = Firestore.instance;
    await db.collection('trajet').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        listnomdststrajet.add(snapshot.documents[i].data['num']);
      }
    });
  }

  Future getvalue() async {
    var fires = Firestore.instance;
    QuerySnapshot qn = await fires.collection('Station').getDocuments();
    return qn.documents;
  }

  List<double> lisdutemp = List<double>();
  bool testtrajetexist(String dep, String arriver) {
    for (var i = 0; i < listnomdststrajet.length; i++) {
      String nomtraket = listnomdststrajet[i].toString().replaceAll('-', '');
      nomtraket = nomtraket.toString().replaceAll('>', ',');
      var split = nomtraket.toString().split(',');
      if (dep == split[0] && arriver == split[1]) {
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    getsationns2();
    getsationns();
    getsationns1();
    setState(() {
      for (int i = 0; i < 200; i++) {
        inputs.add(false);
      }
    });
  }

  void ItemChange(bool val, int index) {
    setState(() {
      inputs[index] = val;
    });
  }

  void getallsectstation() async {
    for (var j = 0; j < inputs.length; j++) {
      if (inputs[j] == true) {
        for (var r = 0; r < _iNTETRMIDIATEstation.length; r++) {
          if (r == j) {
            setState(() {
              listdestationselecter.add(_iNTETRMIDIATEstation[r]);
            });
          }
        }
      }
    }

    listdestationselecter = listdestationselecter.reversed.toList();
  }
/*setState(() {

});
*/

  get isedimote => widget.id != null;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            isedimote
                ? 'Update ${widget.pointdupepart} To ${widget.pointdarriver}'
                : "CHOOSE INTETRMIDIATE STATIONS BY ORDER",
            style: TextStyle(fontSize: 10.0),
          ),
          backgroundColor: Colors.blue,
        ),
        body: FutureBuilder(
          future: getvalue(),
          builder: (_, snapshot) {
            if (snapshot.hasError || !snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                          itemCount: _iNTETRMIDIATEstation.length,
                          itemBuilder: (_, index) {
                            return CheckboxListTile(
                              checkColor: Colors.white,
                              activeColor: Colors.blue,
                              title: Text(_iNTETRMIDIATEstation[index]),
                              onChanged: (bool value) {
                                if (value == true) {
                                  _correctionlisdesattionselecer
                                      .add(_iNTETRMIDIATEstation[index]);
                                }
                                if (value == false) {
                                  _correctionlisdesattionselecer.removeWhere(
                                      (item) =>
                                          item == _iNTETRMIDIATEstation[index]);
                                }
                                ItemChange(value, index);
                              },
                              value: inputs[index],
                            );
                          }))
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(isedimote ? Icons.edit : Icons.done),
            backgroundColor: Colors.blue,
            onPressed: () async {
              retournerlocalistation("${widget.pointdupepart}");
              _listmytrajet.add(widget.pointdupepart);
              for (var i = 0; i < _correctionlisdesattionselecer.length; i++) {
                _listmytrajet.add(_correctionlisdesattionselecer[i]);
              }

              _listmytrajet.add(widget.pointdarriver);
              for (var j = 0; j < _listmytrajet.length - 1; j++) {
                String a1 = retournerlocalistation(_listmytrajet[j]);
                var splist1 = a1.toString().split(',');
                String a2 = retournerlocalistation(_listmytrajet[j + 1]);
                var splist2 = a2.toString().split(',');

                distance = calculateDistance(
                    double.parse(splist1[0]),
                    double.parse(splist1[1]),
                    double.parse(splist2[0]),
                    double.parse(splist2[1]));
                distance = distance * 1000;

                var t = calculertemp(distance);
                lisdutemp.add(t);
              }
              print(_listmytrajet.toString());
              print(lisdutemp.toString());

              //_correctionlisdesattionselecer

              int a = int.parse(widget.nombredestation);

              if (isedimote) {
                getallsectstation();
                if (listdestationselecter.length < a) {
                  checkythenameofthestation(context);
                } else {
                  if (listdestationselecter.length > a) {
                    await checkythenameofthestatione(context);
                  } else {
                    Trajet trajet = Trajet(
                        nom: widget.nom,
                        poindepart: widget.pointdupepart,
                        nombredestation: widget.nombredestation,
                        pointfinal: widget.pointdarriver,
                        station: _correctionlisdesattionselecer,
                        id: widget.id,
                        line: _listmytrajet,
                        listimeline: lisdutemp);
                    servicetrajet().ubdateus(trajet).then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Navigationstation(
                            idex: 2,
                          ),
                        ),
                      );
                    });
                  }
                }
              } else {
                getallsectstation();

                if (listdestationselecter.length < a) {
                  checkythenameofthestation(context);
                } else {
                  if (listdestationselecter.length > a) {
                    await checkythenameofthestatione(context);
                  } else {
                    Trajet trajet = Trajet(
                        nom: widget.nom,
                        poindepart: widget.pointdupepart,
                        nombredestation: widget.nombredestation,
                        pointfinal: widget.pointdarriver,
                        station: _correctionlisdesattionselecer,
                        line: _listmytrajet,
                        listimeline: lisdutemp);
                    servicetrajet().addTrajet(trajet).then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Navigationstation(
                            idex: 2,
                          ),
                        ),
                      );
                    });
                  }
                }
              }
            }));
  }

  Future<bool> checkythenameofthestation(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text(
                "YOU HAVE TO ADD MORE STATION",
                style: TextStyle(color: Colors.red, fontSize: 15.0),
              ),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.black,
                  child: Text("ok"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }

  Future<bool> checkythenameofthestatione(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text(
                " There is a problem try again ",
                style: TextStyle(color: Colors.red, fontSize: 15.0),
              ),
              actions: <Widget>[
                FlatButton(
                    textColor: Colors.black,
                    child: Text("ok"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => addnewtrajet()));
                    }),
              ],
            ));
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double calculertemp(double d) {
    return d / 50;
  }

  String retournerlocalistation(String a) {
    for (var i = 0; i < _listdestattionnnn.length; i++) {
      if (_listdestattionnnn[i] == a) {
        return _listdeslocalistaion[i];
      }
    }
  }
}
