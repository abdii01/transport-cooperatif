import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';
import 'package:myfinalpfe/util/bus.dart';
import 'package:myfinalpfe/util/fireservisse.dart';

class Addtimetobusretour extends StatefulWidget {
  final String numerooo;
  final String nomberdevoyage;
  final String statut;
  final String nomstation;
  final String nomdutagetaller;
  final String nomdutragerretour;
  final String listimealler;
  final String listdestationintermidiaireselsecteraller;
  final String listdestationintermidiaireselsecterretour;
  final String id;

  Addtimetobusretour({
    Key key,
    this.nomstation,
    this.statut,
    this.listdestationintermidiaireselsecterretour,
    this.nomberdevoyage,
    this.numerooo,
    this.listimealler,
    this.nomdutagetaller,
    this.listdestationintermidiaireselsecteraller,
    this.nomdutragerretour,
    this.id,
  }) : super(key: key);
  @override
  _Addtimetobusretour createState() => _Addtimetobusretour();
}

class _Addtimetobusretour extends State<Addtimetobusretour> {
  List<String> listimetrajet = List<String>();
  String timeajouter;
  bool testbernombredevoyage = false;
  int nobredevoyage;
  int i = 0;
  bool _ilyaunproblem = true;
  bool timeinfrieur = true;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _presedenttimestring = "a";
  int _presedenttimesint = -1;
  int nombredevoyage;
  @override
  void initState() {
    super.initState();

    nombredevoyage = int.parse("${widget.nomberdevoyage}");
    nobredevoyage = int.parse("${widget.nomberdevoyage}");
  }

  get isedimote => widget.id != null;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(isedimote
            ? "Update time for way two To bus ${widget.numerooo}"
            : "Add time for waye Back"),
      ),
      body: Container(
          padding: EdgeInsets.all(14.0),
          child: Form(
              key: _key,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 4,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 100,
                            child: Text(
                              "Select a time of trip ${i + 1}",
                            ),
                          ),
                          Expanded(
                            child: CupertinoTimerPicker(
                              mode: CupertinoTimerPickerMode.hm,
                              onTimerDurationChanged: (data) {
                                print(data);
                                int t;
                                var splitLitstation =
                                    data.toString().split(':');

                                int u = int.parse(splitLitstation[0]);
                                print("uuuuuuuuuuu $u");

                                setState(() {
                                  _presedenttimestring = splitLitstation[0];
                                  t = int.parse(_presedenttimestring);
                                });
                                print("ooooooo $t");
                                if (_presedenttimesint > t ||
                                    _presedenttimesint == t ||
                                    t == 0) {
                                  setState(() {
                                    _ilyaunproblem = false;
                                  });
                                } else {
                                  setState(() {
                                    _ilyaunproblem = true;
                                  });
                                }

                                setState(() {
                                  timeajouter = data.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]))),
      floatingActionButton: FloatingActionButton(
          child: Icon(!testbernombredevoyage ? Icons.add : Icons.done),
          backgroundColor: Colors.blue,
          onPressed: () async {
            if (isedimote) {
              if (!testbernombredevoyage) {
                await _showconfermationdialoge(context);
              } else {
                listimetrajet.add(timeajouter);
                print(listimetrajet.toString());
                print(widget.nomdutagetaller);

                print("${widget.nomdutagetaller}");

                Bus bus = Bus(
                  number: widget.numerooo,
                  id: widget.id,
                  nomstation: widget.nomstation,
                  statut: widget.statut.toString(),
                  nombredevoyage: widget.nomberdevoyage.toString(),
                  nomtragetaller: "${widget.nomdutagetaller}",
                  listimealler: widget.listimealler.toString(),
                  listimeretourd: listimetrajet.toString(),
                  liststationtrajetaller: widget
                      .listdestationintermidiaireselsecteraller
                      .toString(),
                  listedestationtajerretour: widget
                      .listdestationintermidiaireselsecterretour
                      .toString(),
                  nomdutrajetretour: widget.nomdutragerretour.toString(),
                );
                await firestoreservice().ubdateus(bus).then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Navigationstation(
                                idex: 1,
                              )));
                });
              }
            } else {
              print(nobredevoyage);
              if (!testbernombredevoyage) {
                await _showconfermationdialoge(context);
              } else {
                listimetrajet.add(timeajouter);
                print(listimetrajet.toString());
                print(widget.nomdutagetaller);

                print("${widget.nomdutagetaller}");

                Bus bus = Bus(
                  number: widget.numerooo,
                  nomstation: widget.nomstation,
                  statut: widget.statut.toString(),
                  nombredevoyage: widget.nomberdevoyage.toString(),
                  nomtragetaller: "${widget.nomdutagetaller}",
                  listimealler: widget.listimealler.toString(),
                  listimeretourd: listimetrajet.toString(),
                  liststationtrajetaller: widget
                      .listdestationintermidiaireselsecteraller
                      .toString(),
                  listedestationtajerretour: widget
                      .listdestationintermidiaireselsecterretour
                      .toString(),
                  nomdutrajetretour: widget.nomdutragerretour.toString(),
                );
                await firestoreservice().addbus(bus).then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Navigationstation(
                                idex: 1,
                              )));
                });
              }
            }
          }),
    );
  }

  Future<bool> _showconfermationdialoge(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text("ARE You choor about the time"),
              actions: <Widget>[
                FlatButton(
                    textColor: Colors.black,
                    child: Text("yes"),
                    onPressed: () async {
                      /*
          String listtimealle= widget.listimealler.toString().replaceAll(':', '.');
          listtimealle=listtimealle.toString().replaceAll('[', '');
          listtimealle= listtimealle.toString().replaceAll(']', '');
          var listtimepressplit =  listtimealle.toString().split(',');
          print(listtimepressplit.toString());
          */

                      if (!testbernombredevoyage &&
                          _ilyaunproblem &&
                          _presedenttimestring != "a") {
                        if (i < nobredevoyage - 1) {
                          listimetrajet.add(timeajouter);
                          var splitLitstation =
                              timeajouter.toString().split(':');
                          setState(() {
                            _presedenttimesint = int.parse(splitLitstation[0]);
                          });

                          i++;
                        } else {
                          setState(() {
                            testbernombredevoyage = true;
                          });
                        }
                      } else {
                        await checkpassword(context);
                      }
                      Navigator.pop(context, false);
                    }),
              ],
            ));
  }

  Future<bool> checkpassword(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text(" check the time "),
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
