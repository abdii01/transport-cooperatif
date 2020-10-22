import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';
import 'package:myfinalpfe/ui/Searchbus.dart';
import 'package:myfinalpfe/ui/Searchertrajet.dart';
import 'package:myfinalpfe/ui/addnewtrjet.dart';
import 'package:myfinalpfe/ui/adnewbus.dart';
import 'package:myfinalpfe/ui/consulertrajet.dart';
import 'package:myfinalpfe/ui/makeline.dart';

class Gerertrajet extends StatefulWidget {
  _Gerertrajet createState() => new _Gerertrajet();
}

class _Gerertrajet extends State<Gerertrajet> {
  Future getvalue() async {
    var fires = Firestore.instance;
    QuerySnapshot qn = await fires.collection('trajet').getDocuments();
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
                                builder: (_) => Searchertrajet(),
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
                                                  builder: (_) => addnewtrajet(
                                                        id: snapshot
                                                            .data[intdex]
                                                            .documentID,
                                                        nomdutrager: snapshot
                                                            .data[intdex]
                                                            .data['num'],
                                                        poindapart: snapshot
                                                                .data[intdex]
                                                                .data[
                                                            'pointdepart'],
                                                        poindariver: snapshot
                                                            .data[intdex]
                                                            .data['poinfinal'],
                                                        nombredevoygae: snapshot
                                                                .data[intdex]
                                                                .data[
                                                            'nombredestation'],
                                                      )));
                                        }),
                                  ],
                                ),
                                onTap: () async {
                                  var a = returnerlis(snapshot
                                      .data[intdex].data['station']
                                      .toString());

                                  await Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => consulertrajet(
                                                nomdutrajet: snapshot
                                                    .data[intdex].data['num'],
                                                listdesstatinintmidiare: a,
                                                poindudepart: snapshot
                                                    .data[intdex]
                                                    .data['pointdepart'],
                                                pointdarriver: snapshot
                                                    .data[intdex]
                                                    .data['poinfinal'],
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
                context, MaterialPageRoute(builder: (_) => addnewtrajet()));
          },
        ));
  }

  void _deletstation(BuildContext context, String id) async {
    if (await _showconfermationdialoge(context)) {
      try {
        await Firestore.instance
            .collection('trajet')
            .document(id)
            .delete()
            .then((onValue) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Navigationstation(
                idex: 2,
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

  List<String> returnerlis(String a) {
    String listaint = a.toString().replaceAll('[', '');
    listaint = listaint.toString().replaceAll(']', '');
    var lisdesstationinerdiaire = listaint.toString().split(',');
    return lisdesstationinerdiaire;
  }
}
