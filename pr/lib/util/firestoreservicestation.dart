import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfinalpfe/util/Station.dart';

class firestrorestation {
  static final firestrorestation _firestoreservice =
      firestrorestation._internal();
  Firestore _db = Firestore.instance;

  firestrorestation._internal();
  factory firestrorestation() {
    return _firestoreservice;
  }
  Stream<List<Station>> getStation() {
    return _db.collection('Station').snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Station.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
  }

  Future<void> addStation(Station station) {
    return _db.collection('Station').add(station.toMap());
  }

  Future<void> deleStation(String id) {
    return _db.collection('Station').document(id).delete();
  }

  Future<void> ubdateus(Station station) {
    return _db
        .collection('Station')
        .document(station.id)
        .updateData(station.toMap());
  }
}
