/*import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';
import 'package:myfinalpfe/ui/adnewstation.dart';
import 'package:myfinalpfe/util/Station.dart';


class  Enregistrerasstation extends StatefulWidget{
  final String id;

  const Enregistrerasstation({Key key, this.id}) : super(key: key);

  @override
  _Enregistrerasstation createState() => _Enregistrerasstation();
}

class _Enregistrerasstation extends State<Enregistrerasstation> {
List<Station> station;
List name;
List statut;
  FocusNode _numberfocsunofe= new FocusNode();
   FocusNode _paswordfucs= new FocusNode();
 int conctentrrepassanname =-1;
  GlobalKey<FormState>_key= GlobalKey<FormState>();
  TextEditingController _numTextEditingController = new TextEditingController() ;
    TextEditingController _passwordcontorler = new TextEditingController() ;
 
   String lenumerovalue, lestatutvalue;
   Firestore db = Firestore.instance;
   String a="y";
   String t;
 String _idstation;
List<String> listdestation= new List<String>();
List<String> listdeslocalistion= new List<String>();
List<String> listofpassword=new List<String>();
int j;
final DocumentReference documentReference =
    Firestore.instance.document("Station");
     Future getsation() async{
  Firestore db = Firestore.instance;
  QuerySnapshot qr = await db.collection('Station').getDocuments();
   return qr.documents;
 }
List<String> listidstaton =List<String>();
    Future getsationns() async{
  Firestore db = Firestore.instance;
  await db.collection('Station').getDocuments().then((QuerySnapshot snapshot) {
for(var i=0;i<snapshot.documents.length;i++)
         listdestation.add(snapshot.documents[i].data['num']);
      
  });
   await db.collection('Station').getDocuments().then((QuerySnapshot snapshot) {
for(var i=0;i<snapshot.documents.length;i++)
        
         listofpassword.add(snapshot.documents[i].data['password']);
  });
   await db.collection('Station').getDocuments().then((QuerySnapshot snapshot) {
for(var i=0;i<snapshot.documents.length;i++)
        
         listidstaton.add(snapshot.documents[i].documentID);
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
  
    return Scaffold(appBar: AppBar(
      title:  Text('Station'),
      leading: IconButton(icon: Icon(Icons.arrow_back,),
             onPressed: (){
           
                   Navigator.of(context).pushReplacementNamed('/navigationlogin');      
             }               
           ),
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
                          listdestation.add(snapshot.data[j].data["num"]);
                          }
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
     return "give nmae to the station";
   if(!testifthestationexist(value))
      return "this dont  exist";  

},
       
      decoration:  InputDecoration(
      labelText: "name",
      icon: Icon(Icons.tram),
      border: OutlineInputBorder(),
),
),

const SizedBox(height: 10.0,),
 
                      TextFormField(
                 textInputAction: TextInputAction.next,
            onEditingComplete: (){
            FocusScope.of(context).requestFocus(_paswordfucs);
              },
        controller: _passwordcontorler,
        obscureText:true,
      validator: (value){
  if( value== null || value.isEmpty || !tespasswordexist(value) || !validateMobile(value) ){
     return "you have to enter a correct passworrd";
  }
  
},      
        decoration:  InputDecoration(

    labelText: "password",
    icon: Icon(Icons.vpn_key),
    border: OutlineInputBorder(),
),
),
       
 

 
const SizedBox(height: 10.0,),
 
             FlatButton(
               child: Text('Login' ),
               color: Colors.deepPurple,
               textColor: Colors.white,
               onPressed: () {
                 if(_key.currentState.validate()){

 Navigator.push(context, MaterialPageRoute(builder: (_) => Navigationstation(nomstation: _numTextEditingController.text,id: _idstation,),

     ),
     );               
               } }),
           SizedBox(height: 15.0,),
             Text('Don\'t  have an account'),
             SizedBox(height: 15.0,),
            FlatButton(
               child: Text('Register' ),
               color: Colors.green,
               textColor: Colors.white,
               onPressed: (){

                 Navigator.of(context).pushNamed('/regeration');
               },
             ),
                     
                     
                     ],
   )
   
   
   );
    }),
   
  floatingActionButton: FloatingActionButton(
     child: Icon(Icons.add),
     backgroundColor: Colors.deepPurple,
     
     onPressed: () async{
       
 Navigator.push(context, MaterialPageRoute(builder: (_) => addnewStation()));
       
     },),
  
      );
  }
 
bool testifthestationexist(String a){
  for(int j=0;j<listdestation.length;j++){
    if(listdestation[j]==a){
      setState(() {
        conctentrrepassanname = j;
        _idstation=listidstaton[j];
              });
        return true;
      
    
    }
  }
return false;
}
bool tespasswordexist(String a){
    
  if(conctentrrepassanname!=-1){
    if(listofpassword[conctentrrepassanname]==a){
      return true;
    }
  }
    
    
  
return false;
}

bool validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length < 8)
      return false ;
    else 
      return true;
  }
}


*/