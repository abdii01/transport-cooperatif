import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';
import 'package:myfinalpfe/ui/makeline.dart';

class getdatabus {
  getdata() {
    return Firestore.instance.collection('Station').getDocuments();
  }
}

class addnewtrajet extends StatefulWidget {
  String id;
  String poindapart;
  String poindariver;
  String nombredevoygae;
  String nomdutrager;
  addnewtrajet(
      {Key key,
      this.id,
      this.poindapart,
      this.poindariver,
      this.nombredevoygae,
      this.nomdutrager})
      : super(key: key);

  @override
  _addnewtrajet createState() => _addnewtrajet();
}

class _addnewtrajet extends State<addnewtrajet> {
  Future getsation() async {
    Firestore db = Firestore.instance;
    QuerySnapshot qr = await db.collection('Station').getDocuments();
    return qr.documents;
  }

  String _dropdownValuepointdudepart;
  TextEditingController _typecontrolerpointdudepart =
      new TextEditingController();
  List<String> _dropdownItemspointdudepart = List<String>();

  String _dropdownValuepointfinal;
  TextEditingController _typecontrolerpointfinal = new TextEditingController();
  List<String> _dropdownItemspointfinal = List<String>();
  String _dropdownValuenombredestaton;
  TextEditingController _typecontrolernombredestaton =
      new TextEditingController();
  List<String> _dropdownItenombredestaton = List<String>();

  Future getsationns() async {
    Firestore db = Firestore.instance;
    await db
        .collection('Station')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        if (snapshot.documents[i].data['type'] == "TERMINAL") {
          _dropdownItemspointdudepart.add(snapshot.documents[i].data['num']);
        }
      }
      if (isedimote) {
        _dropdownValuepointdudepart = "${widget.poindapart}";
        _typecontrolerpointdudepart.text = _dropdownValuepointdudepart;
      } else {
        _dropdownValuepointdudepart = _dropdownItemspointdudepart[0];
        _typecontrolerpointdudepart.text = _dropdownValuepointdudepart;
      }
    });
  }

  List<String> listdststrajet = List<String>();

  Future getsationns2() async {
    Firestore db = Firestore.instance;
    await db.collection('trajet').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        setState(() {
          listdststrajet.add((snapshot.documents[i].data['num']));
        });
      }
    });
  }

  Future getsationns3() async {
    Firestore db = Firestore.instance;
    await db
        .collection('Station')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        if (snapshot.documents[i].data['type'] == "TERMINAL") {
          _dropdownItemspointfinal.add(snapshot.documents[i].data['num']);
        }
      }

      if (isedimote) {
        _dropdownValuepointfinal = "${widget.poindariver}";
        _typecontrolerpointfinal.text = _dropdownValuepointfinal;
      } else {
        _dropdownValuepointfinal = _dropdownItemspointfinal[0];
        _typecontrolerpointfinal.text = _dropdownValuepointfinal;
      }
    });
  }

  List<String> listdesnomdesstation;

  void initState() {
    super.initState();
    getsationns();
    getsationns2();
    getsationns3();
    for (var i = 1; i < 10; i++) {
      _dropdownItenombredestaton.add("$i");
    }
    if (isedimote) {
      _dropdownValuenombredestaton = "${widget.nombredevoygae}";
      _typecontrolernombredestaton.text = _dropdownValuenombredestaton;
    } else {
      _dropdownValuenombredestaton = _dropdownItenombredestaton[0];
      _typecontrolernombredestaton.text = _dropdownValuenombredestaton;
    }
  }

  get isedimote => widget.id != null;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isedimote ? 'Update ${widget.nomdutrager}' : 'Add ride',
          style: TextStyle(fontSize: 15.0),
        ),
      ),
      body: FutureBuilder(
          future: getsation(),
          builder: (_, snapshot) {
            if (snapshot.hasError ||
                !snapshot.hasData ||
                _dropdownItemspointdudepart.isEmpty ||
                _dropdownItemspointfinal.isEmpty)
              return Center(
                child: CircularProgressIndicator(),
              );

            Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, intdex) {}));

            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                DropdownButtonHideUnderline(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new InputDecorator(
                        decoration: InputDecoration(
                          filled: false,
                          hintText: 'Choose Location',
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          labelText: _dropdownValuepointdudepart == null
                              ? 'type'
                              : 'Location',
                          //  errorText: _errorText,
                        ),
                        // isEmpty: _dropdownValue == null,
                        child: new DropdownButton<String>(
                          value: _dropdownValuepointdudepart,
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                          isDense: true,
                          onChanged: (String newValue) {
                            print('value change');
                            print(newValue);
                            setState(() {
                              _dropdownValuepointdudepart = newValue;
                              _typecontrolerpointdudepart.text =
                                  _dropdownValuepointdudepart;
                            });
                          },
                          items:
                              _dropdownItemspointdudepart.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                DropdownButtonHideUnderline(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new InputDecorator(
                        decoration: InputDecoration(
                          filled: false,
                          hintText: 'Choose Destination',
                          prefixIcon: Icon(
                            Icons.location_off,
                            color: Colors.yellow,
                          ),
                          labelText: _dropdownValuepointfinal == null
                              ? 'Destination'
                              : 'Destination',
                          //  errorText: _errorText,
                        ),
                        // isEmpty: _dropdownValue == null,
                        child: new DropdownButton<String>(
                          value: _dropdownValuepointfinal,
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                          isDense: true,
                          onChanged: (String newValue) {
                            print('value change');
                            print(newValue);
                            setState(() {
                              _dropdownValuepointfinal = newValue;
                              _typecontrolerpointfinal.text =
                                  _dropdownValuepointfinal;
                            });
                          },
                          items: _dropdownItemspointfinal.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                DropdownButtonHideUnderline(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new InputDecorator(
                        decoration: InputDecoration(
                          filled: false,
                          hintText: 'Number of intrmidiate  station',
                          prefixIcon: Icon(
                            Icons.format_list_numbered_rtl,
                            color: Colors.green,
                          ),
                          labelText: _dropdownValuenombredestaton == null
                              ? 'Number of  intrmidiate station'
                              : 'Number of  intrmidiate station',
                        ),
                        // isEmpty
                        child: new DropdownButton<String>(
                          value: _dropdownValuenombredestaton,
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                          isDense: true,
                          onChanged: (String newValue) {
                            print('value change');
                            print(newValue);
                            setState(() {
                              _dropdownValuenombredestaton = newValue;
                              _typecontrolernombredestaton.text =
                                  _dropdownValuenombredestaton;
                            });
                          },
                          items: _dropdownItenombredestaton.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(isedimote ? Icons.edit : Icons.navigate_next),
        backgroundColor: Colors.blue,
        onPressed: () async {
          if (isedimote) {
            if (!testtrajetexist(_typecontrolerpointdudepart.text,
                    _typecontrolerpointfinal.text) &&
                _typecontrolerpointdudepart.text +
                        " To " +
                        _typecontrolerpointfinal.text !=
                    "${widget.nomdutrager}") {
              await trajetexist(context);
            } else {
              if (_typecontrolerpointdudepart.text !=
                  _typecontrolerpointfinal.text) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Makingkine(
                      nom: _typecontrolerpointdudepart.text +
                          " To " +
                          _typecontrolerpointfinal.text,
                      pointdarriver: _typecontrolerpointfinal.text,
                      pointdupepart: _typecontrolerpointdudepart.text,
                      nombredestation: _typecontrolernombredestaton.text,
                      id: widget.id,
                    ),
                  ),
                );
              } else {
                await checkythenameofthestation(context);
              }
            }
          } else {
            if (!testtrajetexist(_typecontrolerpointdudepart.text,
                _typecontrolerpointfinal.text)) {
              await trajetexist(context);
            } else {
              if (_typecontrolerpointdudepart.text !=
                  _typecontrolerpointfinal.text) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Makingkine(
                      nom: _typecontrolerpointdudepart.text +
                          " To " +
                          _typecontrolerpointfinal.text,
                      pointdarriver: _typecontrolerpointfinal.text,
                      pointdupepart: _typecontrolerpointdudepart.text,
                      nombredestation: _typecontrolernombredestaton.text,
                    ),
                  ),
                );
              } else {
                await checkythenameofthestation(context);
              }
            }
          }
        },
      ),
    );
  }

  Future<bool> checkythenameofthestation(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text(
                "Your Location should not be your destination",
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

  Future<bool> trajetexist(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text(
                "This way exist",
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

  bool testtrajetexist(String dep, String arriver) {
    for (var i = 0; i < listdststrajet.length; i++) {
      if (listdststrajet[i] == dep + " To " + arriver) {
        return false;
      }
    }
    return true;
  }
}
