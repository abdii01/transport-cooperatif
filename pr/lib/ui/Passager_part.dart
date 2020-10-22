import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Startyoutrip.dart';
import 'package:myfinalpfe/util/stationrealtimedatabase.dart';
import 'package:myfinalpfe/util/stattionreltiemdtabase.dart';

class getdatataret {
  getdata() {
    return Firestore.instance
        .collection('stationreltimedatabase')
        .getDocuments();
  }
}

class Choisietonstation extends StatefulWidget {
  List<String> listdesstation = List<String>();
  List<double> listdetem = List<double>();
  List<String> listetempartager = List<String>();
  List<String> listetempartagerid = List<String>();
  String poindedepart;
  String poindedarrive;
  String nameobus;
  Choisietonstation(
      {Key key,
      this.listdesstation,
      this.listdetem,
      this.nameobus,
      this.listetempartager,
      this.listetempartagerid,
      this.poindedepart,
      this.poindedarrive})
      : super(key: key);
  _Choisietonstation createState() => new _Choisietonstation();
}

class _Choisietonstation extends State<Choisietonstation> {
  Future getvalue() async {
    var fires = Firestore.instance;
    QuerySnapshot qn =
        await fires.collection('stationreltimedatabase').getDocuments();
    return qn.documents;
  }

  String poindepart;
  String poindarive;

  void initState() {
    super.initState();
    poindepart = widget.poindedepart;
    poindarive = widget.poindedarrive;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
          title: Text("My Bus"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Getdestinaton(),
                    ));
              })),
      body: FutureBuilder(
        future: getvalue(),
        builder: (_, snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Container(
              child: ListView.builder(
                  itemCount: widget.listdesstation.length,
                  itemBuilder: (_, intdex) {
                    return Container(
                      decoration: BoxDecoration(
                        //                    <-- BoxDecoration
                        border: Border(bottom: BorderSide()),
                      ),
                      child: ListTile(
                        title: Text(widget.listdesstation[intdex] +
                            ", estimated time: " +
                            "${widget.listdetem[intdex]}"),
                        subtitle: Text(
                            "time shared :" + widget.listetempartager[intdex]),
                        trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              FlatButton(
                                  child: Text('share you trip'),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    patagertrip(context, intdex,
                                        now);
                                  })
                            ]),
                      ),
                    );
                  }));
        },
      ),
    );
  }

  void patagertrip(BuildContext context, int intdex, DateTime now) async {
    var now1 = now.toString().split(' ');
    String now11 = now1[1];
    var no12 = now11.toString().split(':');
    String now13 = no12[0] + "." + no12[1];
    double now14 = double.parse(now13);
    print(now14.toString());
    if (await _showconfermationdialoge(context)) {
      List<String> _lisnomst = List<String>();
      List<String> _lisidst = List<String>();
      List<double> _listemp = List<double>();
      List<double> _listemp1 = List<double>();
      for (var i = 0; i < widget.listdesstation.length; i++) {
        if (i == intdex || i > intdex) {
          if (i == intdex) {
            _lisnomst.add(widget.listdesstation[i]);
            _lisidst.add(widget.listetempartagerid[i]);
            _listemp.add(now14);
          } else {
            _lisnomst.add(widget.listdesstation[i]);
            _lisidst.add(widget.listetempartagerid[i]);
            _listemp.add(widget.listdetem[i]);
          }
        }
      }
      print(_lisnomst.toString());
      print(_lisidst.toString());
      print(_listemp.toString());
      for (var y = 0; y < _listemp.length; y++) {
        if (y == _listemp.length - 1) {
        } else {
          double c = _listemp[y + 1] - _listemp[y];

          _listemp[y] = _listemp[y] + c;
          _listemp1.add(c);
        }
      }
      for (var y = 0; y < _listemp1.length; y++) {
        for (var i = 0; i < _listemp.length; i++) {
          if (i == 0) {
            _listemp[i] = _listemp[i];
          } else {
            _listemp[i] = _listemp[i] + _listemp1[y];
          }
        }
      }
      print("ccccccccccc" + _listemp.toString());
      for (var r = 0; r < _lisidst.length; r++) {
        stationreltimedatabase strtdb = stationreltimedatabase(
            nom: _lisnomst[r], id: _lisidst[r], time: _listemp[r].toString());
        firestrorestationrealtimedtabase().ubdateus(strtdb);
        if (r == _lisidst.length - 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Getdestinaton(
                poindedepart: poindepart,
                pointdarriver: poindarive,
              ),
            ),
          );
        }
      }
    }
  }

  Future<bool> _showconfermationdialoge(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text(
                "ARE you sure you want to shore your trip",
                style: TextStyle(color: Colors.red, fontSize: 15.0),
              ),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.red,
                  child: Text("yes"),
                  onPressed: () => Navigator.pop(context, true),
                ),
                FlatButton(
                  textColor: Colors.black,
                  child: Text("no"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }
}
