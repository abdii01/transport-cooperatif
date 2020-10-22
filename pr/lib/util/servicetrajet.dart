import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfinalpfe/util/trajet.dart';

class servicetrajet {
  static final servicetrajet _firestoreservice = servicetrajet._internal();
  Firestore _db = Firestore.instance;

  servicetrajet._internal();
  factory servicetrajet() {
    return _firestoreservice;
  }
  Stream<List<Trajet>> getBus() {
    return _db.collection('trajet').snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Trajet.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
  }

  Future<void> addTrajet(Trajet trajet) {
    return _db.collection('trajet').add(trajet.toMap());
  }

  Future<void> deletrajet(String id) {
    return _db.collection('trajet').document(id).delete();
  }

  Future<void> ubdateus(Trajet trajet) {
    return _db
        .collection('trajet')
        .document(trajet.id)
        .updateData(trajet.toMap());
  }
}
