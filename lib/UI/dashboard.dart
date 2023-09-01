import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_insta/UI/map-screen.dart';
import 'package:dash_insta/UI/grid-park1.dart';
import 'package:dash_insta/UI/profile-page.dart';
import 'package:dash_insta/location.dart';
import 'package:dash_insta/location.dart';
import 'package:info_popup/info_popup.dart';
import 'parking-screen.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String greeting = '';
  bool _isPressed = true;
  String Name = '';
  var items = [
    "Select Parking",
    "A",
    "B"
  ];
  String dropdownvalue = 'Select Parking';
  @override
  void initState() {
    super.initState();
    fetchGreeting();
    getName();
  }

  Future<void> getName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      Name = ((snap.data() as Map<String, dynamic>)['firstName']).toUpperCase();
    });
  }

  Future<void> fetchGreeting() async {
    var dt = DateTime.now();
    var hour = dt.hour;

    if (hour >= 0 && hour < 12) {
      setState(() {
        greeting = 'Good Morning';
      });
    } else if (hour >= 12 && hour < 18) {
      setState(() {
        greeting = 'Good Afternoon';
      });
    } else if (hour > 18) {
      setState(() {
        greeting = 'Good Evening';
      });
    }
  }

  // Widget itemDashboard(String title, IconData iconData, Color background) {
  //   return Container(
  //     width: 5, // Adjust the width as needed
  //     height:2, // Adjust the height as needed
  //     decoration: BoxDecoration(
  //       color: const Color.fromARGB(255, 198, 227, 240),
  //       borderRadius: BorderRadius.circular(10),

  //       boxShadow: [
  //         BoxShadow(
  //           offset: const Offset(0, 5),
  //           color: Theme.of(context).primaryColor.withOpacity(.2),
  //           spreadRadius:1,
  //           blurRadius: 5,
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           padding: const EdgeInsets.all(10),
  //           decoration: BoxDecoration(
  //             color: background,
  //             shape: BoxShape.circle,
  //           ),
  //           child: Icon(iconData, color: Colors.white,size:20),
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           title.toUpperCase(),
  //           style: Theme.of(context).textTheme.headline6,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 47, 56, 106),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 80),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Welcome Proff' + " " + Name + '!',
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                        color: const Color.fromARGB(255, 240, 236, 236),
                        fontWeight: FontWeight.normal),
                  ),
                  subtitle: Text(
                    greeting,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: const Color.fromARGB(137, 239, 237, 237),
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          Container(
            color: Color.fromARGB(255, 47, 56, 106),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Add your action here when the button is pressed
                  //     setState(() {
                  //       _isPressed = true;
                  //     });
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.blue,
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: 10,
                  //         horizontal: 20), // Adjust padding as needed
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Text(
                  //         'Search Parking',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 34, // Adjust font size as needed
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  _isPressed == true ? InfoPopupWidget(
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      // Array list of items
                      items: items.map((String items) {
                         return DropdownMenuItem(
                          value: items,
                          child: ElevatedButton(
                              onPressed: () {
                                if (items != "Select Parking") {
                                  setState(() {
                                    _isPressed = false;
                                  });
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          parkingspacState(options: items)));
                                      
                                } else {
                                 
                                }
                              },
                              child: Text(items)),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ) : SizedBox(),

                  SizedBox(height: 10), // Adjust spacing here

                  GridView.count(
                      // shrinkWrap:true,

                      // physics: const NeverScrollableScrollPhysics(),
                      // crossAxisCount: 1,

                      // crossAxisSpacing: 10,
                      // mainAxisSpacing:20,
                      // children: [
                      //   itemDashboard(
                      //       'Profile', CupertinoIcons.profile_circled, Colors.deepOrange,
                      //     ),
                      //   itemDashboard(
                      //       'Parking Info', CupertinoIcons.car_detailed, Colors.green),
                      //   itemDashboard(
                      //       'Settings', CupertinoIcons.settings, Colors.purple),
                      // ],
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 30,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()),
                            );
                          },
                          child: itemDashboard(
                              ' Profile',
                              CupertinoIcons.profile_circled,
                              Colors.deepOrange),
                        ),

                        itemDashboard(
                            'Settings', CupertinoIcons.settings, Colors.green),
                        itemDashboard(
                            'Park Details', CupertinoIcons.car, Colors.purple),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => dirPage()),
                            );
                          },
                          child: itemDashboard(
                            'Directions',
                            CupertinoIcons.arrow_2_circlepath,
                            Colors.brown,
                          ),
                        ),

                        // itemDashboard('Upload', CupertinoIcons.add_circled, Colors.teal),
                        itemDashboard('About', CupertinoIcons.question_circle,
                            Colors.blue),
                        itemDashboard(
                            'Contact', CupertinoIcons.phone, Colors.pinkAccent),
                      ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemDashboard(String title, IconData iconData, Color background) {
    return Container(
      width: 5, // Adjust the width as needed
      height: 2, // Adjust the height as needed
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 198, 227, 240),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Theme.of(context).primaryColor.withOpacity(.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}