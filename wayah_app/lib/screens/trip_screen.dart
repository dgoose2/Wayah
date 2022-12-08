import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wayah_app/widgets/stop_widget.dart';

import '../arguments/tripData.dart';
import 'package:map_launcher/map_launcher.dart';

class TripScreen extends StatelessWidget {
  static const routeName = '/trip-screen';

  var firebaseUser;
  TripScreen({super.key, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    var tripData = ModalRoute.of(context)!.settings.arguments as TripData;

    var stopInfo = tripData.tripInformation['navigation'];

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

    // _getDirections() async {
    //   final availableMaps = await MapLauncher.installedMaps;
    //   print(availableMaps);

    //   await MapLauncher.showMarker(
    //       mapType: MapType.apple,
    //       coords: Coords(37.759392, -122.5107336),
    //       title: "Ocean Beach");
    //   // description: description,
    // }

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
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
                              tripData.tripInformation['trips']
                                      ['currentLocation']
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 14, top: 5, bottom: 10),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeBottom: true,
                        removeTop: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: tripData
                              .tripInformation['navigation']['stops'].length,
                          itemBuilder: (context, index) => StopWidget(
                            stopName: tripData.tripInformation['navigation']
                                    ['stops'][index]['name']
                                .toString(),
                            lat: tripData.tripInformation['navigation']['stops']
                                [index]['lat'],
                            long: tripData.tripInformation['navigation']
                                ['stops'][index]['long'],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
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
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              await MapLauncher.showMarker(
                                  mapType: MapType.apple,
                                  coords: Coords(
                                      stopInfo['endDestination']['lat'],
                                      stopInfo['endDestination']['long']),
                                  title: tripData.tripInformation['trips']
                                      ['destination']);
                            },
                            child: Icon(
                              Icons.near_me_outlined,
                              size: 20,
                            ),
                          )
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
                                child: Text(stopInfo['time'],
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
                                    stopInfo['stops'].length.toString(),
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
                padding: const EdgeInsets.only(bottom: 40, left: 10),
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
                      'Complete Trip',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () async {
                      _deleteItem();
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
