import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wayah_app/screens/no_access.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';
  String email;
  String username;

  ProfileScreen({required this.email, required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        iconTheme: IconThemeData(color: Colors.black, size: 30),
        elevation: 0,
        title: Text(
          username,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              child: Container(
                height: 39,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    border: Border.all(
                        color: Color.fromARGB(255, 206, 201, 197), width: 2)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(children: [
                    Text(
                      'Username',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        username,
                        style: TextStyle(
                            color: Color.fromARGB(255, 99, 96, 118),
                            fontSize: 15),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Color.fromARGB(255, 206, 201, 197),
                    ),
                    Padding(padding: EdgeInsets.only(right: 20))
                  ]),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(NoAccess.routeName);
              },
            ),
            InkWell(
              child: Container(
                height: 39,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Color.fromARGB(255, 206, 201, 197), width: 2)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(children: [
                    Text(
                      'Email',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        email,
                        style: TextStyle(
                            color: Color.fromARGB(255, 99, 96, 118),
                            fontSize: 15),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Color.fromARGB(255, 206, 201, 197),
                    ),
                    Padding(padding: EdgeInsets.only(right: 20))
                  ]),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(NoAccess.routeName);
              },
            ),
            InkWell(
              child: Container(
                height: 39,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Color.fromARGB(255, 206, 201, 197), width: 2)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(children: [
                    Text(
                      'Notifications',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Color.fromARGB(255, 206, 201, 197),
                    ),
                    Padding(padding: EdgeInsets.only(right: 20))
                  ]),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(NoAccess.routeName);
              },
            ),
            InkWell(
              child: Container(
                height: 39,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Color.fromARGB(255, 206, 201, 197), width: 2)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(children: [
                    Text(
                      'App Appearance',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Color.fromARGB(255, 206, 201, 197),
                    ),
                    Padding(padding: EdgeInsets.only(right: 20))
                  ]),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(NoAccess.routeName);
              },
            ),
            InkWell(
              child: Container(
                height: 39,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Colors.white,
                    border: Border.all(
                        color: Color.fromARGB(255, 206, 201, 197), width: 2)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(children: [
                    Text(
                      'Logout',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Color.fromARGB(255, 206, 201, 197),
                    ),
                    Padding(padding: EdgeInsets.only(right: 20))
                  ]),
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
