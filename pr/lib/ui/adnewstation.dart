import 'dart:async';
import 'package:android_intent/android_intent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';
import 'package:myfinalpfe/util/Station.dart';
import 'package:myfinalpfe/util/firestoreservicestation.dart';
import 'package:myfinalpfe/util/stationrealtimedatabase.dart';
import 'package:myfinalpfe/util/stattionreltiemdtabase.dart';
import 'package:permission_handler/permission_handler.dart';

class Checkstation   {
 
    numeroexustounom(String a) {
 return   Firestore.instance.collection('Station').where("num", isEqualTo: a).getDocuments();
}
}
class  addnewStation extends StatefulWidget{
   String id;
    String nomstation;
    String location;
    String type;
   addnewStation({Key key, this.id,this.location,this.nomstation,this.type}) : super(key: key);

  @override
  _addnewstationState createState() => _addnewstationState();
}

class _addnewstationState extends State<addnewStation> {
List<Station> station;
List name;
List statut;
  FocusNode _numberfocsunofe= new FocusNode();
   FocusNode _loctionfocus= new FocusNode();
 
  GlobalKey<FormState>_key= GlobalKey<FormState>();
  TextEditingController _numTextEditingController = new TextEditingController() ;
    TextEditingController _localistionEditorcontoler = new TextEditingController() ;
 
    var _statucurencies = ['work' , 'dont work'];
   var statutselectededd = 'work';
   String lenumerovalue, lestatutvalue;
   Firestore db = Firestore.instance;
   String a="y";
   String t;
   testnameexist(String a) async {
     await Checkstation().numeroexustounom(a).then((QuerySnapshot docs){
         
             if(docs.documents.isNotEmpty){
               setState(() {
                  a="a";
               });
                
                    }

            
      });
        
    }

List<String> listdestation= new List<String>();
List<String> listdeslocalistion= new List<String>();
final dtatbaserealtimeforstation= FirebaseDatabase.instance.reference();
void addstationtorealtimedatabae(String a){
  dtatbaserealtimeforstation.child(a).set({
       'temp':'',
  });
}
int j;
final DocumentReference documentReference =
    Firestore.instance.document("Station");
     Future getsation() async{
  Firestore db = Firestore.instance;
  QuerySnapshot qr = await db.collection('Station').getDocuments();
   return qr.documents;
 }

    Future getsationns() async{
  Firestore db = Firestore.instance;
  await db.collection('Station').getDocuments().then((QuerySnapshot snapshot) {
for(var i=0;i<snapshot.documents.length;i++)
         listdestation.add(snapshot.documents[i].data['num']);
       
  });
   await db.collection('Station').getDocuments().then((QuerySnapshot snapshot) {
for(var i=0;i<snapshot.documents.length;i++)
         listdeslocalistion.add(snapshot.documents[i].data['statut']);
       
  });
   
   
 }

get isedimote =>  widget.id != null ;
@override
final PermissionHandler permissionHandler = PermissionHandler();
 Map<PermissionGroup, PermissionStatus> permissions;
void initState() {
  super.initState();
//  requestLocationPermission();
  getsationns();
if(isedimote){
_dropdownItems.add("TERMINAL");
  _dropdownItems.add("INTETRMIDIATE");
      _dropdownValue="${widget.type}";
     _typecontroler.text="${widget.type}";
     _localistionEditorcontoler.text="${widget.location}";
     _numTextEditingController.text="${widget.nomstation}";
}else{
    _dropdownItems.add("TERMINAL");
  _dropdownItems.add("INTETRMIDIATE");
  _dropdownValue=_dropdownItems[0];
  _typecontroler.text = _dropdownValue;

}

}
 Future<bool> _requestPermission(PermissionGroup permission) async {
final PermissionHandler _permissionHandler = PermissionHandler();
var result = await _permissionHandler.requestPermissions([permission]);
if (result[permission] == PermissionStatus.granted) {
  return true;
}
return false;
}
String _dropdownValue;
TextEditingController _typecontroler =new TextEditingController();
List<String> _dropdownItems = List<String>();

Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
  
var granted = await _requestPermission(PermissionGroup.location);
if (granted!=true) {
  requestLocationPermission();
}
debugPrint('requestContactsPermission $granted');
return granted;
}
/*Show dialog if GPS not enabled and open settings location*/
Future _checkGps() async {
 if (!(await Geolocator().isLocationServiceEnabled())) {
  if (Theme.of(context).platform == TargetPlatform.android) {
showDialog(
   context: context,
   builder: (BuildContext context) {
    return AlertDialog(
     title: Text("Can't get gurrent location"),
     content:const Text('Please make sure you enable GPS and try again'),
     actions: <Widget>[
       FlatButton(child: Text('Ok'),
       onPressed: () {
         final AndroidIntent intent = AndroidIntent(
          action: 'android.settings.LOCATION_SOURCE_SETTINGS');
       intent.launch();
       Navigator.of(context, rootNavigator: true).pop();
      // _gpsService();
      })],
     );
   });
  }
 }
}

 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(
      title:  Text('Station'),
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
     return "give nmae to the station";
   if(!testifthestationexist(value))
      return "this name exist";  

},
       
      decoration:  InputDecoration(
      labelText:"enter name",
      icon: Icon(Icons.home,color: Colors.blue,),
      border: OutlineInputBorder(),
),
),
const SizedBox(height: 10.0,),
                      TextFormField(
              
              textInputAction: TextInputAction.send,
            onEditingComplete: (){
               FocusScope.of(context).requestFocus(_loctionfocus);
               setState(() {
                 a=_localistionEditorcontoler.text;
               });
              },
        controller: _localistionEditorcontoler,
      validator: (value){
  if( value== null || value.isEmpty )
     return "Check your location";
   if(!testifthestationexist(value))
      return "this loction exist";  

},
       
      decoration:  InputDecoration(
      labelText:"enter your location",
      icon: Icon(Icons.location_on,color: Colors.red,),
      border: OutlineInputBorder(),
),
),
           
SizedBox(height: 15.0,),
DropdownButtonHideUnderline(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
            
          new InputDecorator(
            decoration: InputDecoration(
              filled: false,
              hintText: 'Choose type',
              prefixIcon: Icon(Icons.settings_applications,color: Colors.black,),
              labelText:
                  _dropdownValue == null ? 'type' : 'type',
            //  errorText: _errorText,
            ),
           // isEmpty: _dropdownValue == null,
            child: new DropdownButton<String>(
              value: _dropdownValue, style: TextStyle(color: Colors.blue,fontSize: 15),
              isDense: true,
              onChanged: (String newValue) {
                print('value change');
                print(newValue);
                setState(() {
                  _dropdownValue = newValue;
                  _typecontroler.text = _dropdownValue;
                });
              },
              items: _dropdownItems.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ),      

      ],
      ));
      
              
    }),
      floatingActionButton: FloatingActionButton(
     child: Icon(isedimote ? Icons.edit :Icons.add),
     backgroundColor: Colors.blue,
     
     onPressed: () async{
     
     if(isedimote){
           
              if(_numTextEditingController.text.isEmpty || _localistionEditorcontoler.text.isEmpty){
                     await youhavefullallcone(context);             
               }else{
                           if(!testifthestationexist(_numTextEditingController.text) && _numTextEditingController.text!="${widget.nomstation}"){
                               await checkythenameofthestation(context);
                           }else{
                                 
                                    if(!testiftheslocalistionexist(_localistionEditorcontoler.text) && _localistionEditorcontoler.text!=widget.location){
                                          await theloctiongivenexist(context);
                                    }else{
                                                    stationreltimedatabase sttationreltime=stationreltimedatabase(nom:_numTextEditingController.text,id:widget.id);
                                                  firestrorestationrealtimedtabase().ubdateus(sttationreltime);
                                                Station station =   Station(number:_numTextEditingController.text,id: widget.id,localistion:_localistionEditorcontoler.text,type: _typecontroler.text);
         await   firestrorestation().ubdateus(station).then((value){
    
                  
 Navigator.push(context, MaterialPageRoute(builder: (_) => Navigationstation(idex: 0,), ),
     );
     
         });
    }
      }}
 
    
     }else{
               if(_numTextEditingController.text.isEmpty || _localistionEditorcontoler.text.isEmpty){
                     await youhavefullallcone(context);             
               }else{
                           if(!testifthestationexist(_numTextEditingController.text)){
                               await checkythenameofthestation(context);
                           }else{
                                 
                                    if(!testiftheslocalistionexist(_localistionEditorcontoler.text)){
                                          await theloctiongivenexist(context);
                                    }else{
                                             
                                              stationreltimedatabase sttationreltime=stationreltimedatabase(nom:_numTextEditingController.text);
                                                  firestrorestationrealtimedtabase().addStation(sttationreltime);
                                                Station station =   Station(number:_numTextEditingController.text, localistion:_localistionEditorcontoler.text,type: _typecontroler.text);
         await   firestrorestation().addStation(station).then((value){
    
                  
 Navigator.push(context, MaterialPageRoute(builder: (_) => Navigationstation(idex: 0,), ),
     );
     
         });
    }
      }}
     }

     },),
  
      );
  }
 
    Future<bool> checkythenameofthestation(BuildContext context) async{
     return showDialog(
       context: context,
        barrierDismissible: true,
       builder: (context)=>  AlertDialog(
         content: Text("This name of station exist",style: TextStyle(color:Colors.red,fontSize: 15.0),),
         actions: <Widget>[ 
      
   FlatButton(
     textColor: Colors.black,
     child: Text("ok"),
       onPressed: () => Navigator.pop(context,false),
       ),
       ],)
    );
}

    Future<bool> youhavefullallcone(BuildContext context) async{
     return showDialog(
       context: context,
        barrierDismissible: true,
       builder: (context)=>  AlertDialog(
         content: Text("there are items that require your attention",style: TextStyle(color:Colors.red,fontSize: 15.0),),
         actions: <Widget>[ 
      
   FlatButton(
     textColor: Colors.black,
     child: Text("ok"),
       onPressed: () => Navigator.pop(context,false),
       ),
       ],)
    );
}
  Future<bool> theloctiongivenexist(BuildContext context) async{
     return showDialog(
       context: context,
        barrierDismissible: true,
       builder: (context)=>  AlertDialog(
         content: Text("This Location already exist",style: TextStyle(color:Colors.red,fontSize: 15.0),),
         actions: <Widget>[ 
      
   FlatButton(
     textColor: Colors.black,
     child: Text("ok"),
       onPressed: () => Navigator.pop(context,false),
       ),
       ],)
    );
}    
  Future<bool> checkpassword(BuildContext context) async{
     return showDialog(
       context: context,
        barrierDismissible: true,
       builder: (context)=>  AlertDialog(
         content: Text(" the passworve have to be 8 charracters "),
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
bool testiftheslocalistionexist(String a){
  for(var j=0;j<listdeslocalistion.length;j++){
    if(listdeslocalistion[j]==a){
      return false;
    }
  }
return true;
}

bool validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length < 8)
      return false ;
    else 
      return true;
  }
  void _editbus(BuildContext context, String  id) async{
    if(await _showconfermationdialoge(context)){
                if(_localistionEditorcontoler.text.isEmpty || _numTextEditingController.text.isEmpty){
                  if(_localistionEditorcontoler.text.isEmpty && _numTextEditingController.text.isNotEmpty){
                  try{
                    Station station = Station(number: _numTextEditingController.text,id: widget.id,localistion: widget.location,type: widget.type);
                  firestrorestation().ubdateus(station).then((value) {
                       Navigator.push(context, MaterialPageRoute(builder: (_) => Navigationstation(),),);
                  });
                  }catch(e){
                    print(e);
                  }
                  }else{
                    if(_localistionEditorcontoler.text.isEmpty && _numTextEditingController.text.isEmpty){
                 try{
                    Station station = Station(number: widget.nomstation,id: widget.id,localistion: widget.location,type: widget.type);
                  firestrorestation().ubdateus(station).then((value) {
                       Navigator.push(context, MaterialPageRoute(builder: (_) => Navigationstation(),),);
                  });
                  }catch(e){
                    print(e);
                  }


                    }else{
                    try{
                    Station station = Station(number: widget.nomstation,id: widget.id,localistion: _localistionEditorcontoler.text,type: widget.type);
                  firestrorestation().ubdateus(station).then((value) {
                       Navigator.push(context, MaterialPageRoute(builder: (_) => Navigationstation(),),);
                  });
                  }catch(e){
                    print(e);
                  }
                  }
                  }
                }else{
                                 
                    try{
                       Station station = Station(id: widget.id,number:_numTextEditingController.text,type: widget.type,localistion: _localistionEditorcontoler.text );
                firestrorestation().ubdateus(station).then((value) {
                       Navigator.push(context, MaterialPageRoute(builder: (_) => Navigationstation(),),);
                  });
                  }catch(e){
                    print(e);
                  }          
                }
        
}
}
Future<bool> _showconfermationdialoge(BuildContext context) async{
     return showDialog(
       context: context,
        barrierDismissible: true,
       builder: (context)=>  AlertDialog(
         content: Text("ARE YOU SUR YOU WANT TO EDIT THIS STATION",style: TextStyle(color:Colors.red,fontSize: 15.0),),
         actions: <Widget>[ 
       FlatButton(
     textColor:  Colors.red,
     child: Text("ok"),
       onPressed: () => Navigator.pop(context,true),
       ),
   FlatButton(
     textColor: Colors.black,
     child: Text("no"),
       onPressed: () => Navigator.pop(context,false),
       ),
       ],)
    );
}

}

