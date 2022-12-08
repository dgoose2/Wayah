import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  Map<String, dynamic>? userData;
  String email = '';
  String username = '';

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        userData = ds.data();
        print(userData);
      }).catchError((e) {
        print(e);
      });
    }
  }

  String getEmail() {
    _fetch();
    // print(userData);

    // email = userData!['email'].toString();
    email = 'poo';
    // print(userData!['email'].toString());

    return email;
  }

  String getUsername() {
    username = userData!['username'].toString();
    return username;
  }
}
