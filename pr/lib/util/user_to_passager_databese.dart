import 'package:firebase_database/firebase_database.dart';

class UserToDatabasepassager {
  addNewUser(user, context) {
    FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('passager')
        .push()
        .set({'email': user.email, 'uid': user.uid});
  }
}
