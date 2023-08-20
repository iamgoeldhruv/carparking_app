import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dash_insta/UI/login-screen.dart';
import 'package:dash_insta/UI/register-screen.dart';


void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DASHCHATT APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        scaffoldBackgroundColor:Color.fromARGB(255, 184, 193, 244)
      ),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text('LETS PARK'),
      //   ),
      //   body: Center(
      //     child: Text('HELLO DHRUV'),
      //   ),
      // ),
      home:LoginScreen(),
    );
  }
}
