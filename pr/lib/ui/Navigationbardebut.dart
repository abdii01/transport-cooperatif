import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/LoginPage.dart';
import 'package:myfinalpfe/ui/loginpassger.dart';

class Navigationbardebus extends StatefulWidget {
  int index = 0;

  @override
  _Navigationbardebus createState() => _Navigationbardebus();
}

class _Navigationbardebus extends State<Navigationbardebus> {
  final tabs = [
    LoginPage(),
    LoginPassager(),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bus"),
        leading: IconButton(
          icon: Icon(Icons.departure_board),
          onPressed: () => (false),
        ),
      ),
      body: tabs[widget.index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.index,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("ADMIN"),
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new),
            title: Text("Passager"),
            backgroundColor: Colors.green,
          ),
        ],
        onTap: (index) {
          setState(() {
            widget.index = index;
          });
        },
      ),
    );
  }
}
