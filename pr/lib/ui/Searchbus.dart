import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';
import 'package:myfinalpfe/ui/adnewbus.dart';
import 'package:myfinalpfe/ui/consulerlesbus.dart';

class getdatabus {
  getdata() {
    return Firestore.instance.collection('buus').getDocuments();
  }

  getdoucemetId() {
    return Firestore.instance.collection('buus').getDocuments();
  }
}

class Searchbus extends StatefulWidget {
  List listbus = List<String>();
  Searchbus({Key key, this.listbus}) : super(key: key);

  @override
  _Searchbus createState() => _Searchbus();
}

class _Searchbus extends State<Searchbus> {
  TextEditingController editingController = TextEditingController();

  List<String> listofname = List<String>();
  List<String> listostatut = List<String>();
  List<String> listostation = List<String>();
  //final duplicateItems = List<String>();

  final listdocumentid = List<String>();
  var items = List<String>();
  var duplicateItems = List<String>();
  Future getvalue() async {
    var fires = Firestore.instance;
    QuerySnapshot qn = await fires.collection('buus').getDocuments();
    return qn.documents;
  }

  final dbref = FirebaseDatabase.instance.reference();
  List<String> listimealler = List<String>();
  List<String> listtimeretour = List<String>();
  List<String> listdesstattionaller = List<String>();
  List<String> liistdesstationretour = List<String>();
  List<String> listdenomdutrajetaller = List<String>();
  List<String> listdennomdutrajetretour = List<String>();
  List<String> lisdelocalistion = List<String>();
  Future getsationns() async {
    Firestore db = Firestore.instance;
    await db.collection('buus').getDocuments().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        listimealler.add(snapshot.documents[i].data['listimealler']);
        listtimeretour.add(snapshot.documents[i].data['listimeretourd']);
        listdesstattionaller
            .add(snapshot.documents[i].data['liststationtrajetaller']);
        listdennomdutrajetretour
            .add(snapshot.documents[i].data['nomdutrajetretour']);
        listdenomdutrajetaller
            .add(snapshot.documents[i].data['nomtragetaller']);
        liistdesstationretour
            .add(snapshot.documents[i].data['listedestationtajerretour']);
        lisdelocalistion.add(snapshot.documents[i].data['nomstation']);
      }
    });
  }

  int i;

  @override
  void initState() {
    getdatabus().getdata().then((QuerySnapshot docs) {
      for (i = 0; i < docs.documents.length; i++) {
        duplicateItems.add(docs.documents[i].data['num']);
        listdocumentid.add(docs.documents[i].documentID);
      }
    });
    getsationns();
    items.addAll(duplicateItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Bus", style: TextStyle(fontSize: 20.0)),
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
                                    color: Colors.blue,
                                    icon: Icon(Icons.edit),
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => addnewbus(
                                            id: listdocumentid[index],
                                            nonmdubus: items[index],
                                          ),
                                        )),
                                  ),
                                  IconButton(
                                      color: Colors.red,
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        dbref.child(items[index]).remove();
                                        _deletebus(
                                          context,
                                          listdocumentid[index],
                                        );
                                      }),
                                ],
                              ),
                              onTap: () async {
                                List<String> timealler =
                                    returnertime(listimealler.toString());
                                List<String> stationaller = returnertime(
                                    listdesstattionaller.toString());
                                List<String> stattionretour = returnertime(
                                    liistdesstationretour.toString());
                                List<String> timeretour =
                                    returnertime(listtimeretour.toString());
                                String nomdurajer = returnernomdutrajet(
                                    listdenomdutrajetaller[index]);
                                await Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => consulerbus(
                                              nomdubus: items[index],
                                              listdessatationintermidiairealler:
                                                  stationaller,
                                              listdesstationintermidiareretour:
                                                  stattionretour,
                                              listdetimealler: timealler,
                                              listimeretour: timeretour,
                                              nomdutrageraller: nomdurajer,
                                              nomdutragerretour:
                                                  listdennomdutrajetretour[
                                                      index],
                                              loaction: lisdelocalistion[index],
                                            )));
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
