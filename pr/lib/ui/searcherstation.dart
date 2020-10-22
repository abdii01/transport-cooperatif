import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Consulterstattion..dart';
import 'package:myfinalpfe/ui/adnewbus.dart';
import 'package:myfinalpfe/ui/adnewstation.dart';

class getdatabus {
  getdata() {
    return Firestore.instance.collection('Station').getDocuments();
  }

  getdoucemetId() {
    return Firestore.instance.collection('Station').getDocuments();
  }
}

class Searcherstaion extends StatefulWidget {
  List listbus = List<String>();
  Searcherstaion({Key key, this.listbus}) : super(key: key);

  @override
  _Searcherstaion createState() => _Searcherstaion();
}

class _Searcherstaion extends State<Searcherstaion> {
  TextEditingController editingController = TextEditingController();

  List<String> listofname = List<String>();
  List<String> listostatut = List<String>();
  List<String> listostation = List<String>();
  //final duplicateItems = List<String>();
  var duplicateItems = List<String>();

  final listdocumentid = List<String>();
  var items = List<String>();
  Future getvalue() async {
    var fires = Firestore.instance;
    QuerySnapshot qn = await fires.collection('Station').getDocuments();
    return qn.documents;
  }

  final dbref = FirebaseDatabase.instance.reference();

  int i;

  @override
  void initState() {
    getdatabus().getdata().then((QuerySnapshot docs) {
      for (i = 0; i < docs.documents.length; i++) {
        duplicateItems.add(docs.documents[i].data['num']);
        listostation.add(docs.documents[i].data['statut']);
        listostatut.add(docs.documents[i].data['type']);
        listdocumentid.add(docs.documents[i].documentID);
      }
    });
    items.addAll(duplicateItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(""),
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
                        return ListTile(
                          title: Text(
                            items[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                color: Colors.blue,
                                icon: Icon(Icons.edit),
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => addnewStation(
                                        id: listdocumentid[index],
                                        location: listostation[index],
                                        nomstation: items[index],
                                        type: listostatut[index],
                                      ),
                                    )),
                              ),
                              IconButton(
                                  color: Colors.red,
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    dbref.child(items[index]).remove();
                                    _deletebus(context, listdocumentid[index]);
                                  }),
                            ],
                          ),
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Condultersatation(
                                          nomdustation: items[index],
                                          type: listostatut[index],
                                          loaclisationvalue:
                                              listostation[index],
                                        )));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
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
            .collection('Station')
            .document(id)
            .delete()
            .then((onValue) {
          Navigator.of(context).pushReplacementNamed('/Gererstation');
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

  void readdata() {
    dbref.once().then((DataSnapshot datasnashot) {
      print(datasnashot.value);
    });
  }
}
