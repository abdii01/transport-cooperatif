/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/adnewstation.dart';
import 'package:myfinalpfe/ui/gerestation.dart';
import 'package:myfinalpfe/util/Station.dart';
import 'package:myfinalpfe/util/firestoreservicestation.dart';
class Addbustosation extends StatefulWidget{
  final String numerooo;
  final String statuttt;
  final String id;
    Addbustosation({Key key, this.numerooo, this.statuttt,this.id}) : super(key: key);
  @override
  _addbustosation createState() => _addbustosation();
  
}

class _addbustosation extends State<Addbustosation>{
List<DocumentSnapshot> snapshot;
  int i=0;
  int r=0;
  int s=0;
  int j=0;
  String nom= "sattionname";
Station station;  

 List<String> listdestation= new List<String>();
List<bool> inputs = new List<bool>();
List<String> addstation=new List<String>();
String a;


@override
void initState() {
  // TODO: implement initState
  super.initState();
  setState(() {
    for(int i=0;i<200;i++){
      inputs.add(false);
    }
  });
     Rvw().numeroexustounom("${widget.numerooo}").then((QuerySnapshot docs){
         if(docs.documents.isNotEmpty){
                    a="a";
                    }
          else 
                 a="b";
             
            
    });

}

void ItemChange(bool val,int index){
  setState(() {
    inputs[index] = val;
  });
}
void getallsectstation() async{
try{
for(r=0;r<listdestation.length;r++){
  if(inputs[r]==true){
    for(j=0;j<listdestation.length;j++){
      if(r==j){
             addstation.add(listdestation[j]);
      }
    }
  }

}
print("${widget.numerooo}");
print("${widget.statuttt}");
}catch(e){
  print(e);
}
}

     Future getsation() async{
  Firestore db = Firestore.instance;
  QuerySnapshot qr = await db.collection('buus').getDocuments();
   return qr.documents;
 }

 get isedimote =>  widget.id != null ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return Container(
      
       child: FutureBuilder(   future: getsation(),
    builder: (_,snapshot){
       if(snapshot.hasError || !snapshot.hasData)
      return Center(
                 child: CircularProgressIndicator(),);
  return MaterialApp(
        
        
          home: Scaffold(
             appBar: AppBar(
         title: const Text('add station')),
              
  
             body:Column( 
               
               children: <Widget>[
                 
               

      Expanded( child:  ListView.builder(
              itemCount: snapshot.data.length,
             
  
                       itemBuilder:( _,index ){
                         
        for(j=0;j<snapshot.data.length;j++){
           listdestation.add(snapshot.data[j].data["num"]); }                      
 
                          return CheckboxListTile (
                            checkColor: Colors.white,
                             activeColor: Colors.blue,    
                           title: Text(snapshot.data[index].data["num"]),
                           
                           value:inputs[index],
                           onChanged:(bool val){ItemChange(val, index);},
);
},
)
),
               RaisedButton(
      child: Text(isedimote?"UBDATE":"save", style: TextStyle(fontSize: 18),),
      onPressed:() async{
getallsectstation();
        try{

if(a=="a"){
            return showDialog(
       context: context,
       barrierDismissible: true,
       builder: (context)=>  AlertDialog(
         content: Text(" the name is alredy exist please change it"),
         actions: <Widget>[ 
      
   FlatButton(
     textColor: Colors.black,
     child: Text("no"),
       onPressed: () =>Navigator.pop(context,),
       ),
       ],)
    
     
     );
      }



       else{   /*if(addstation.isEmpty){
           return showDialog(
       context: context,
       barrierDismissible: true,
       builder: (context)=>  AlertDialog(
         content: Text("ARE YOU SUR YOU WNAT TO add this station"),
         actions: <Widget>[ 
      
   FlatButton(
     textColor: Colors.black,
     child: Text("no"),
       onPressed: () => Navigator.pop(context,false),
    
       ),
       ],)
    
     
     );
 }
 */         
if(!isedimote){
      
/*
Station station =   Station(number:"${widget.numerooo.toString()}" , statut: "${widget.statuttt}",bus: addstation);
         await   firestrorestation().addStation(station).then((value){
     
         Navigator.push(context, MaterialPageRoute(builder: (_) => Gererstation( ), 
     ),
     );
        
        
         });       
         }
         else{
Station station =   Station(number:"${widget.numerooo.toString()}" , statut: "${widget.statuttt}",bus: addstation,id: "${widget.id}");
await firestrorestation().ubdateus(station).then((onValue){
       Navigator.push(context, MaterialPageRoute(builder: (_) => Gererstation(),),
     );
*//*
}).catchError((e){
      print(e);
    });   

         }
         
         
         }}catch(e){
  print(e);}
      } ,
      color: Colors.deepOrange,
      textColor: Colors.white,
      splashColor: Colors.grey,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
),
]
)
)
);
}
),
);
}

}*/
class Rvw {
    numeroexustounom(String a) {
 return   Firestore.instance.collection('Station').where("num", isEqualTo: a).getDocuments();
}
}*/