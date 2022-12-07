import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../arguments/tripData.dart';

class TripScreen extends StatelessWidget {
  static const routeName = '/trip-screen';
  const TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var tripData = ModalRoute.of(context)!.settings.arguments as TripData;

    _deleteItem() async {
      final firebaseUser = await FirebaseAuth.instance.currentUser;

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser!.uid)
            .collection('trips')
            .doc(tripData.tripId)
            .delete();

        Navigator.of(context).pop();
      } catch (error) {
        print(error);
      }
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black, size: 30),
          toolbarHeight: 40,
          centerTitle: false,
          actions: [
            InkWell(
              onTap: () {
                _deleteItem();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.delete_outlined,
                  color: Color.fromARGB(255, 18, 19, 26),
                  size: 30,
                ),
              ),
            ),
          ],
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 23,
                    color: Color.fromARGB(255, 41, 45, 61),
                  ),
                  Text(
                    'BACK',
                    style: TextStyle(
                      color: Color.fromARGB(255, 41, 45, 61),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          leadingWidth: 120,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trip Schedule',
                style: TextStyle(
                    color: Color.fromARGB(255, 41, 45, 61),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Color.fromARGB(255, 141, 141, 218),
                          size: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            tripData.tripInformation['trips']['currentLocation']
                                .toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Color.fromARGB(255, 141, 141, 218),
                            size: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              tripData.tripInformation['trips']['destination']
                                  .toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trip Statistics',
                      style: TextStyle(
                          color: Color.fromARGB(255, 41, 45, 61),
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 22,
                                color: Color.fromARGB(255, 18, 19, 26),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text('test',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 2, 0, 39),
                                    )),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.route_outlined,
                                  size: 22,
                                  color: Color.fromARGB(255, 18, 19, 26),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    'test',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 2, 0, 39),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  size: 22,
                                  color: Color.fromARGB(255, 18, 19, 26),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    tripData.tripInformation['trips']
                                            ['currentDate']
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 2, 0, 39),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 141, 141, 218),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Text(
                      'Start Trip',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      print('start');
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
