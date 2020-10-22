import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';
import 'package:myfinalpfe/ui/Searchbus.dart';
import 'package:myfinalpfe/ui/adnewbus.dart';
import 'package:myfinalpfe/ui/consulerlesbus.dart';

class Gererbus extends StatefulWidget {
  _Gererbus createState() => new _Gererbus();
}

class _Gererbus extends State<Gererbus> {
  Future getvalue() async {
    var fires = Firestore.instance;
    QuerySnapshot qn = await fires.collection('buus').getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getvalue(),
            builder: (_, snapshot) {
              if (snapshot.hasError || !snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );

              return Container(
                  child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(300.0, 0.0, 0.0, 0.0),
                  child: Column(children: <Widget>[
                    IconButton(
                        color: Colors.blue,
                        icon: Icon(Icons.search),
                        iconSize: 50.0,
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Searchbus(),
                              ));
                        }),
                  ]),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, intdex) {
                          return Container(
                              decoration: BoxDecoration(
                                //                    <-- BoxDecoration
                                border: Border(bottom: BorderSide()),
                              ),
                              child: ListTile(
                                title: Text(
                                  snapshot.data[intdex].data['num'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                        color: Colors.red,
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          _deletstation(context,
                                              snapshot.data[intdex].documentID);
                                        }),
                                    IconButton(
                                        color: Colors.blue,
                                        icon: Icon(Icons.mode_edit),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => addnewbus(
                                                        id: snapshot
                                                            .data[intdex]
                                                            .documentID,
                                                        nonmdubus: snapshot
                                                            .data[intdex]
                                                            .data['num'],
                                                        nombredevoyage: snapshot
                                                                .data[intdex]
                                                                .data[
                                                            'nombredevoyage'],
                                                      )));
                                        }),
                                  ],
                                ),
                                onTap: () async {
                                  List<String> timealler = returnertime(snapshot
                                      .data[intdex].data['listimealler']);
                                  List<String> stationaller = returnertime(
                                      snapshot.data[intdex]
                                          .data['liststationtrajetaller']);
                                  List<String> stattionretour = returnertime(
                                      snapshot.data[intdex]
                                          .data['listedestationtajerretour']);
                                  List<String> timeretour = returnertime(
                                      snapshot
                                          .data[intdex].data['listimeretourd']);
                                  String nomdutajet = returnernomdutrajet(
                                      snapshot
                                          .data[intdex].data['nomtragetaller']);
                                  String n = returnernomdutrajet(snapshot
                                      .data[intdex].data['nomdutrajetretour']);
                                  await Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => consulerbus(
                                                nomdubus: snapshot
                                                    .data[intdex].data['num'],
                                                listdessatationintermidiairealler:
                                                    stationaller,
                                                listdesstationintermidiareretour:
                                                    stattionretour,
                                                listdetimealler: timealler,
                                                listimeretour: timeretour,
                                                loaction: snapshot.data[intdex]
                                                    .data['nomstation'],
                                                nomberdevoyage: snapshot
                                                    .data[intdex]
                                                    .data['nombredevoyage'],
                                                nomdutrageraller: nomdutajet,
                                                nomdutragerretour: n,
                                                statut: snapshot.data[intdex]
                                                    .data['statut'],
                                              )));
                                },
                              ));
                        })),
              ]));
            }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.black,
          onPressed: () async {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => addnewbus()));
          },
        ));
  }

  void _deletstation(BuildContext context, String id) async {
    if (await _showconfermationdialoge(context)) {
      try {
        await Firestore.instance
            .collection('buus')
            .document(id)
            .delete()
            .then((onValue) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Navigationstation(
                idex: 1,
              ),
            ),
          );
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> _showconfermationdialoge(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text(
                "ARE YOU SUR YOU WANT TO DELETE THIS BUS",
                style: TextStyle(color: Colors.red, fontSize: 15.0),
              ),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.red,
                  child: Text("Delete"),
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

  List<String> returnertime(String a) {
    String listaint = a.toString().replaceAll('[', '');
    listaint = listaint.toString().replaceAll(']', '');
    var lisdesstationinerdiaire = listaint.toString().split(',');
    return lisdesstationinerdiaire;
  }

  String returnernomdutrajet(String a) {
    String listaint = a.toString().replaceAll('[', '');
    listaint = listaint.toString().replaceAll(']', '');
    return listaint;
  }
}
