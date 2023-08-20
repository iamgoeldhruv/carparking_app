import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserAuth {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    String res='';
    try {
      
      if (firstName.isNotEmpty ||
          lastName.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          confirmPassword != null) {
        if(password!=confirmPassword){
          return "PASSWORD DO NOT MATCH";
        }
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        
       
        // adding user in our database
        print(cred.user!.uid);
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set({'firstName': firstName,
                 'lastName': lastName,
                'uid': cred.user!.uid,
          
                'email': email,
          });

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}

