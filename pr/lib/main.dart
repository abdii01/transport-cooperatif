import 'package:flutter/material.dart';

import 'package:myfinalpfe/ui/Adtimeforeverybus.dart';
import 'package:myfinalpfe/ui/Home.dart';
import 'package:myfinalpfe/ui/LoginPage.dart';
import 'package:myfinalpfe/ui/Navigationbardebut.dart';
import 'package:myfinalpfe/ui/Regestration.dart';
import 'package:myfinalpfe/ui/Startyoutrip.dart';
import 'package:myfinalpfe/ui/addbus.dart';
import 'package:myfinalpfe/ui/adnewstation.dart';
import 'package:myfinalpfe/ui/amdinplace.dart';
import 'package:myfinalpfe/ui/choosestattiontobus.dart';
import 'package:myfinalpfe/ui/gerertrajet.dart';
import 'package:myfinalpfe/ui/loginpassger.dart';
import 'package:myfinalpfe/ui/makeline.dart';
import 'package:myfinalpfe/ui/passagerregestrayion.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Navigationbardebus(),
        routes: <String, WidgetBuilder>{
          '/addsationtobus': (BuildContext context) => new staatindata(),
          '/Passagerpart': (BuildContext context) => new Getdestinaton(),

          '/busvrud': (BuildContext context) => new Gererbus(),
          '/loginpage': (BuildContext context) => new LoginPage(),
          '/regeration': (BuildContext context) => new RegisterPage(),
          '/home': (BuildContext context) => new HomePage(),
          '/passagerlogin': (BuildContext context) => new LoginPassager(),
          '/passagerregestration': (BuildContext context) =>
              new RegisterpassagerPage(),
          '/adminzone': (BuildContext context) => new Adminzone(),
          '/gerertrajet': (BuildContext context) => new Gerertrajet(),
          '/ajouterstationtotrajet': (BuildContext context) => new Makingkine(),
          '/addnewstation': (BuildContext context) => new addnewStation(),
          '/addtimetobus': (BuildContext context) => new Addtimetobus(),
          '/navigationlogin': (BuildContext context) =>
              new Navigationbardebus(),
          // '/getstarted' :  (BuildContext context) => new
        });
  }
}
