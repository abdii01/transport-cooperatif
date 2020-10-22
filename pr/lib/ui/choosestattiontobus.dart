import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Adtimeforeverybus.dart';

class getdatabus {
  getdata() {
    return Firestore.instance.collection('trajet').getDocuments();
  }
}

class staatindata extends StatefulWidget {
  final String numerooo;
  final String nomberdevoyage;
  String nomstation;
  int type = 0;
  List<String> listoftime = List<String>();
  final String id;
  bool fir = false;
  String staut;
  staatindata(
      {Key key,
      this.numerooo,
      this.nomberdevoyage,
      this.nomstation,
      this.fir,
      this.id,
      this.staut,
      this.type,
      this.listoftime})
      : super(key: key);
  @override
  _staatindata createState() => _staatindata();
}

class _staatindata extends State<staatindata> {
  List<String> _listdetrajet = new List<String>();
  List<bool> inputs = new List<bool>();
  List<String> _alisttrajetselected = new List<String>();
  List<String> _listdestationintermidiaireselsecter = new List<String>();
  List<String> listdesstationintermidiare = new List<String>();
  Future getsationns2() async {
    Firestore db = Firestore.instance;
    await db.collection('trajet').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        if (snapshot.documents[i].data['pointdepart'] == widget.nomstation) {
          _listdetrajet.add(snapshot.documents[i].data['num']);
          listdesstationintermidiare
              .add(snapshot.documents[i].data['station'].toString());
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getsationns2();
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

  bool _testnombredetajettselecter() {
    int j = 0;
    for (var r = 0; r < _listdetrajet.length; r++) {
      if (inputs[r] == true) {
        j++;
      }
    }
    if (j > 1 || j == 0) return false;
    return true;
  }

  bool _addlistdestajetselecter() {
    if (!_testnombredetajettselecter()) {
      return false;
    } else {
      for (var r = 0; r < _listdetrajet.length; r++) {
        if (inputs[r] == true) {
          _alisttrajetselected.add(_listdetrajet[r]);
          _listdestationintermidiaireselsecter
              .add(listdesstationintermidiare[r]);
        }
      }
      return true;
    }
  }

  Future getsation() async {
    Firestore db = Firestore.instance;
    QuerySnapshot qr = await db.collection('trajet').getDocuments();
    return qr.documents;
  }

  get isedimote => widget.id != null;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: FutureBuilder(
          future: getsation(),
          builder: (_, snapshot) {
            if (snapshot.hasError || !snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (_listdetrajet.length == 0)
              return MaterialApp(
                  home: Scaffold(
                body: Container(
                    child: Center(
                  child: Text(
                    "there is no way  from this station",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15.0,
                    ),
                  ),
                )),
              ));
            return MaterialApp(
                home: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.blue,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    body: Column(children: <Widget>[
                      Text(
                        isedimote
                            ? "Update the waye one for ${widget.numerooo}"
                            : "Choose way one for your bus",
                        style: TextStyle(fontSize: 20.0, color: Colors.red),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: _listdetrajet.length,
                              itemBuilder: (_, index) {
                                return CheckboxListTile(
                                  checkColor: Colors.white,
                                  activeColor: Colors.blue,
                                  title: Text(_listdetrajet[index]),
                                  onChanged: (bool value) {
                                    ItemChange(value, index);
                                  },
                                  value: inputs[index],
                                );
                              }))
                    ]),
                    floatingActionButton: FloatingActionButton(
                        child: Icon(Icons.navigate_next),
                        backgroundColor: Colors.blue,
                        onPressed: () async {
                          if (isedimote) {
                            if (!_addlistdestajetselecter()) {
                              await checkythenameofthestation(context);
                            } else {
                              print(listdesstationintermidiare.toString());

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Addtimetobus(
                                    nomstation: widget.nomstation,
                                    nomberdevoyage: widget.nomberdevoyage,
                                    statut: widget.staut,
                                    numerooo: widget.numerooo,
                                    nomdutagetaller:
                                        _alisttrajetselected.toString(),
                                    listdestationintermidiaireselsecter:
                                        _listdestationintermidiaireselsecter
                                            .toString(),
                                    id: widget.id,
                                  ),
                                ),
                              );
                            }
                          } else {
                            if (!_addlistdestajetselecter()) {
                              await checkythenameofthestation(context);
                            } else {
                              print(listdesstationintermidiare.toString());

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Addtimetobus(
                                    nomstation: widget.nomstation,
                                    nomberdevoyage: widget.nomberdevoyage,
                                    statut: widget.staut,
                                    numerooo: widget.numerooo,
                                    nomdutagetaller:
                                        _alisttrajetselected.toString(),
                                    listdestationintermidiaireselsecter:
                                        _listdestationintermidiaireselsecter
                                            .toString(),
                                  ),
                                ),
                              );
                            }
                          }
                        })));
          }),
    );
  }

  Future<bool> checkythenameofthestation(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text(
                "You have to choose one path",
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
}
