import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    String res = '';
    try {
      if (firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          confirmPassword.isNotEmpty) { // Check if all fields are not empty
        if (password != confirmPassword) {
          return "PASSWORD_DO_NOT_MATCH";
        }

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Adding user to the Firestore database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set({
              'firstName': firstName,
              'lastName': lastName,
              'uid': cred.user!.uid,
              'email': email,
            });

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = '';
    try {
      if (password.isNotEmpty && email.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      } else {
        res = "Please enter both email and password";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
