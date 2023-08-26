import 'package:flutter/material.dart';

class parkingScreen extends StatefulWidget {
  const parkingScreen({super.key});

  @override
  State<parkingScreen> createState() => _parkingScreenState();
}

class _parkingScreenState extends State<parkingScreen> {
  List directions = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      directions = ["left", "straight", "left", "right"];
      // Call API for directions here
    });
    print(directions);
  }

  @override
  Widget build(BuildContext context) {
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
              height: 20,
            ),
            Center(
                child: Text(
              "Directions",
              style: TextStyle(fontSize: 30),
            )),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                for (var item in directions)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (item == 'left')
                        Icon(
                          Icons.turn_left_rounded,
                          color: Colors.blue,
                          size: 50,
                        ),
                      if (item == 'right')
                        Icon(
                          Icons.turn_right_rounded,
                          color: Colors.blue,
                          size: 50,
                        ),
                      if (item == "straight")
                        Icon(
                          Icons.straight,
                          color: Colors.blue,
                          size: 50,
                        ),
                      Text(
                        item,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  )
              ],
            ),
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
