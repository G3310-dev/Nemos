import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrap {
  final FirebaseAuth _firebaseAuth;

  AuthWrap(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async{
    FirebaseAuth.instance.signOut();
  }

  Future<void> signIn({required String email, required String password, required BuildContext context}) async {
    try {
      if(email.isEmpty || !email.contains("@")){
        // Fluttertoast.showToast(msg: "Enter A Valid Email", toastLength: Toast.LENGTH_SHORT);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Enter A Valid Email"),
          duration: Duration(milliseconds: 700),
        ));
      } else if(password.isEmpty){
        // Fluttertoast.showToast(msg: "Password Is Empty", toastLength: Toast.LENGTH_SHORT);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password Is Empty"),
          duration: Duration(milliseconds: 700),
        ));
      } else {
        FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      // Fluttertoast.showToast(msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        duration: const Duration(milliseconds: 700),
      ));
    }
  }

  signUp({required String email, required String password, required String confirm, required BuildContext context}) {
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Fluttertoast.showToast(msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        duration: const Duration(milliseconds: 700),
      ));
    }
  }
}