import 'package:flutter/material.dart';

class Adminzone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _adminzone();
}

class _adminzone extends State<Adminzone> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Text("My BUS"),
            ),
            body: Container(
                padding: EdgeInsets.all(14.0),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      ButtonTheme(
                          minWidth: 300.0,
                          height: 20.0,
                          child: FlatButton(
                            child: Text('Gere bus'),
                            color: Colors.deepPurple,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(14.0),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/gerertrajet');
                            },
                          )),
                      SizedBox(
                        height: 15.0,
                      ),
                      ButtonTheme(
                        minWidth: 300.0,
                        height: 20.0,
                        child: FlatButton(
                          child: Text('Gerer station'),
                          padding: EdgeInsets.all(14.0),
                          color: Colors.green,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pushNamed('/Gererstation');
                          },
                        ),
                      ),
                    ])))));
  }
}
