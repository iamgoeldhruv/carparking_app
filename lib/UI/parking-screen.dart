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
  List directions = [];
  dynamic loc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      directions = [
        {"straight" : 50},
        {"right" : 100},
        {"straight" : 50},
        {"right" : 100},
        {"backward" : 100},
        {"left" : 100},
        {"backward" : 200}
      ];
     
      // Call API for directions here
    });

   

    
  }

Future<dynamic> getpos() async {
BackgroundLocation.setAndroidNotification(
	title: "Notification title",
        message: "Notification message",
        icon: "@mipmap/ic_launcher",
);

BackgroundLocation.setAndroidConfiguration(1000);

BackgroundLocation.startLocationService();

BackgroundLocation.startLocationService(distanceFilter : 10);

// BackgroundLocation.startLocationService(forceAndroidLocationManager: true);

BackgroundLocation.getLocationUpdates((location) {
  print(location.latitude);
  print(location.longitude);
});



 }


  @override
  Widget build(BuildContext context) {
    getpos().then((value) {
      setState(() {
        loc = value;
      });
    },);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
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
              child: Text("Your parking is B23 on the ground floor"),
            ),
            SizedBox(
              height: 0,
            ),
            // SizedBox(
            //   height: 100,
            // ),
            PathExample(directions: directions),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Save to cloud here
                },
                child: Text("Save parking")),
                
          ],
        ),
      ),
    );
  }
}

class PathExample extends StatefulWidget {
  @override
  List directions = [];
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
    return  Container(
        height: 600,
        width: 400,
        color: Colors.white, // Set the background color
       
        );
  }
}



class LinePainter extends CustomPainter {
  List directions = [];
  LinePainter({required this.directions});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue // Set the line color
      ..strokeCap = StrokeCap.round // Round line caps (optional)
      ..strokeWidth = 10.0; // Set the line width
      double x=-100;
      double y=-100;
      for (var directionMap in directions) {
        
        var startPoint = Offset(x, y);
        print(startPoint);      

    directionMap.forEach((key, value) {
      String dir=key;
      int val=value;
      
      if(dir=='left'){
        x=x-val;
        var endPoint=Offset(x,y);
        canvas.drawLine(startPoint, endPoint, paint); // Draw the line
      }
      else if(dir=='right'){
        x=x+val;
        var endPoint=Offset(x,y);
        canvas.drawLine(startPoint, endPoint, paint); // Draw the line
        
      }
      else if(dir=='straight'){
        y=y-val;
        var endPoint=Offset(x,y);
        canvas.drawLine(startPoint, endPoint, paint); // Draw the line
        
      }
      else if(dir=='backward'){
        y=y+val;
        var endPoint=Offset(x,y);
        canvas.drawLine(startPoint, endPoint, paint); // Draw the line
        
      }
  });
}
     
     // Starting point

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

