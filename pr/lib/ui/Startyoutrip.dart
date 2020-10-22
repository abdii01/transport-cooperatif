import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Navigationbardebut.dart';
import 'package:myfinalpfe/ui/Passager_part.dart';

class getdatabus {
  getdata() {
    return Firestore.instance.collection('Station').getDocuments();
  }
}

class getdatabuss {
  getdata() {
    return Firestore.instance.collection('buus').getDocuments();
  }
}

class getdatataret {
  getdata() {
    return Firestore.instance.collection('trajet').getDocuments();
  }

  getdline() {
    return Firestore.instance.collection('trajet').getDocuments();
  }

  gettempdistance() {
    return Firestore.instance.collection('trajet').getDocuments();
  }
}

class Getdestinaton extends StatefulWidget {
  String poindedepart;
  String pointdarriver;
  Getdestinaton({Key key, this.poindedepart, this.pointdarriver})
      : super(key: key);

  @override
  _Getdestinaton createState() => _Getdestinaton();
}

class _Getdestinaton extends State<Getdestinaton> {
  TextEditingController editingController = TextEditingController();
  TextEditingController editingController1 = TextEditingController();
  List<String> listofname = List<String>();
  List<String> listostatut = List<String>();
  List<String> listostation = List<String>();
  List listbusinstation = List<String>();
  List listbusinstation1 = List<String>();
  List<double> _templistdechaquestation = List<double>();
  List items2 = List<String>();
  List ajouterbusin = List<String>();
  List<String> buuslist = List<String>();
  var duplicateItems = List<String>();
  List<String> lsistbus2 = List<String>();
  List<String> litdistance = List<String>();
  var items = List<String>();
  var duplicateItems1 = List<String>();
  List<String> _listdesbus = List<String>();
  List<String> _nomdutrajetaller = List<String>();
  String votrebus = "";
  String votretemp = "";
  List<String> lisdesdetrajet = List<String>();
  List<String> _nomdutrajetretour = List<String>();
  List<String> _listtimealler = List<String>();
  List<String> _listtimeretour = List<String>();
  var items1 = List<String>();

  List<String> _listdesstation = List<String>();
  List<String> _listnomstation = List<String>();
  List<String> _listdesstatation = List<String>();
  List<String> _lisdesdocumetid = List<String>();
  List<String> _listdesstatation1 = List<String>();
  List<String> _lisdesdocumetid1 = List<String>();

  Future getvalue() async {
    var fires = Firestore.instance;
    QuerySnapshot qn = await fires.collection('Station').getDocuments();
    return qn.documents;
  }

  Future getsationns() async {
    Firestore db = Firestore.instance;
    await db
        .collection('stationreltimedatabase')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        _listnomstation.add(snapshot.documents[i].data['nom']);
      }
    });
    await db
        .collection('stationreltimedatabase')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        _listdesstatation.add(snapshot.documents[i].data['time']);
      }
    });
    await db
        .collection('stationreltimedatabase')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        _lisdesdocumetid.add(snapshot.documents[i].documentID);
      }
    });
  }

  Future getsationns2() async {
    Firestore db = Firestore.instance;
    await db.collection('buus').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        _listdesbus.add(snapshot.documents[i].data['num']);
      }
    });
    await db.collection('buus').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        _nomdutrajetaller.add(snapshot.documents[i].data['nomtragetaller']);
      }
    });
    await db.collection('buus').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        _nomdutrajetretour.add(snapshot.documents[i].data['nomdutrajetretour']);
      }
    });
    await db.collection('buus').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        _listtimealler
            .add(snapshot.documents[i].data['listimealler'].toString());
      }
    });
    await db.collection('buus').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        _listtimeretour
            .add(snapshot.documents[i].data['listimeretourd'].toString());
      }
    });
  }

  List<String> listtiementrelesstation = List<String>();
  void getalstationbus(var statation1, List<String> buss) async {
    String statation;
    List<String> liitstbus = List<String>();
    await getdatabuss().getdata().then((QuerySnapshot docs) {
      // List<String> numerodebus =List<String>();
      for (var i = 0; i < docs.documents.length; i++) {
        statation =
            docs.documents[i].data['station'].toString().replaceAll(']', '');
        statation = statation.toString().replaceAll('[', '');
        statation = statation.toString().replaceAll(' ', '');

        var splitLitstation = statation.toString().split(',');
        for (var i in splitLitstation) {
          lsistbus2.add(i);
        }
        print("yyyyyyy${lsistbus2.length}");
        for (var j = 0; j < lsistbus2.length; j++) {
          if (lsistbus2[j] == statation1) {
            print("je suis la");
            liitstbus.add(docs.documents[i].data['num']);
            print("le premrer" + liitstbus.toString());
          }
        }
        lsistbus2.clear();
      }
    });
    setState(() {
      buss.addAll(liitstbus);
      print("iiiiiiiii" + buss.toString());
    });
  }

  final dbref = FirebaseDatabase.instance.reference();
  List liistofbus = List<String>();
  int i;
  List buslis = List<String>();
  List adbuslis = List<String>();
  TableRow al;
  List<String> lineoftrajet = List<String>();
  get isedimote => widget.poindedepart != null;
  @override
  void initState() {
    getdatabus().getdata().then((QuerySnapshot docs) {
      for (i = 0; i < docs.documents.length; i++) {
        duplicateItems.add(docs.documents[i].data['num']);
        liistofbus.add(docs.documents[i].data['bus'].toString());
      }
    });
    if (isedimote) {
      editingController.text = widget.poindedepart;
      editingController1.text = widget.pointdarriver;
    }
    items.addAll(duplicateItems);
    items2.addAll(listbusinstation1);
    getdatabus().getdata().then((QuerySnapshot docs) {
      for (i = 0; i < docs.documents.length; i++) {
        duplicateItems1.add(docs.documents[i].data['num']);
      }
    });
    items1.addAll(duplicateItems1);
    getdatataret().getdata().then((QuerySnapshot docs) {
      for (i = 0; i < docs.documents.length; i++) {
        lisdesdetrajet.add(docs.documents[i].data['num']);
      }
    });
    getdatataret().getdline().then((QuerySnapshot docs) {
      for (i = 0; i < docs.documents.length; i++) {
        lineoftrajet.add(docs.documents[i].data['line'].toString());
      }
    });
    getdatataret().gettempdistance().then((QuerySnapshot docs) {
      for (i = 0; i < docs.documents.length; i++) {
        listtiementrelesstation
            .add(docs.documents[i].data['listimeline'].toString());
      }
    });
    super.initState();
    getsationns2();
    getsationns();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return new Scaffold(
        appBar: AppBar(
          title: new Text("line"),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Navigationbardebus(),
                  ),
                );
              }),
        ),
        body: FutureBuilder(
          future: getvalue(),
          builder: (_, snapshot) {
            if (snapshot.hasError || !snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      controller: editingController,
                      decoration: InputDecoration(
                          labelText: "depart",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(items[index]),
                        onTap: () {
                          getalstationbus(items[index], buslis);
                          setState(() {
                            //
                            buslis.clear();
                            editingController.text = items[index];
                            items.clear();
                          });
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        filterSearchResults1(value);
                      },
                      controller: editingController1,
                      decoration: InputDecoration(
                          labelText: "destination",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: items1.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(items1[index]),
                        onTap: () {
                          setState(() {
                            editingController1.text = items1[index];

                            items1.clear();
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(isedimote ? Icons.done : Icons.call_split),
          backgroundColor: Colors.black,
          onPressed: () async {
            retounerlesdubu(now);
            String liiine;
            String lt = lisdesdetrajet.toString().replaceAll('[', '');
            lt = lt.toString().replaceAll(']', '');
            lt = lt.replaceAll(' ', '');
            var splilenomdutrajet = lt.toString().split(',');
            for (var i = 0; i < splilenomdutrajet.length; i++) {
              if (splilenomdutrajet[i] ==
                  editingController.text + "To" + editingController1.text) {
                liiine = lineoftrajet[i].toString();
              }
            }
            getlisttimedutrajet(votretemp);

            liiine = liiine.toString().replaceAll('[', '');
            liiine = liiine.toString().replaceAll(']', '');
            var liiine1 = liiine.toString().split(',');
            for (var i in liiine1) {
              _listdesstation.add(i);
            }
            print(votretemp);
            getdata(_listdesstation);
            print(_listdesstatation1.toString());
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Choisietonstation(
                  nameobus: votrebus,
                  listdesstation: _listdesstation,
                  listdetem: _templistdechaquestation,
                  listetempartager: _listdesstatation1,
                  listetempartagerid: _lisdesdocumetid1,
                  poindedepart: editingController.text,
                  poindedarrive: editingController1.text,
                ),
              ),
            );
          },
        ));
  }

  void retounerlesdubu(DateTime now) async {
    var now2 = now.toString().split(' ');
    var now3 = now2[1].toString().split(':');
    String timenow = now3[0].toString() + "." + now3[1];
    double timeendouble = double.parse(timenow);

    for (var i = 0; i < _listdesbus.length; i++) {
      String nomtrrajet = _nomdutrajetaller[i].toString().replaceAll('[', '');
      nomtrrajet = nomtrrajet.toString().replaceAll(']', '');
      nomtrrajet = nomtrrajet.toString().replaceAll(' ', '');

      if (nomtrrajet ==
          editingController.text + "To" + editingController1.text) {
        String time1 = _listtimealler[i].toString().replaceAll('[', '');
        time1 = time1.toString().replaceAll(']', '');
        var splittt = time1.toString().split(',');

        for (var j = 0; j < splittt.length; j++) {
          var heure = splittt[j].toString().split(':');

          if (j == 0 && i == 0) {
            votretemp = heure[0] + "." + heure[1];
         
          } // 2ewelwa7de
          else {
            double heudubus = double.parse(votretemp);
            String votretemp2 = heure[0] + "." + heure[1];
            double heudubus2 = double.parse(votretemp2);

            double tt = timeendouble - heudubus;
            double tt1 = timeendouble - heudubus2;
            tt = tt * 60;
            print("tttttttttttttttttt" + tt.toString());
            if (tt > tt1 && timeendouble < tt && (tt * 60) < 90) {
              setState(() {
                votretemp = "${heudubus.toString()}";
              });
            } else {
              setState(() {
                votretemp = "${heudubus2.toString()}";
              });}}}} //if aller
            else if(_nomdutrajetretour[i]==editingController.text+"To"+editingController1.text){
              print("nooooo");
                      String time1 = _listtimealler[i].toString().replaceAll('[', '');
        time1 = time1.toString().replaceAll(']', '');
        var splittt = time1.toString().split(',');

        for (var j = 0; j < splittt.length; j++) {
          var heure = splittt[j].toString().split(':');

          if (j == 0 && i == 0) {
            votretemp = heure[0] + "." + heure[1];
  
          } // 2ewelwa7de
          else {
            double heudubus = double.parse(votretemp);
            String votretemp2 = heure[0] + "." + heure[1];
            double heudubus2 = double.parse(votretemp2);

            double tt = timeendouble - heudubus;
            double tt1 = timeendouble - heudubus2;
            tt = tt * 60;

            if (tt > tt1 && timeendouble < tt && (tt * 60) < 90) {
              setState(() {
                votretemp = "${heudubus.toString()}";
              });
            } else {
              setState(() {
                votretemp = "${heudubus2.toString()}";
              });
            }
          }
        } //for j split temp du chaque bu

            }
    } // for corrir  bus
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
      });
    }
  }

  void filterSearchResults1(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems1);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items1.clear();
        items1.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items1.clear();
      });
    }
  }

  void getlisttimedutrajet(String temtrajet) {
    double a = double.parse(temtrajet);

    _templistdechaquestation.add(a);
    for (var i = 0; i < lisdesdetrajet.length; i++) {
      if (lisdesdetrajet[i] ==
          editingController.text + " To " + editingController1.text) {
        String n = listtiementrelesstation[i].toString().replaceAll('[', '');
        n = n.toString().replaceAll(']', '');

        var splitlisttime = n.toString().split(',');

        for (var j = 0; j < splitlisttime.length; j++) {
          double b = double.parse(splitlisttime[j]);
          b = b / 60;
          double c = a + b;
          var varc = c.toString().split('.');
          int varc1 = int.parse(varc[1]);
          int varc2 = int.parse(varc[0]);
          String varc11 = varc1.toString();
          String varc112 = varc11[0] + "" + varc11[0];
          double varc12 = double.parse(varc112);
          if (varc12 > 59) {
            c = varc2 + 0.59;
            _templistdechaquestation.add(c);
            a = c;
          } else {
            varc12 = varc12 / 100;
            c = varc2 + varc12;
            _templistdechaquestation.add(c);
            a = c;
          }
        }
      }
    }
  }

  void getdata(List<String> a) {
    String l1 = _listnomstation.toString().replaceAll(' ', '');
    l1 = l1.toString().replaceAll('[', '');
    l1 = l1.toString().replaceAll(']', '');
    var split1 = l1.toString().split(',');
    String l2 = a.toString().replaceAll(' ', '');
    l2 = l2.toString().replaceAll('[', '');
    l2 = l2.toString().replaceAll(']', '');
    var split2 = l2.toString().split(',');
    for (var h = 0; h < split2.length; h++) {
      for (var u = 0; u < split1.length; u++) {
        if (split1[u] == split2[h]) {
          _listdesstatation1.add(_listdesstatation[u]);
          _lisdesdocumetid1.add(_lisdesdocumetid[u]);
        }
      }
    }
  }
}
/*else if(_nomdutrajetretour[i]==editingController.text+"To"+editingController1.text){
               
               String time1=_listtimealler[i].toString().replaceAll('[', '');
               time1=time1.toString().replaceAll(']', '');
               var splittt= time1.toString().split(',');
              print("list time aller"+splittt.toString());
               for(var j=0;j<splittt.length;j++){
                    var heure= splittt[j].toString().split(':');
                 if(j==0 && i==0){
                        votretemp= heure[0]+"."+heure[1];
                 }else{

                   double heudubus= double.parse(votretemp);
                    String votretemp2= heure[0]+"."+heure[1];
                    double heudubus2= double.parse(votretemp2);
                      
                if(timeendouble-heudubus<timeendouble-heudubus2 && timeendouble>heudubus2 && timeendouble-heudubus2<120 ){
                    votrebus=_listdesbus[i];
                     votretemp="$heudubus";
                }
                else{
                  votrebus=_listdesbus[i];
                  votretemp="$heudubus2";
                }
                }
                
                i++;
                print("bussssss   "+liistofbus[i].toString());
               } 

              }*/
