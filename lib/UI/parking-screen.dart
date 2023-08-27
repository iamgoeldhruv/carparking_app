import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../location.dart';
import 'package:background_location/background_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  }

//   Future<dynamic> getpos() async {
//     BackgroundLocation.setAndroidNotification(
//       title: "Notification title",
//       message: "Notification message",
//       icon: "@mipmap/ic_launcher",
//     );

//     BackgroundLocation.setAndroidConfiguration(1000);

//     BackgroundLocation.startLocationService();

//     BackgroundLocation.startLocationService(distanceFilter: 10);

// // BackgroundLocation.startLocationService(forceAndroidLocationManager: true);

//     await BackgroundLocation.getLocationUpdates((location) {
//       return location;
//     });
//   }

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
                    Navigator.of(context).pop();
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
    texttPainter.paint(canvas,  Offset(x+10, y+10));
    
    // Starting point
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


// @Dhruv Please implement this with map , it is scrollable..

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
                directionMap.values.first.toString()+"m",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
      ]);
  }
}
