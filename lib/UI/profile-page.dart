import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dash_insta/database/userauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_insta/UI/login-screen.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String FirstName=" ";
  String LastName="";
  String Phone="";
  String Email="";
  @override
  void initState() {
    super.initState();
    
    getcredentials();
  } 

  Future<void> getcredentials() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .get(GetOptions(source: Source.server));

    setState((){
      FirstName=((snap.data() as Map<String,dynamic>)['firstName']).toUpperCase();
      LastName=((snap.data() as Map<String,dynamic>)['lastName']).toUpperCase();
      Email=((snap.data() as Map<String,dynamic>)['email']);
      Phone=((snap.data() as Map<String,dynamic>)['phone']);
      print(FirstName);
      print(LastName);
      print(Email);
      print(Phone);
      
    });

  }
  Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
           
            const SizedBox(height: 120),
            itemProfile('Name', FirstName+ " "+LastName, CupertinoIcons.person),
            const SizedBox(height: 50),
            itemProfile('Phone', Phone, CupertinoIcons.phone),
            const SizedBox(height: 50),
            itemProfile('Address', 'upes,dehradun', CupertinoIcons.location),
            const SizedBox(height: 50),
            itemProfile('Email', Email, CupertinoIcons.mail),
            const SizedBox(height: 50,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: logout,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('LOGOUT')
              ),
            )
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.deepOrange.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}
    
  
