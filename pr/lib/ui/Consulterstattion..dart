import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';

class Condultersatation extends StatefulWidget {
  String nomdustation;
  String loaclisationvalue;
  String type;

  Condultersatation(
      {Key key, this.nomdustation, this.loaclisationvalue, this.type})
      : super(key: key);
  _Condultersatation createState() => new _Condultersatation();
}

class _Condultersatation extends State<Condultersatation> {
  Future getvalue() async {
    var fires = Firestore.instance;
    QuerySnapshot qn = await fires.collection('trajet').getDocuments();
    return qn.documents;
  }

  String line;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.nomdustation}", style: TextStyle(fontSize: 20.0)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Navigationstation(
                      idex: 0,
                    ),
                  ));
            }),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
          future: getvalue(),
          builder: (_, snapshot) {
            if (snapshot.hasError || !snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      " Name of Station : ${widget.nomdustation}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 20.0),
                    ),
                    Text(
                      "Location value : ${widget.loaclisationvalue}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 20.0),
                    ),
                    Text(
                      "Type of Station : ${widget.type}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
