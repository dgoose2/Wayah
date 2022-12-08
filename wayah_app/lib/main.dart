import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:wayah_app/screens/no_access.dart';
import 'package:wayah_app/screens/profile_screen.dart';
import 'package:wayah_app/screens/signup_screen.dart';
import 'package:wayah_app/screens/trip_screen.dart';
import 'firebase_options.dart';

import 'package:wayah_app/screens/login_screen.dart';
import 'package:wayah_app/screens/home_screen.dart';

import 'provider/user_provider.dart';

//dylan iscool

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserData()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  String username = '';
  String email = '';
  static var firebaseUser;

  _fetch() async {
    firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        username = ds.data()!['username'].toString();
        email = ds.data()!['email'].toString();
        // print(email);
      }).catchError((e) {
        print(e);
      });
    }
  }

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _fetch();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wayah',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data?.uid);
            return HomeScreen(
              firebaseUser: firebaseUser,
            );
          }
          return LoginScreen();
        }),
      ),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        TripScreen.routeName: (ctx) => TripScreen(
              firebaseUser: firebaseUser,
            ),
        ProfileScreen.routeName: (ctx) => ProfileScreen(
              email: email,
              username: username,
            ),
        NoAccess.routeName: (ctx) => NoAccess(
              username: username,
            ),
      },
    );
  }
}
