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
      
      body: Row(
        children: [
          Container(
            width: 150,
            child: GridView.count(
              crossAxisCount: 1,
              children: [
                for (int i = 0; i < p.length; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10), // Add spacing
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.yellow, // Border color
                          width: 4.0, // Border width
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
                                  CupertinoIcons.car_detailed
                                  ,
                                  size: 90,
                                  color: Colors.grey, // You can change the color
                                ),
                                Text((i+1).toString() , style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                ),),
                            ],
                           
                          )
                          :Row(
                           
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  height: 5,
                                  color: Colors.white,
                                ),
                                Icon(
                                  CupertinoIcons.car_detailed
                                  ,
                                  size: 90,
                                  color: Colors.white, // You can change the color
                                ),
                                Text((i+1).toString() , style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                ),),
                            ],
                          )
                    ),
                    
                  ),
              ],
            ),
          ),
          //  CustomPaint(
          //   size: Size(100, 100),
          //   painter: LinePainter(),
          // ),
        ],
      ),
    );
  }
}