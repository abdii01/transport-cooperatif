
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfinalpfe/util/Station.dart';
import 'package:myfinalpfe/util/user.dart';



class firestrorepassger{
  static final firestrorepassger  _firestoreservice = firestrorepassger._internal();
Firestore _db = Firestore.instance;

firestrorepassger._internal();
factory firestrorepassger(){

   return _firestoreservice;

}
  Stream<List<Station>> getStation(){
 return  _db.collection('passger')
  .snapshots()
  .map((snapshot)=>snapshot.documents.map((doc)=>Station.fromMap(doc.data ,doc.documentID),).toList(),
  );

   }
  Future<void> addStation(user passger){
    return _db.collection('passger').add(passger.toMap());

  } 
  Future<void> deleStation(user id){

    return _db.collection('passger').document(id.id).delete();
  } 
   Future<void> ubdateus(user passger){
return _db.collection('passger').document(passger.id).updateData(passger.toMap());

   }   

}