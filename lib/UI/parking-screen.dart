import 'dart:ui';
import 'dart:math' show cos, sqrt, asin;
import 'dart:math' show cos, sqrt, asin, pow, sin;


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../location.dart';
import 'package:background_location/background_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dash_insta/services/notificationclass.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

double lat=0;
double lng=0;
String? result;
double parkinglat=29.86846829292649;
double parkinglng=77.90404325479828;


class parkingScreen extends StatefulWidget {
  const parkingScreen({super.key});

  @override
  State<parkingScreen> createState() => _parkingScreenState();
}

class _parkingScreenState extends State<parkingScreen> {
  dynamic directions = [];
  dynamic loc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getUserLocation();
    setState(() {
      directions = [
        {"straight": 50},
        {"right": 100},
        {"straight": 50},
        {"right": 100},
        {"backward": 100},
        {"left": 100},
        {"backward": 200}
      ];

      // Call API for directions here
    });

    getpos().then((value) {
      if (value != null) {
        setState(() {
          loc = value;
        });
      }
    });
  }
  double distance(double lat1, double lon1, double lat2, double lon2) {
  const r = 6372.8; // Earth radius in kilometers

  final dLat = _toRadians(lat2 - lat1);
  final dLon = _toRadians(lon2 - lon1);
  final lat1Radians = _toRadians(lat1);
  final lat2Radians = _toRadians(lat2);

  final a = _haversin(dLat) + cos(lat1Radians) * cos(lat2Radians) * _haversin(dLon);
  final c = 2 * asin(sqrt(a));
  print(lat);
  print(lng);
  print(r*c);

  return r * c;
}

double _toRadians(double degrees) => degrees * 3.141592653589793238 / 180;

num _haversin(double radians) => pow(sin(radians / 2), 2);

  Future<dynamic> getpos() async {
    BackgroundLocation.setAndroidNotification(
      title: "Notification title",
      message: "Notification message",
      icon: "@mipmap/ic_launcher",
    );

    BackgroundLocation.setAndroidConfiguration(1000);

    BackgroundLocation.startLocationService();

    BackgroundLocation.startLocationService(distanceFilter: 10);

// BackgroundLocation.startLocationService(forceAndroidLocationManager: true);
                                                    
    BackgroundLocation.getLocationUpdates((location) {
      
    });
  }
  Future<bool> checkPermission() async {
    bool isEnable = false;
    LocationPermission permission;

    //check if location is enable
    isEnable = await Geolocator.isLocationServiceEnabled();
    if (!isEnable) {
      return false;
    }

    //check if use allow location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // if permission is denied then request user to allow permission again
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // if permission denied again
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }
  getUserLocation() async {
    var isEnable = await checkPermission();
    if (isEnable) {
      Position location = await Geolocator.getCurrentPosition();
      setState(() {
        result = "";
        lat = location.latitude;
        lng = location.longitude;
      });
    } else {
      setState(() {
        result = "Permissoin is not allow";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getpos().then(
      (value) {
        print(value);
      },
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Center(
                  child: Text(
                "Parking",
                style: TextStyle(fontSize: 40),
              )),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Your parking is B23 on the ground floor",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  "Map",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              PathExample(
                directions: directions,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Steps",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Steps(directions: directions),
              ElevatedButton(
                  onPressed: () {
                   

                    double r=distance(lat,lng,parkinglat,parkinglng);
                    if(r<0.011111111){
                      NotificationService()
                    .showNotification(title: 'Parking Update', body: 'Your car has been successfully parked!');
                    Navigator.of(context).pop();

                    }
                    else{
                      NotificationService()
                    .showNotification(title: 'Parking Update', body: 'You are outside the parking!');
                    Navigator.of(context).pop();
                    }
                    
                    
                     
                    // Save to cloud here
                  },
                  child: Text("Save parking")),
            ],
          ),
        ),
      ),
    );
  }
}

class PathExample extends StatefulWidget {
  @override
  dynamic directions = [];
  PathExample({required this.directions});
  @override
  State<PathExample> createState() => _PathExampleState();
}

class _PathExampleState extends State<PathExample> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget build(BuildContext context) {
    // double long;
    // double lat;
    // if (widget.loc.longitude != null) {
    //   long = widget.loc.longitude!.toDouble();
    //   lat = widget.loc.latitude!.toDouble();
    // } else {
    //   long = 0;
    //   lat = 0;
    // }
    return Container(
      height: 450,
      width: 400,
      color: Colors.white, // Set the background color
      child: Column(
        children: [
          CustomPaint(
            size: Size(400, 400),
            painter: LinePainter(directions: widget.directions),
          ),
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  dynamic directions = [];
  LinePainter({required this.directions});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue // Set the line color
      ..strokeCap = StrokeCap.round // Round line caps (optional)
      ..strokeWidth = 10.0; // Set the line width
    double x = 100;
    double y = 200;

    final TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: "Entrance",
            style: TextStyle(color: Colors.black, fontSize: 16)),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: size.width - 12.0 - 12.0);
    textPainter.paint(canvas, const Offset(70.0, 230.0));

    for (var directionMap in directions) {
      var startPoint = Offset(x, y);
      directionMap.forEach((key, value) {
        String dir = key;
        int val = value;
        if (dir == 'left') {
          x = x - val;
          var endPoint = Offset(x, y);
          canvas.drawLine(startPoint, endPoint, paint); // Draw the line
        } else if (dir == 'right') {
          x = x + val;
          var endPoint = Offset(x, y);
          canvas.drawLine(startPoint, endPoint, paint); // Draw the line
        } else if (dir == 'straight') {
          y = y - val;
          var endPoint = Offset(x, y);
          canvas.drawLine(startPoint, endPoint, paint); // Draw the line
        } else if (dir == 'backward') {
          y = y + val;
          var endPoint = Offset(x, y);
          canvas.drawLine(startPoint, endPoint, paint); // Draw the line
        }
      });
    }
    final TextPainter texttPainter = TextPainter(
        text: TextSpan(
            text: "Your Parking Is Here",
            style: TextStyle(color: Colors.black, fontSize: 16)),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: size.width - 12.0 - 12.0);
    texttPainter.paint(canvas, Offset(x + 10, y + 10));

    // Starting point
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Steps extends StatelessWidget {
  dynamic directions;
  Steps({super.key, required this.directions});

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        // children: [
        //   for (var item in directions)
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         if (item.key == 'left')
        //           Icon(
        //             Icons.turn_left_rounded,
        //             color: Colors.blue,
        //             size: 50,
        //           ),
        //         if (item.key == 'right')
        //           Icon(
        //             Icons.turn_right_rounded,
        //             color: Colors.blue,
        //             size: 50,
        //           ),
        //         if (item.key == "straight")
        //           Icon(
        //             Icons.straight,
        //             color: Colors.blue,
        //             size: 50,
        //           ),
        //         Text(
        //           item,
        //           style: TextStyle(fontSize: 20),
        //         )
        //       ],
        //     )
        // ]);
        children: [
          for (var directionMap in directions)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (directionMap.containsKey('left'))
                  Icon(
                    Icons.turn_left_rounded,
                    color: Colors.blue,
                    size: 50,
                  ),
                if (directionMap.containsKey('right'))
                  Icon(
                    Icons.turn_right_rounded,
                    color: Colors.blue,
                    size: 50,
                  ),
                if (directionMap.containsKey('straight'))
                  Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.blue,
                    size: 50,
                  ),
                if (directionMap.containsKey('backward'))
                  Icon(
                    Icons.arrow_downward_rounded,
                    color: Colors.blue,
                    size: 50,
                  ),
                Text(
                  directionMap.values.first.toString() + "m",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
        ]);
  }
}
