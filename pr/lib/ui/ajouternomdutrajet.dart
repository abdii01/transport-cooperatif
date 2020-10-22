/*import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/makeline.dart';
import 'package:myfinalpfe/util/Station.dart';


class  Givenametotrajet extends StatefulWidget{
  final String id;

  const Givenametotrajet({Key key, this.id}) : super(key: key);

  @override
  _Givenametotrajet createState() => _Givenametotrajet();
}

class _Givenametotrajet extends State<Givenametotrajet> {
List<Station> station;
List name;
List statut;
  FocusNode _numberfocsunofe= new FocusNode();
 
  GlobalKey<FormState>_key= GlobalKey<FormState>();
  TextEditingController _numTextEditingController = new TextEditingController() ;
    TextEditingController _localistionEditorcontoler = new TextEditingController() ;
 
   String lenumerovalue, lestatutvalue;
   Firestore db = Firestore.instance;
   String a="y";
   String t;
 
List<String> listdestation= new List<String>();
List<String> listdeslocalistion= new List<String>();

int j;
final DocumentReference documentReference =
    Firestore.instance.document("trajet");
     Future getsation() async{
  Firestore db = Firestore.instance;
  QuerySnapshot qr = await db.collection('trajet').getDocuments();
   return qr.documents;
 }

    Future getsationns() async{
  Firestore db = Firestore.instance;
  await db.collection('trajet').getDocuments().then((QuerySnapshot snapshot) {
for(var i=0;i<snapshot.documents.length;i++)
         listdestation.add(snapshot.documents[i].data['num']);
       
  });
   
 }
@override
void initState() {
  super.initState();

getsationns();
}
 
get isedimote =>  widget.id != null ;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(
      title:  Text('trajet'),
    ) ,

    body: FutureBuilder(
    future:    getsation(),
    builder: (_,snapshot){
           
       if(snapshot.hasError || !snapshot.hasData)
      return Center(
       
                 child: CircularProgressIndicator(),);
  
      Expanded( child:  ListView.builder(
              itemCount: snapshot.data.length,
             
  
                       itemBuilder:(_,intdex){
                          for(j=0;j<snapshot.data.length;j++){
                          listdestation.add(snapshot.data[j].data["num"]);}
          }));
     
   return Form(
       key: _key,
 child: Column
      (
                 
   mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
                      TextFormField(
              
              textInputAction: TextInputAction.send,
            onEditingComplete: (){
               FocusScope.of(context).requestFocus(_numberfocsunofe);
               setState(() {
                 a=_numTextEditingController.text;
               });
              },
        controller: _numTextEditingController,
      validator: (value){
  if( value== null || value.isEmpty )
     return "give nmae to the trajet";
   if(!testifthestationexist(value))
      return "this name exist";  

},
       
      decoration:  InputDecoration(
      labelText: "name",
      icon: Icon(Icons.tram),
      border: OutlineInputBorder(),
),
),

const SizedBox(height: 10.0,),
 
      ],
   )
   
   
   );
    }),
   
  floatingActionButton: FloatingActionButton(
     child: Icon(Icons.navigate_next),
     backgroundColor: Colors.deepPurple,
     
     onPressed: () async{
      if(_numTextEditingController.text.isEmpty ){
                   await _showconfermationdialoge(context);
      }else{ 
    if(!testifthestationexist(_numTextEditingController.text)){
        await _showconfermationdialogeo(context);
    }
    else{
       
         Navigator.push(context, MaterialPageRoute(
                             builder: (_)=> Makingkine(nom: ,: _numTextEditingController.text, ),
                           ));
    }
      }
     },),
  
      );
  }
  Future<bool> _showconfermationdialoge(BuildContext context) async{
     return showDialog(
       context: context,
        barrierDismissible: true,
       builder: (context)=>  AlertDialog(
         content: Text("you have to give a name to tarjet "),
         actions: <Widget>[ 
      
   FlatButton(
     textColor: Colors.black,
     child: Text("ok"),
       onPressed: () => Navigator.pop(context,false),
       ),
       ],)
    );
}
  Future<bool> _showconfermationdialogeo(BuildContext context) async{
     return showDialog(
       context: context,
        barrierDismissible: true,
       builder: (context)=>  AlertDialog(
         content: Text("this name is alredy exist "),
         actions: <Widget>[ 
      
   FlatButton(
     textColor: Colors.black,
     child: Text("ok"),
       onPressed: () => Navigator.pop(context,false),
       ),
       ],)
    );
}
bool testifthestationexist(String a){
  for(var j=0;j<listdestation.length;j++){
    if(listdestation[j]==a){
      return false;
    }
  }
return true;
}
}


*/