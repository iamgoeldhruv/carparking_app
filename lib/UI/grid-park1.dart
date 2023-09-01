import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class parkingspacState extends StatefulWidget {
  const parkingspacState({super.key});

  @override
  State<parkingspacState> createState() => _parkingspacStateState();
}

class _parkingspacStateState extends State<parkingspacState> {
  @override
  Widget build(BuildContext context) {
    var p = [1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0];
    int currentParking = 11;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Parking section A'),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Container(
              width: 150,
              child: GridView.count(
                crossAxisCount: 1,
                shrinkWrap: true,
                children: [
                  for (int i = 0; i < p.length; i++)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.yellow,
                            width: 4.0,
                          ),
                        ),
                        child: p[i] == 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 5,
                                    color: Colors.yellow,
                                  ),
                                  Icon(
                                    CupertinoIcons.car_detailed,
                                    size: 90,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    (i + 1).toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 5,
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    CupertinoIcons.car_detailed,
                                    size: 90,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    (i + 1).toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                ],
              ),
            ),
            // Add your image here
            Image.asset(
              'assets/your_image.png', // Replace with the path to your image asset
              width: 150, // Adjust the width as needed
              height: double.infinity, // Match the height to the parent
              fit: BoxFit.cover, // You can adjust the BoxFit as needed
            ),
            CustomPaint(
              size: Size(100, 100),
              painter: LinePainter(),
            ),
          ],
        ),
      ),
    );
  }
}




class LinePainter extends CustomPainter {
  int parking = 10;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue // Set the line color
      ..strokeCap = StrokeCap.round // Round line caps (optional)
      ..strokeWidth = 10.0; // Set the line width
    double x =100;
    double y =-1060;
    var startpoint = Offset(x, y);
    if(parking==1){
      var endpoint = Offset(x ,y+79.94);
    canvas.drawLine(startpoint, endpoint, paint);

    }
    else{
      var endpoint = Offset(x ,y+parking*(137.578947));
      canvas.drawLine(startpoint, endpoint, paint);
    }
    
    
    
  
    
    
    // Starting point
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}