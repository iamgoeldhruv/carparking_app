import 'package:dash_insta/UI/dashboard.dart';
import 'package:dash_insta/UI/parking-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dash_insta/UI/login-screen.dart';
import 'package:dash_insta/UI/splash-screen.dart';
import 'package:dash_insta/UI/splash-screen.dart';
import 'package:dash_insta/UI/grid-park1.dart';
import 'package:dash_insta/UI/parkingscreena.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dash_insta/services/notificationclass.dart';
import 'dart:async'; // Add this import at the top of your file

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    StreamBuilder(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.active) {
      if (snapshot.hasData) {
        return  DashboardPage(); 
      } else if (snapshot.hasError) {
        return Center(
          child: Text('${snapshot.error}'),
        );
      }
    }
    return const LoginScreen(); 
  },
            )
        )
    ));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 13, 198, 195), // Set the background color to black
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/appimage.png"),
                width: 200,
              ),
              SizedBox(height: 50),
              SpinKitFadingCircle(
                color: Colors.white,
                size: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
