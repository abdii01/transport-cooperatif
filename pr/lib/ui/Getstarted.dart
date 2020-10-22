import 'dart:async';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_intent/android_intent.dart';
import 'package:geolocator/geolocator.dart';

class Getstarted extends StatefulWidget {
  String nameobus;
  String destination;
  String timerest;
  Getstarted({Key key, this.nameobus, this.destination, this.timerest})
      : super(key: key);

  @override
  _AskForPermissionState createState() => _AskForPermissionState();
}

class _AskForPermissionState extends State<Getstarted> {
  Timer timer;

  String _locationMessage = "";
  double latitude;
  double longtitude;
  double latitude1;
  double longtitude1;
  String latitude12;
  String longtitude12;
  double distance = 1;
  double time;
  double vitesse = 1;
  double timerester;
  double distancegrand = 500;
  String timeres;
  final databref = FirebaseDatabase.instance.reference();

  void calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    distance = 12742 * asin(sqrt(a));
  }

  readdata() async {
    var db = FirebaseDatabase.instance.reference().child("${widget.nameobus}");
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      setState(() {
        latitude12 = values['latitude'];
        longtitude12 = values['longtitude'];
        timeres = values['timerester'];
        latitude1 = double.parse(latitude12);
        longtitude1 = double.parse(longtitude12);
      });
    });
  }

  void _getCurrentLocation() async {
    readdata();
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
      latitude = position.latitude;
      longtitude = position.longitude;
      databref.child("${widget.nameobus}").update({
        'latitude': "${position.latitude}",
        'longtitude': "${position.longitude}",
        'timerester': timerester.toString(),
      });
    });
    calculateDistance(latitude, longtitude, latitude1, longtitude1);
    distancegrand = distancegrand - distance;
  }

  final dbRef = FirebaseDatabase.instance.reference();
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  final PermissionHandler permissionHandler = PermissionHandler();
  Map<PermissionGroup, PermissionStatus> permissions;
  void initState() {
    super.initState();
    requestLocationPermission();
    timer = Timer.periodic(
        Duration(seconds: 15), (Timer t) => _getCurrentLocation());

    vitesse = distance / 15;
    timerester = (distancegrand / vitesse) / 60;

    _checkGps();
  }

  Future<bool> _requestPermission(PermissionGroup permission) async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

/*Checking if your App has been Given Permission*/
  Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.location);
    if (granted != true) {
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
                content:
                    const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        final AndroidIntent intent = AndroidIntent(
                            action:
                                'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                        // _gpsService();
                      })
                ],
              );
            });
      }
    }
  }

/*Check if gps service is enabled or not*/ /*
Future _gpsService() async {
if (!(await Geolocator().isLocationServiceEnabled())) {
  _checkGps();
  return null;
} else
return true;
}*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ask for permisions'),
          backgroundColor: Colors.red,
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Text(timerester.toString()),
            Text(vitesse.toString()),
          ],
        )));
  }
}

/*import 'dart:async';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class Getstarted extends StatefulWidget{
    String nameobus;
    String positin;
      Getstarted({Key key, this.positin,this.nameobus}) : super(key: key); 
  @override
  _Getstarted createState() => _Getstarted();
}

class _Getstarted extends State<Getstarted>{
    Timer timer;
    String _locationMessage = "";
    double latitude;
    double longtitude;
     double latitude1;
    double longtitude1;
     String latitude12;
    String longtitude12;
    double distance =1 ;
    double time;
    double vitesse=1;
    double timerester;
    double distancegrand= 1000;
    String timeres;
     final  databref = FirebaseDatabase.instance.reference();

void calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    distance= 12742 * asin(sqrt(a));
  }
  readdata() async{
var db =  FirebaseDatabase.instance.reference().child("${widget.nameobus}");
db.once().then((DataSnapshot snapshot){
  Map<dynamic, dynamic> values = snapshot.value;
     setState(() {
       latitude12=values['latitude'];
      longtitude12=values['longtitude'] ;
      timeres=values['timerester'];
    latitude1 = double.parse(latitude12);
    longtitude1 =double.parse(longtitude12);
 });
 }
 );
 }

  void _getCurrentLocation() async {
    readdata();
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     
    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
      latitude = position.latitude ;
      longtitude= position.longitude;
      databref.child("${widget.nameobus}").update({
        'latitude':"${position.latitude}",
        'longtitude':"${position.longitude}",
        'timerester': timerester.toString(),
      });     
    });
 calculateDistance(latitude,longtitude,latitude1,longtitude1);
 distancegrand= distancegrand-distance;
  }


@override
void initState() {
  super.initState();
 
  timer = Timer.periodic(Duration(seconds: 15), (Timer t) => _getCurrentLocation());
     
     vitesse = distance/15;
    timerester= (distancegrand/vitesse)/60;
   
}

@override
void dispose() {
  timer?.cancel();
  super.dispose();
}

   @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Location Services")
        ),
        body: Align(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text(timeres.toString()), 
            
            FlatButton(
              onPressed: () {
             
                   _getCurrentLocation();                
              },
              color: Colors.green,
              child: Text("Find Location")
            )
          ]),
        )
      )
    );
  }
}*/
