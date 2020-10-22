import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class UserToDatabase {
  int i = 0;
  addNewUser(user, context) async {
    await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('admin')
        .push()
        .set({'email': user.email, 'uid': user.uid});
  }
}
