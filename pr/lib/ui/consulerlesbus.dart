import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';

class consulerbus extends StatefulWidget {
  String nomdubus;
  String loaction;
  String nomberdevoyage;
  String statut;
  String nomdutrageraller;
  String nomdutragerretour;
  List<String> listdessatationintermidiairealler = List<String>();
  List<String> listdesstationintermidiareretour = List<String>();
  List<String> listdetimealler = List<String>();
  List<String> listimeretour = List<String>();

  consulerbus(
      {Key key,
      this.nomdubus,
      this.listdessatationintermidiairealler,
      this.listdesstationintermidiareretour,
      this.listdetimealler,
      this.listimeretour,
      this.loaction,
      this.nomberdevoyage,
      this.nomdutrageraller,
      this.nomdutragerretour,
      this.statut})
      : super(key: key);
  _consulerbus createState() => new _consulerbus();
}

class _consulerbus extends State<consulerbus> {
  Future getvalue() async {
    var fires = Firestore.instance;
    QuerySnapshot qn = await fires.collection('trajet').getDocuments();
    return qn.documents;
  }

  String lineone;
  String listtwotrajetretour;
  var splitnomtrajetaller;
  var splitretour;

  @override
  void initState() {
    super.initState();
    String nomtrajetaller =
        widget.nomdutrageraller.toString().replaceAll('[', '');
    nomtrajetaller = nomtrajetaller.toString().replaceAll(']', '');
    splitnomtrajetaller = nomtrajetaller.toString().split(' To ');
    String nomtrajetretour =
        widget.nomdutragerretour.toString().replaceAll('[', '');
    nomtrajetretour = nomtrajetretour.toString().replaceAll(']', '');
    splitretour = nomtrajetretour.toString().split(' To ');

    for (var i = 0; i < widget.listdessatationintermidiairealler.length; i++) {
      if (i == 0) {
        lineone = splitnomtrajetaller[0] +
            " -->${widget.listdessatationintermidiairealler[i]} -->";
        if (widget.listdessatationintermidiairealler.length == 1) {
          lineone = lineone + "-->" + splitnomtrajetaller[1];
        }
      } else {
        lineone =
            lineone + "${widget.listdessatationintermidiairealler[i]} -->";
      }
    }

    for (var i = 0; i < widget.listdesstationintermidiareretour.length; i++) {
      if (i == 0) {
        listtwotrajetretour = splitretour[0] +
            " -->${widget.listdesstationintermidiareretour[i]} -->";
        if (widget.listdesstationintermidiareretour.length == 1) {
          listtwotrajetretour =
              listtwotrajetretour + "-->" + splitnomtrajetaller[1];
        }
      } else {
        listtwotrajetretour = listtwotrajetretour +
            "${widget.listdesstationintermidiareretour[i]} -->";
      }
    }
    listtwotrajetretour = listtwotrajetretour + splitretour[1];
    lineone = lineone + splitnomtrajetaller[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(" Bus ${widget.nomdubus}", style: TextStyle(fontSize: 20.0)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Navigationstation(
                      idex: 1,
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
                      "name of bus : " + widget.nomdubus,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 20.0),
                    ),
                    Text(
                      "name of waye one : " + widget.nomdutrageraller,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.deepPurpleAccent, fontSize: 20.0),
                    ),
                    Text(
                      "Waye one :" + lineone,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                    Text(
                      "time of going from ${widget.loaction}" +
                          widget.listdetimealler.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 20.0),
                    ),
                    Text(
                      "name of way back : " + widget.nomdutragerretour,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.deepPurpleAccent, fontSize: 20.0),
                    ),
                    Text(
                      "Waye back to ${widget.loaction} " + listtwotrajetretour,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                    Text(
                      "time of going from ${splitnomtrajetaller[1]} :" +
                          widget.listimeretour.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
