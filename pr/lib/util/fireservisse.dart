import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfinalpfe/util/bus.dart';

class firestoreservice {
  static final firestoreservice _firestoreservice =
      firestoreservice._internal();
  Firestore _db = Firestore.instance;

  firestoreservice._internal();
  factory firestoreservice() {
    return _firestoreservice;
  }
  Stream<List<Bus>> getBus() {
    return _db.collection('buus').snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Bus.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
  }

  Future<void> addbus(Bus bus) {
    return _db.collection('buus').add(bus.toMap());
  }

  Future<void> delebus(String id) {
    return _db.collection('buus').document(id).delete();
  }

  Future<void> ubdateus(Bus bus) {
    return _db.collection('buus').document(bus.id).updateData(bus.toMap());
  }
}
