import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPagstate();
}

class _LoginPagstate extends State<LoginPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  FocusNode _statunofe = new FocusNode();
  FocusNode _passwordfocus = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(14.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Admin",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.blue),
              ),
              SizedBox(
                height: 50.0,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_statunofe);
                },
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) return "enter your email";
                  if (!testimail(value)) {
                    return "enter a correct email";
                  }
                },
                decoration: InputDecoration(
                  labelText: "email",
                  icon: Icon(
                    Icons.email,
                    color: Colors.red,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_passwordfocus);
                },
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter your password";
                  }
                  if (!validateMobile(value)) {
                    return "enter a correct password";
                  }
                },
                decoration: InputDecoration(
                  labelText: "password",
                  icon: Icon(Icons.vpn_key, color: Colors.black),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                  child: Text('Login'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      try {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text)
                            .then((users) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Navigationstation(
                                idex: 0,
                              ),
                            ),
                          );
                        }).catchError((e) {
                          return showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) => AlertDialog(
                                    content: Text(
                                        "check please your email and password and make sure that your are  online"),
                                    actions: <Widget>[
                                      FlatButton(
                                        textColor: Colors.black,
                                        child: Text("ok"),
                                        onPressed: () =>
                                            Navigator.pop((context), false),
                                      ),
                                    ],
                                  ));
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  }),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool testimail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  bool validateMobile(String value) {
    if (value.length < 8)
      return false;
    else
      return true;
  }
}
