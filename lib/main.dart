import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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
        
        scaffoldBackgroundColor:Colors.yellow,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('DASHCHATT APP'),
        ),
        body: Center(
          child: Text('HELLO WORLD'),
        ),
      ),
    );
  }
}
