import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wayah_app/screens/profile_screen.dart';
import 'package:wayah_app/widgets/trips_widget.dart';
import '../provider/user_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatelessWidget {
  String? username;
  final panelController = PanelController();

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        username = ds.data()!['username'].toString();
        // print(email);
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var user = FirebaseAuth.instance.currentUser!;
    _fetch();

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   toolbarHeight: 35,
      //   actions: [
      //     // Image.asset('assets/images/profile_icon.png'),
      //   ],
      // ),
      body: SlidingUpPanel(
        controller: panelController,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        color: Color.fromARGB(255, 141, 141, 218),
        minHeight: MediaQuery.of(context).size.height * 0.08,
        maxHeight: MediaQuery.of(context).size.height * 0.9,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 70),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome,',
                        style: TextStyle(
                          color: Color.fromARGB(255, 30, 30, 30),
                          fontWeight: FontWeight.bold,
                          fontSize: 52,
                        ),
                      ),
                      FutureBuilder(
                        future: _fetch(),
                        builder: (context, snapshot) {
                          return Text(
                            '$username',
                            style: TextStyle(
                                color: Color.fromARGB(255, 141, 141, 218),
                                fontWeight: FontWeight.bold,
                                fontSize: 52,
                                height: 1),
                          );
                        },
                      ),
                    ],
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.20,
                          top: 10),
                      child: Container(
                        width: 45,
                        child:
                            Image(image: AssetImage('assets/images/test.png')),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text('LOGOUT'),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ),
          ],
        ),
        panelBuilder: (controller) => PanelWidget(
          panelController: panelController,
          controller: controller,
        ),
      ),
    );
  }
}
