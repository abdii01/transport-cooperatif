import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:myfinalpfe/ui/LoginPage.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';

import 'package:myfinalpfe/util/user_to_database.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  FocusNode _statunofe = new FocusNode();
  FocusNode _passwordfocus = new FocusNode();
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Register Admin"),
      ),
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
                    if (value == null || value.isEmpty)
                      return "enter your eamil";
                    if (!validateEmail(value)) return "enter a correct eamil";
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
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_statunofe);
                  },
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "you have to give number";
                    if (!validateMobile(value)) {
                      return "you have to ente 8 caracter";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "password",
                    icon: Icon(
                      Icons.vpn_key,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                FlatButton(
                    child: Text('Register'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text)
                              .then((singedUser) {
                            UserToDatabase().addNewUser(singedUser, context);
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
                                          "This email exist or make sure that your are  online"),
                                      actions: <Widget>[
                                        FlatButton(
                                          textColor: Colors.black,
                                          child: Text("ok"),
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                        ),
                                      ],
                                    ));
                          });
                        } catch (e) {}
                      }
                    }),
              ],
            ),
          )),
    );
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  bool validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length < 8)
      return false;
    else
      return true;
  }
}
