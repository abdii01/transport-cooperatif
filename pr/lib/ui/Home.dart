import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Consulterstattion..dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';
import 'package:myfinalpfe/ui/adnewstation.dart';
import 'package:myfinalpfe/ui/searcherstation.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  Future getvalue() async {
    var fires = Firestore.instance;
    QuerySnapshot qn = await fires.collection('Station').getDocuments();
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
                  padding: const EdgeInsets.fromLTRB(0, 0.0, 0.0, 0.0),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: IconButton(
                            color: Colors.blue,
                            icon: Icon(Icons.search),
                            iconSize: 50.0,
                            onPressed: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Searcherstaion(),
                                  ));
                            }),
                      ),
                      /*Container(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/regeration');
                            },
                            color: Colors.blue,
                            child: Text(
                              "Sign up",
                              style: TextStyle(color: Colors.white),
                            )),
                      )*/
                    ],
                  ),
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
                                subtitle: Text(
                                  snapshot.data[intdex].data['type'],
                                  textAlign: TextAlign.center,
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
                                                  builder: (_) => addnewStation(
                                                        id: snapshot
                                                            .data[intdex]
                                                            .documentID,
                                                        nomstation: snapshot
                                                            .data[intdex]
                                                            .data['num'],
                                                        location: snapshot
                                                            .data[intdex]
                                                            .data['statut'],
                                                        type: snapshot
                                                            .data[intdex]
                                                            .data['type'],
                                                      )));
                                        }),
                                  ],
                                ),
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Condultersatation(
                                                nomdustation: snapshot
                                                    .data[intdex].data['num'],
                                                type: snapshot
                                                    .data[intdex].data['type'],
                                                loaclisationvalue: snapshot
                                                    .data[intdex]
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
                context, MaterialPageRoute(builder: (_) => addnewStation()));
          },
        ));
  }

  void _deletstation(BuildContext context, String id) async {
    if (await _showconfermationdialoge(context)) {
      try {
        await Firestore.instance
            .collection('Station')
            .document(id)
            .delete()
            .then((onValue) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Navigationstation(
                        idex: 0,
                      )));
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
                "ARE YOU SUR YOU WANT TO DELETE THIS STATION",
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
}
