import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Trajetretourt.dart';

class Addtimetobus extends StatefulWidget {
  final String numerooo;
  final String nomberdevoyage;
  final String nomstation;
  final String id;
  String statut;
  String nomdutagetaller;
  String nomdutragerretour;
  String listdestationintermidiaireselsecter;

  Addtimetobus({
    Key key,
    this.nomstation,
    this.statut,
    this.nomberdevoyage,
    this.listdestationintermidiaireselsecter,
    this.numerooo,
    this.nomdutagetaller,
    this.nomdutragerretour,
    this.id,
  }) : super(key: key);
  @override
  _Addtimetobus createState() => _Addtimetobus();
}

class _Addtimetobus extends State<Addtimetobus> {
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
  @override
  void initState() {
    super.initState();
    testbernombredevoyage;

    i;
    listimetrajet;
    timeajouter;
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
            ? "Update time for waye one  ${widget.numerooo}"
            : "Add time for waye one"),
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
                              "Select a time of trip  ${i + 1}",
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
                                

                                setState(() {
                                  _presedenttimestring = splitLitstation[0];
                                  t = int.parse(_presedenttimestring);
                                });
                           
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
                String _pointfinal =
                    returnpoinfinaltrajet(widget.nomdutagetaller);

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Tragerretour(
                            numerooo: widget.numerooo,
                            nomstation: widget.nomstation,
                            nomberdevoyage: widget.nomberdevoyage,
                            staut: widget.statut,
                            pointfinal: _pointfinal,
                            nomtrajeraller: widget.nomdutagetaller,
                            listoftimealler: listimetrajet,
                            listdestationintermidiaireselsecter:
                                widget.listdestationintermidiaireselsecter,
                            id: widget.id,
                          )),
                );
              }
            } else {
              if (!testbernombredevoyage) {
                await _showconfermationdialoge(context);
              } else {
                listimetrajet.add(timeajouter);
                print(listimetrajet.toString());
                print(widget.nomdutagetaller);
                String _pointfinal =
                    returnpoinfinaltrajet(widget.nomdutagetaller);

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Tragerretour(
                            numerooo: widget.numerooo,
                            nomstation: widget.nomstation,
                            nomberdevoyage: widget.nomberdevoyage,
                            staut: widget.statut,
                            pointfinal: _pointfinal,
                            nomtrajeraller: widget.nomdutagetaller,
                            listoftimealler: listimetrajet,
                            listdestationintermidiaireselsecter:
                                widget.listdestationintermidiaireselsecter,
                          )),
                );
              }
              /*
  Bus bus=       Bus(number: "${widget.numerooo}",listime: listimetrajet,nomstation: "${widget.nomstation}",statut: "${widget.statut}");
   await firestoreservice().addbus(bus).then((value) {
 Navigator.push(context, MaterialPageRoute(builder: (_) => Navigationstation()));
    });
  */
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

  String returnpoindudepartdupremiretrajet(String a) {
    String nom = a.toString().replaceAll('[', '');
    nom = nom.toString().replaceAll(']', '');
    nom = nom.toString().replaceAll('-', ',');
    nom = nom.toString().replaceAll('>', '');
    var split = nom.toString().split(',');
    return split[0];
  }

  String returnpoinfinaltrajet(String a) {
    String nom = a.toString().replaceAll('[', '');
    nom = nom.toString().replaceAll(']', '');

    var split = nom.toString().split(' To ');
    return split[1];
  }
}
