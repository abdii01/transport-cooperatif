import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Home.dart';
import 'package:myfinalpfe/ui/Navigationbardebut.dart';
import 'package:myfinalpfe/ui/addbus.dart';
import 'package:myfinalpfe/ui/gerertrajet.dart';

class Navigationstation extends StatefulWidget {
  int idex;
  String id;
  Navigationstation({Key key, this.id, this.idex}) : super(key: key);
  @override
  _Navigationstation createState() => _Navigationstation();
}

class _Navigationstation extends State<Navigationstation> {
  String nomstation;
  final tabs = [];

  @override
  void initState() {
    super.initState();
    tabs.add(HomePage());
    tabs.add(Gererbus());
    tabs.add(Gerertrajet());
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          widget.idex == 0 ? "Stations" : widget.idex == 1 ? "Bus" : "Ride",
        ),
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
      body: tabs[widget.idex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.idex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.business,
              color: Colors.black,
            ),
            title: Text("Stations"),
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.airport_shuttle,
              color: Colors.black,
            ),
            title: Text("Bus"),
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_movies,
              color: Colors.black,
            ),
            title: Text("Trajet"),
            backgroundColor: Colors.green,
          ),
        ],
        onTap: (index) {
          setState(() {
            widget.idex = index;
          });
        },
      ),
    );
  }
}
