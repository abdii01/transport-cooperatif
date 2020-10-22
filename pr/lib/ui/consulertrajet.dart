import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfinalpfe/ui/Nsvgastionbarstation.dart';

class consulertrajet extends StatefulWidget {
  String nomdutrajet ;
   String poindudepart;
   String pointdarriver;
   List<String> listdesstatinintmidiare=List<String>();
  consulertrajet({Key key ,this.nomdutrajet,this.listdesstatinintmidiare,this.poindudepart,this.pointdarriver}): super(key:key);
  _consulertrajet createState() => new _consulertrajet();
}

class _consulertrajet extends State<consulertrajet> {

  Future getvalue() async{
  var fires =Firestore.instance;
  QuerySnapshot qn= await fires.collection('trajet').getDocuments();
  return qn.documents;
   }
 String line;


  @override
void initState() {
super.initState();
for(var i=0;i<widget.listdesstatinintmidiare.length;i++){
  if(i==0){
     line="Ride line : ${widget.poindudepart} -->${widget.listdesstatinintmidiare[0]}";
     if(widget.listdesstatinintmidiare.length==1){
       line=line+ "-->${widget.pointdarriver}";
     }
  }
  else{

         line=line +"---> ${widget.listdesstatinintmidiare[i]} ";
    
  }
}
line =line+"-->${widget.pointdarriver}";
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     appBar: AppBar(
       title: Text("${widget.nomdutrajet}",style: TextStyle(fontSize: 20.0)),
       leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: ()
       {
        
 Navigator.push(context, MaterialPageRoute(builder: (_) => Navigationstation(idex: 2,), ));
       }),
       backgroundColor: Colors.blue,
     ) ,
    body: FutureBuilder(
      
    future: getvalue(), 
    builder: (_,snapshot){
           
       if(snapshot.hasError|| !snapshot.hasData )
      return Center(
       
                 child: CircularProgressIndicator(),);
  
      return Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("name of ride : "+widget.nomdutrajet,textAlign: TextAlign.center,style: TextStyle(color: Colors.green,fontSize: 20.0),),
                    Text("Start point : "+widget.poindudepart,textAlign: TextAlign.center,style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 20.0),),
                    Text("End of ride : "+widget.pointdarriver,textAlign: TextAlign.center,style: TextStyle(color: Colors.blue,fontSize: 20.0),),
                    Text(line,textAlign: TextAlign.center,style: TextStyle(color: Colors.red,fontSize: 20.0),),
            ],
                ),
              ),
      );     
    }),
    );
  }

}