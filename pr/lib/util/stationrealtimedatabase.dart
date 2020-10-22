import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfinalpfe/util/stattionreltiemdtabase.dart';

class firestrorestationrealtimedtabase {
  static final firestrorestationrealtimedtabase _firestoreservice =
      firestrorestationrealtimedtabase._internal();
  Firestore _db = Firestore.instance;

  firestrorestationrealtimedtabase._internal();
  factory firestrorestationrealtimedtabase() {
    return _firestoreservice;
  }
  Stream<List<stationreltimedatabase>> getStation() {
    return _db.collection('stationreltimedatabase').snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (doc) =>
                    stationreltimedatabase.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
  }

  Future<void> addStation(stationreltimedatabase station) {
    return _db.collection('stationreltimedatabase').add(station.toMap());
  }

  Future<void> deleStation(stationreltimedatabase id) {
    return _db.collection('stationreltimedatabase').document(id.id).delete();
  }

  Future<void> ubdateus(stationreltimedatabase station) {
    return _db
        .collection('stationreltimedatabase')
        .document(station.id)
        .updateData(station.toMap());
  }
}
