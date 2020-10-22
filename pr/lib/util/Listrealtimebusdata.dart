import 'package:firebase_database/firebase_database.dart';

class Realtimebusdta {
  static final dtbaseref = FirebaseDatabase.instance.reference();
  getbus() {
    dtbaseref.once().then((DataSnapshot sna) {
      sna.value;
    });
  }
}
