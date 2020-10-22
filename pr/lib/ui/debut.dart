import 'package:flutter/material.dart';

class debut extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _debutstate();
}

class _debutstate extends State<debut> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Text("My BUS"),
            ),
            body: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Container(
                    padding: EdgeInsets.all(14.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 300.0,
                            height: 20.0,
                            child: FlatButton(
                              child: Text('passager'),
                              padding: EdgeInsets.all(14.0),
                              color: Colors.green,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/passagerlogin');
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          ButtonTheme(
                              minWidth: 300.0,
                              height: 20.0,
                              child: FlatButton(
                                child: Text('admin'),
                                color: Colors.deepPurple,
                                textColor: Colors.white,
                                padding: EdgeInsets.all(14.0),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/loginpage');
                                },
                              )),
                        ])))));
  }
}
