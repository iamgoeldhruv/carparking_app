import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';




class parkingspacState extends StatefulWidget {
  String options;
   parkingspacState({super.key,required this.options});

  @override
  State<parkingspacState> createState() => _parkingspacStateState();
}
Future getData(String s) async{
    String localhost="http://43.205.239.212:8000/${s}";
    dynamic response=await http.get(Uri.parse(localhost));
    final jsonData= jsonDecode(response.body);
    return jsonData;
  }
class _parkingspacStateState extends State<parkingspacState> {
  @override
  dynamic data;
  void initState() {
    // TODO: implement initState
    super.initState();
    dynamic temp = getData(widget.options).then((value) {
      setState(() {
        data=value;
      });
    },);
  
  }
  
  Widget build(BuildContext context) {
    List<String>p=data['parkLst']?.split("");
    print(p);
    
    int currentParking = 11;
    if(data!=null){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Parking section A'),
      ),
     
      body: SingleChildScrollView(
         
        child: Row(
          
          children: [
            SizedBox(height: 20),
            Container(
              width: 145,
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
                                    color: Colors.black,
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
                                    color: Colors.black,
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
            
            CustomPaint(
              size: Size(100, 100),
              painter: LinePainter(),
            ),
          ],
        ),
      ),
    );}else{
      return CircularProgressIndicator();
    }
  }
  }





class LinePainter extends CustomPainter {
  int parking =2;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // Set the line color
      ..strokeCap = StrokeCap.round // Round line caps (optional)
      ..strokeWidth = 10.0; // Set the line width
    double x =140;
    double y =-300;
    var startpoint = Offset(x, y);
    if(parking==1){
      y=y+parking*(81.94);
      var endpoint = Offset(x ,y);
    canvas.drawLine(startpoint, endpoint, paint);
    canvas.drawLine(startpoint, endpoint, paint);
      var endpoint1 = Offset(x-110 ,y);

    }
    else{
      y=y+parking*(120.578947);
      var endpoint = Offset(x ,y);
      canvas.drawLine(startpoint, endpoint, paint);
      var endpoint1 = Offset(x-110 ,y);
      
      canvas.drawLine(endpoint, endpoint1, paint);
    }
    
    
    
  
    
    
    // Starting point
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}