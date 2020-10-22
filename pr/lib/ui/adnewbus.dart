import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/choosestattiontobus.dart';
import 'package:myfinalpfe/util/Station.dart';

class addnewbus extends StatefulWidget {
  final String id;
  String nomstation;
  String nonmdubus;
  String nombredevoyage;
  String nomdustation;

  int type = 0;
  addnewbus({
    Key key,
    this.nomstation,
    this.id,
    this.type,
    this.nomdustation,
    this.nombredevoyage,
    this.nonmdubus,
  }) : super(key: key);
  @override
  _addnewbusState createState() => _addnewbusState();
}

class _addnewbusState extends State<addnewbus> {
  List<Station> station;
  List name;
  List statut;
  List<String> listdestation = List<String>();
  TextEditingController _nombredevoyagecontrolet = new TextEditingController();
  String _dropdownValue;
  List<String> _dropdownItems = List<String>();
  TextEditingController _statutcontroler = new TextEditingController();
  String _dropdownValue2;
  List<String> _dropdownItems2 = List<String>();
  String _dropdownValuepointdudepart;
  TextEditingController _typecontrolerpointdudepart =
      new TextEditingController();
  List<String> _dropdownItemspointdudepart = List<String>();
  List<String> listdesbus = List<String>();
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
      _dropdownValuepointdudepart = _dropdownItemspointdudepart[0];

      _typecontrolerpointdudepart.text = _dropdownValuepointdudepart;
    });
  }

  Future getsationns2() async {
    Firestore db = Firestore.instance;
    await db.collection('buus').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        listdesbus.add(snapshot.documents[i].data['num']);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getsationns();
    getsationns2();
    for (var i = 1; i < 11; i++) {
      _dropdownItems.add("$i");
    }
    if (isedimote) {
      _numTextEditingController.text = "${widget.nonmdubus}";
      _dropdownValue = _dropdownItems[0];
      _nombredevoyagecontrolet.text = _dropdownValue;
      _dropdownItems2.add("in order");
      _dropdownItems2.add("out of order");
      _dropdownValue2 = _dropdownItems2[0];
      _statutcontroler.text = _dropdownValue2;
    } else {
      _dropdownValue = _dropdownItems[0];
      _nombredevoyagecontrolet.text = _dropdownValue;
      _dropdownItems2.add("in order");
      _dropdownItems2.add("out of order");
      _dropdownValue2 = _dropdownItems2[0];
      _statutcontroler.text = _dropdownValue2;
    }
  }

  TextEditingController _numTextEditingController = new TextEditingController();
  Future getsation() async {
    Firestore db = Firestore.instance;
    QuerySnapshot qr = await db.collection('buus').getDocuments();
    return qr;
  }

  get isedimote => widget.id != null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            isedimote ? " update ${widget.nonmdubus}" : "Add bus",
            style: TextStyle(fontSize: 20.0),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: FutureBuilder(
            future: getsation(),
            builder: (_, snapshot) {
              if (snapshot.hasError ||
                  !snapshot.hasData ||
                  _dropdownItemspointdudepart.isEmpty)
                return Center(
                  child: CircularProgressIndicator(),
                );

              return Center(
                //padding: EdgeInsets.all(14.0),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _numTextEditingController,
                        validator: (value) {},
                        decoration: InputDecoration(
                          labelText: ("name of Bus"),
                          icon: Icon(
                            Icons.airport_shuttle,
                            color: Colors.yellow,
                          ),
                          border: OutlineInputBorder(),
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
                                hintText: 'Choose Location',
                                prefixIcon: Icon(
                                  Icons.settings_applications,
                                  color: Colors.black,
                                ),
                                labelText: _dropdownValuepointdudepart == null
                                    ? 'type'
                                    : 'LOcation',
                                //  errorText: _errorText,
                              ),
                              // isEmpty: _dropdownValue == null,
                              child: new DropdownButton<String>(
                                value: _dropdownValuepointdudepart,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 15),
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
                                items: _dropdownItemspointdudepart
                                    .map((String value) {
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
                                hintText: 'Choose Country',
                                prefixIcon: Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                ),
                                labelText: _dropdownValue == null
                                    ? 'how meny'
                                    : 'number of trips',
                                //  errorText: _errorText,
                              ),
                              // isEmpty: _dropdownValue == null,
                              child: new DropdownButton<String>(
                                value: _dropdownValue,
                                style: TextStyle(
                                    color: Colors.green, fontSize: 20),
                                isDense: true,
                                onChanged: (String newValue) {
                                  print('value change');
                                  print(newValue);
                                  setState(() {
                                    _dropdownValue = newValue;
                                    _nombredevoyagecontrolet.text =
                                        _dropdownValue;
                                  });
                                },
                                items: _dropdownItems.map((String value) {
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
                      const SizedBox(
                        height: 10.0,
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
                                hintText: 'Choose choose statut',
                                prefixIcon: Icon(
                                  Icons.filter_vintage,
                                  color: Colors.red,
                                ),
                                labelText: _dropdownValue2 == null
                                    ? 'how meny'
                                    : 'Status',
                                //  errorText: _errorText,
                              ),
                              // isEmpty: _dropdownValue == null,
                              child: new DropdownButton<String>(
                                value: _dropdownValue2,
                                style: TextStyle(
                                    color: Colors.green, fontSize: 20),
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _dropdownValue2 = newValue;
                                    _statutcontroler.text = _dropdownValue2;
                                  });
                                },
                                items: _dropdownItems2.map((String value) {
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
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
            child: Icon(isedimote ? Icons.edit : Icons.navigate_next),
            backgroundColor: Colors.blue,
            onPressed: () async {
              if (isedimote) {
                if (_numTextEditingController.text.isEmpty) {
                  await _showconfermationdialoge(context);
                } else {
                  if (!testrerisnameexist(_numTextEditingController.text) &&
                      _numTextEditingController.text != widget.nonmdubus) {
                    await _showconfermationdialog(context);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => staatindata(
                                numerooo: _numTextEditingController.text,
                                nomstation: _typecontrolerpointdudepart.text,
                                nomberdevoyage: _nombredevoyagecontrolet.text,
                                staut: _statutcontroler.text,
                                type: widget.type,
                                id: widget.id,
                              )),
                    );
                  }
                }
              } else {
                if (_numTextEditingController.text.isEmpty) {
                  await _showconfermationdialoge(context);
                } else {
                  if (!testrerisnameexist(_numTextEditingController.text)) {
                    await _showconfermationdialog(context);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => staatindata(
                                numerooo: _numTextEditingController.text,
                                nomstation: _typecontrolerpointdudepart.text,
                                nomberdevoyage: _nombredevoyagecontrolet.text,
                                staut: _statutcontroler.text,
                                type: widget.type,
                              )),
                    );
                  }
                }
              }
            }));
  }

  Future<bool> _showconfermationdialoge(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text(
                "You have to give  name  to the bus",
                style: TextStyle(color: Colors.red, fontSize: 15.0),
              ),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.red,
                  child: Text("ok"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }

  Future<bool> _showconfermationdialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text(
                "This name exist",
                style: TextStyle(color: Colors.red, fontSize: 15.0),
              ),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.red,
                  child: Text("ok"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }

  bool testrerisnameexist(String a) {
    for (var i = 0; i < listdesbus.length; i++) {
      if (listdesbus[i] == a) {
        return false;
      }
    }
    return true;
  }
}
