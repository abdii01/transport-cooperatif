import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Navigationbardebut.dart';
import 'package:myfinalpfe/util/Servicepassager.dart';
import 'package:myfinalpfe/util/user.dart';

class RegisterpassagerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterpassagerPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nomcontroller = new TextEditingController();
  TextEditingController _prenomcontorller = new TextEditingController();

  FocusNode _statunofe = new FocusNode();
  FocusNode _passwordfocus = new FocusNode();
  FocusNode _nomfoucus = new FocusNode();
  FocusNode _prenomfocus = new FocusNode();
  String _dropdownValue;
  List<String> _dropdownItems = List<String>();
  TextEditingController _typecontroler = new TextEditingController();
  void initState() {
    super.initState();
    for (var i = 18; i < 101; i++) {
      _dropdownItems.add("$i");
    }
    _dropdownValue = _dropdownItems[0];
    _typecontroler.text = _dropdownValue;
  }

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  List<String> listemail = List<String>();
  Future getvalue() async {
    var fires = Firestore.instance;
    QuerySnapshot qn = await fires.collection('buus').getDocuments();
    return qn.documents;
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Register Passengers"),
        ),
        body: FutureBuilder(
            future: getvalue(),
            builder: (_, snapshot) {
              if (snapshot.hasError || !snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );

              return Container(
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
                            FocusScope.of(context).requestFocus(_nomfoucus);
                          },
                          controller: _nomcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Enter you name";
                          },
                          decoration: InputDecoration(
                            labelText: "Last name",
                            icon: Icon(
                              Icons.account_box,
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
                            FocusScope.of(context).requestFocus(_prenomfocus);
                          },
                          controller: _prenomcontorller,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Enter you last name";
                          },
                          decoration: InputDecoration(
                            labelText: "last name",
                            icon: Icon(
                              Icons.accessibility,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        DropdownButtonHideUnderline(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              new InputDecorator(
                                decoration: InputDecoration(
                                  filled: false,
                                  hintText: 'age',
                                  prefixIcon: Icon(
                                    Icons.settings_applications,
                                    color: Colors.black,
                                  ),
                                  labelText:
                                      _dropdownValue == null ? 'age' : 'age',
                                  //  errorText: _errorText,
                                ),
                                // isEmpty: _dropdownValue == null,
                                child: new DropdownButton<String>(
                                  value: _dropdownValue,
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 15),
                                  isDense: true,
                                  onChanged: (String newValue) {
                                    print('value change');
                                    print(newValue);
                                    setState(() {
                                      _dropdownValue = newValue;
                                      _typecontroler.text = _dropdownValue;
                                    });
                                  },
                                  items: _dropdownItems.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(_statunofe);
                          },
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "enter your email";
                            if (!validateEmail(value))
                              return "enter a correct eamil";
                            if (!testerisemailexist(value)) {
                              return "this email already  exist";
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
                          keyboardType: TextInputType.emailAddress,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(_passwordfocus);
                          },
                          controller: _passwordController,
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
                                  user passgee = user(
                                      nom: _nomcontroller.text,
                                      email: _emailController.text,
                                      age: _typecontroler.text,
                                      prenom: _prenomcontorller.text,
                                      password: _passwordController.text);
                                  await firestrorepassger()
                                      .addStation(passgee)
                                      .then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => Navigationbardebus(),
                                      ),
                                    );
                                  }).catchError((e) {
                                    return showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (context) => AlertDialog(
                                              content: Text(
                                                  "make sure that your are  online and try again"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  textColor: Colors.black,
                                                  child: Text("ok"),
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, false),
                                                ),
                                              ],
                                            ));
                                  });
                                } catch (e) {
                                  return showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (context) => AlertDialog(
                                            content: Text(
                                                "make sure that your are  online and try again"),
                                            actions: <Widget>[
                                              FlatButton(
                                                textColor: Colors.black,
                                                child: Text("ok"),
                                                onPressed: () => Navigator.pop(
                                                    context, false),
                                              ),
                                            ],
                                          )
                                          );
                                }
                              }
                            }
                            ),
                      ],
                    ),
                  )
                  );
            }
            )
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

  bool testerisemailexist(String email) {
    for (var i = 0; i < listemail.length; i++) {
      if (listemail[i] == email) {
        return false;
      }
    }
    return true;
  }
}
