import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';
import 'package:myfinalpfe/ui/addnewtrjet.dart';
import 'package:myfinalpfe/ui/consulertrajet.dart';

class getdatabus {
  getdata() {
    return Firestore.instance.collection('trajet').getDocuments();
  }

  getdoucemetId() {
    return Firestore.instance.collection('trajet').getDocuments();
  }
}

class Searchertrajet extends StatefulWidget {
  Searchertrajet({
    Key key,
  }) : super(key: key);

  @override
  _Searchertrajet createState() => _Searchertrajet();
}

class _Searchertrajet extends State<Searchertrajet> {
  TextEditingController editingController = TextEditingController();

  List<String> listofname = List<String>();
  List<String> listostatut = List<String>();
  List<String> listostation = List<String>();
  List<String> listdnombredevoyage = List<String>();
  //final duplicateItems = List<String>();
  var duplicateItems = List<String>();

  final listdocumentid = List<String>();
  var items = List<String>();
  Future getvalue() async {
    var fires = Firestore.instance;
    QuerySnapshot qn = await fires.collection('trajet').getDocuments();
    return qn.documents;
  }

  final dbref = FirebaseDatabase.instance.reference();
  List<String> pointdepart = List<String>();
  List<String> poindarriver = List<String>();
  List<String> listdestation = List<String>();
  int i;
  Future getsationns() async {
    Firestore db = Firestore.instance;
    await db.collection('trajet').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        pointdepart.add(snapshot.documents[i].data['pointdepart']);
      }
    });
    await db.collection('trajet').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        poindarriver.add(snapshot.documents[i].data['poinfinal']);
      }
    });
    await db.collection('trajet').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        listdestation.add(snapshot.documents[i].data['station'].toString());
      }
    });
    await db.collection('trajet').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        listdnombredevoyage
            .add(snapshot.documents[i].data['nombredestation'].toString());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getdatabus().getdata().then((QuerySnapshot docs) {
      for (i = 0; i < docs.documents.length; i++) {
        duplicateItems.add(docs.documents[i].data['num']);
        listdocumentid.add(docs.documents[i].documentID);
      }
    });
    getsationns();
    items.addAll(duplicateItems);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Ride", style: TextStyle(fontSize: 20.0)),
      ),
      body: FutureBuilder(
          future: getvalue(),
          builder: (_, snapshot) {
            if (snapshot.hasError || !snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Container(
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
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                              //                    <-- BoxDecoration
                              border: Border(bottom: BorderSide()),
                            ),
                            child: ListTile(
                              title: Text(
                                items[index],
                                textAlign: TextAlign.center,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                      color: Colors.red,
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        dbref.child(items[index]).remove();
                                        _deletebus(
                                            context, listdocumentid[index]);
                                      }),
                                  IconButton(
                                      color: Colors.blue,
                                      icon: Icon(Icons.mode_edit),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => addnewtrajet(
                                                  id: listdocumentid[index],
                                                  nomdutrager:
                                                      duplicateItems[index],
                                                  nombredevoygae:
                                                      listdnombredevoyage[
                                                          index],
                                                  poindapart:
                                                      pointdepart[index],
                                                  poindariver:
                                                      poindarriver[index]),
                                            ));
                                      }),
                                ],
                              ),
                              onTap: () async {
                                var a = returnerlis(
                                    listdestation[index].toString());

                                await Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => consulertrajet(
                                            nomdutrajet: items[index],
                                            listdesstatinintmidiare: a,
                                            poindudepart: pointdepart[index],
                                            pointdarriver:
                                                poindarriver[index])));
                              },
                            ));
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  List<String> returnerlis(String a) {
    String listaint = a.toString().replaceAll('[', '');
    listaint = listaint.toString().replaceAll(']', '');
    var lisdesstationinerdiaire = listaint.toString().split(',');
    return lisdesstationinerdiaire;
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
        items.addAll(duplicateItems);
      });
    }
  }

  void _deletebus(BuildContext context, String id) async {
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
              content: Text("ARE YOU SUR YOU WNAT TO DELETE "),
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
