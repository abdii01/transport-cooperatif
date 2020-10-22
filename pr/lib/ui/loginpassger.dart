import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPassager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPagstate();
}

class _LoginPagstate extends State<LoginPassager> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  FocusNode _statunofe = new FocusNode();
  FocusNode _passwordfocus = new FocusNode();
  List<String> listemail = List<String>();
  List<String> lispassword = List<String>();
  Future getsationns() async {
    Firestore db = Firestore.instance;
    await db
        .collection('passger')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        listemail.add(snapshot.documents[i].data['email']);
      }
    });
    await db
        .collection('passger')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.documents.length; i++) {
        lispassword.add(snapshot.documents[i].data['password']);
      }
    });
  }

  void initState() {
    super.initState();
    getsationns();
  }

  int o = -1;
  bool testerisemailexist(String email) {
    for (var i = 0; i < listemail.length; i++) {
      if (listemail[i] == email) {
        setState(() {
          o = i;
        });
        return true;
      }
    }
    return false;
  }

  bool testepassword(String val) {
    if (o != -1 && lispassword[o] == val) {
      return true;
    }
    return false;
  }

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
                "Passengers",
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
                  if (value == null || value.isEmpty || !testimail(value))
                    return "enter your email";

                  if (!testerisemailexist(value)) {
                    return "this email doesn't  exist";
                  }
                },
                decoration: InputDecoration(
                  labelText: "email",
                  icon: Icon(
                    Icons.email,
                    color: Colors.redAccent,
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
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "enter your password";
                  if (!testepassword(value)) return "enter a correct password";
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
                  child: Text('Login'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      Navigator.of(context)
                          .pushReplacementNamed('/Passagerpart');
                    }
                  }),
              SizedBox(
                height: 15.0,
              ),
              Text('Don\'t  have an account'),
              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                child: Text('Register'),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushNamed('/passagerregestration');
                },
              ),
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
