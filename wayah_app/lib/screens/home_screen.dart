import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:wayah_app/screens/profile_screen.dart';
import 'package:wayah_app/widgets/collapsed_panel.dart';
import 'package:wayah_app/widgets/inner_open_panel.dart';
import 'package:wayah_app/widgets/open_panel.dart';
import 'package:wayah_app/widgets/recommended_widget.dart';
import 'package:wayah_app/widgets/trips_widget.dart';
import '../provider/user_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:weather/weather.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as Geo;

class HomeScreen extends StatelessWidget {
  String? username;
  String? weatherFeelsLike;
  String? city;
  String? state;
  String? userId;
  var firebaseUser;
  var totalTrips;
  double totalDistance = 0;

  HomeScreen({required this.firebaseUser});

  String? destinationName;
  String? avgDistance;
  List? preferences;

  IconData? weatherIcon;

  double? latitude;
  double? longitude;

  var reccomendedPlaces = [
    {
      'name': 'Mexico',
      'image':
          'https://media-cldnry.s-nbcnews.com/image/upload/rockcms/2022-06/220615-us-border-bo-1758-571db8.jpg'
    },
    {
      'name': 'Canada',
      'image':
          'https://www.kids-world-travel-guide.com/images/xcanada_emeraldlake-2.jpg.pagespeed.ic.2CGE2bXMIA.jpg'
    },
    {
      'name': 'Idaho',
      'image':
          'https://cdn1.matadornetwork.com/blogs/1/2019/10/shoshone-falls-niagara-west-snake-river-idaho.jpg'
    },
  ];

  final panelController = PanelController();
  final secondPanelController = PanelController();

  WeatherFactory wf = new WeatherFactory("e9907feb7be894efad91b9af279ede9c");

  _fetch() async {
    firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then(
        (ds) {
          userId = firebaseUser.uid.toString();
          username = ds.data()!['username'].toString();
        },
      ).catchError((e) {
        print(e);
      });
    }
  }

  _getTrips() async {
    firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      var trips = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .collection('trips')
          .get();

      totalTrips = trips.size;
    }
  }

  // _getStops() async {
  //   firebaseUser = await FirebaseAuth.instance.currentUser;
  //   if (firebaseUser != null) {
  //     var trips = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(firebaseUser.uid)
  //         .collection('trips')
  //         .get();

  //     // totalDistance =
  //     var test = trips.docs.map(
  //       (e) => e.data()['trips']['prefStops'],
  //     );

  //     print(trips.docs.map(
  //       (e) => e.data()['trips']['prefStops'],
  //     ));

  //     for (int x in test) {
  //       totalDistance += x;
  //     }

  //     totalDistance /= test.length;
  //   }
  // }

  _testLocation() async {
    try {
      var location = await Location().getLocation();
      latitude = location.latitude;
      longitude = location.longitude;
      var placemarks =
          await Geo.placemarkFromCoordinates(latitude!, longitude!);
      state = placemarks[0].administrativeArea;
      city = placemarks[0].locality;
    } catch (e) {
      print(e);
    }
  }

  _testWeather() async {
    await _testLocation();
    Weather w = await wf.currentWeatherByLocation(latitude!, longitude!);
    Temperature? temp = w.tempFeelsLike;

    var desc = w.weatherDescription;

    if (desc == 'rain') {
      weatherIcon = Icons.ac_unit;
    } else if (desc == 'snow') {
      weatherIcon = Icons.cloudy_snowing;
    } else {
      weatherIcon = Icons.sunny;
    }

    var arr = temp!.fahrenheit.toString().split('.');
    weatherFeelsLike = arr[0];
  }

  @override
  initState() {
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var user = FirebaseAuth.instance.currentUser!;
    // _fetch();
    // _getDistance();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SlidingUpPanel(
        controller: panelController,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        color: Color.fromARGB(255, 141, 141, 218),
        minHeight: MediaQuery.of(context).size.height * 0.08,
        maxHeight: MediaQuery.of(context).size.height * 1,
        collapsed: CollapsedPanel(),
        panel: OpenPanel(
          firebaseUser: firebaseUser,
          collapsedPanel: CollapsedPanel(),
          innerOpenPanel: InnerOpenPanel(
              // panelController: panelController,
              ),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 20),
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
                                        color:
                                            Color.fromARGB(255, 141, 141, 218),
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
                                  left:
                                      MediaQuery.of(context).size.width * 0.20,
                                  top: 10),
                              child: Container(
                                width: 45,
                                child: Image(
                                    image:
                                        AssetImage('assets/images/test.png')),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(ProfileScreen.routeName);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 23),
                            child: Container(
                              height: 220,
                              width: 190,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 41, 45, 61),
                                      width: 1.5)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  top: 6,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.bar_chart_rounded,
                                          size: 18,
                                          color:
                                              Color.fromARGB(255, 41, 45, 61),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Statistics',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 41, 45, 61),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Total Trips: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          FutureBuilder(
                                            future: _getTrips(),
                                            builder: ((context, snapshot) {
                                              return Text(
                                                totalTrips.toString(),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: FutureBuilder(
                              future: _testWeather(),
                              builder: (context, snapshot) {
                                return Column(
                                  children: [
                                    SizedBox(height: 70),
                                    Container(
                                      height: 110,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 41, 45, 61),
                                              width: 1.5)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              top: 6,
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  weatherIcon,
                                                  size: 18,
                                                  color: Color.fromARGB(
                                                      255, 41, 45, 61),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    'Weather',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 41, 45, 61),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              top: 14,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '$weatherFeelsLike°',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 141, 141, 218),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 45,
                                                      height: 1),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6),
                                                  child: Icon(
                                                    weatherIcon,
                                                    size: 40,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                        height: 110,
                                        width: 170,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 41, 45, 61),
                                                width: 1.5)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                                top: 6,
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    size: 18,
                                                    color: Color.fromARGB(
                                                        255, 41, 45, 61),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                      'Location',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 41, 45, 61),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '$city,',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 26,
                                                      height: 1,
                                                    ),
                                                  ),
                                                  Text(
                                                    '$state',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 26,
                                                      height: 1,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 25, top: 50),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.only(bottom: 15),
                    //         child: Text(
                    //           'Popular Desntinations',
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold, fontSize: 25),
                    //         ),
                    //       ),
                    //       Container(
                    //         height: 300,
                    //         child: ListView.builder(
                    //           itemCount: reccomendedPlaces.length,
                    //           shrinkWrap: true,
                    //           scrollDirection: Axis.horizontal,
                    //           itemBuilder: (context, index) {
                    //             return Padding(
                    //               padding: const EdgeInsets.only(right: 20),
                    //               child: ReccomendedPlace(
                    //                 name: reccomendedPlaces[index]['name']
                    //                     .toString(),
                    //                 imageUrl: reccomendedPlaces[index]['image']
                    //                     .toString(),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
