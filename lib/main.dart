import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dash_insta/UI/login-screen.dart';
import 'package:dash_insta/UI/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'location.dart';
import 'package:dash_insta/services/notificationclass.dart';
void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  
  NotificationService().initNotification();
  await Firebase.initializeApp();
  // Get the shared preferences instance.
  runApp(const MyApp());
  
  
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

Future <dynamic> getPos() async {
  await getpos();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState()  {
    // TODO: implement initState
     getPos().then((value) {
      try {
        print(value);
      } catch (e) {
        print("error occoured");
      }
     },);
    print("Init called");
    super.initState();
  }
  @override

  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DASHCHATT APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        scaffoldBackgroundColor:Color.fromARGB(255, 184, 193, 244)
      ),
      // ),
     home: StreamBuilder(
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
// home:LoginScreen(),
  

    );
  }
}
