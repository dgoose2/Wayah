import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geocoding/geocoding.dart' as Geo;
import 'package:string_validator/string_validator.dart';
import 'package:wayah_app/widgets/preference_widget.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:intl/intl.dart';

class InnerOpenPanel extends StatefulWidget {
  PanelController panelController;

  InnerOpenPanel({required this.panelController});

  @override
  State<InnerOpenPanel> createState() => _InnerOpenPanelState();
}

class _InnerOpenPanelState extends State<InnerOpenPanel> {
  bool selected = false;
  Color selectedColor = Color.fromARGB(255, 141, 141, 218);
  double? latitude;
  double? longitude;
  double? desitnationLatitude;
  double? destinationLongitude;
  String? city;
  String? state;
  var _destination = TextEditingController();
  var _avgDistance = TextEditingController();
  final panelController = PanelController();
  final _formKey = GlobalKey<FormState>();

  List selectedPrefs = [];
  List<Item> listOfModel = [];

  @override
  initState() {
    listOfModel.add(Item(pref: 'Restaurant'));
    listOfModel.add(Item(pref: 'Park'));
    listOfModel.add(Item(pref: 'Restop'));
    listOfModel.add(Item(pref: 'Gas Station'));
    listOfModel.add(Item(pref: 'Grocery Store'));
    listOfModel.add(Item(pref: 'Fast Food'));
    listOfModel.add(Item(pref: 'Museum'));
  }

  addPref(String pref) {
    if (selectedPrefs.contains(pref)) {
      selectedPrefs.remove(pref);
    } else {
      selectedPrefs.add(pref);
    }
  }

  _testLocation() async {
    try {
      var location = await Location().getLocation();
      latitude = location.latitude;
      longitude = location.longitude;
      var placemarks =
          await Geo.placemarkFromCoordinates(latitude!, longitude!);
      state = placemarks[0].administrativeArea;
      city = placemarks[0].locality;
      print(city);
    } catch (e) {
      print(e);
    }
  }

  togglePreference() {
    setState(() {
      selected = !selected;
    });
  }

  _pushData() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    final isValid = _formKey.currentState!.validate();

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    List<Geo.Location> locations =
        await Geo.locationFromAddress(_destination.text);

    desitnationLatitude = locations[0].latitude;
    destinationLongitude = locations[0].longitude;

    await _testLocation();

    try {
      if (isValid) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser!.uid)
            .collection('trips')
            .add(
          {
            'trips': {
              'destination': _destination.text,
              'destinationLat': desitnationLatitude,
              'destinationLong': destinationLongitude,
              'avgDistance': int.parse(_avgDistance.text),
              'preferences': selectedPrefs,
              'currentDate': formattedDate,
              'currentLocation': '${city}, ${state}',
              'currentLocationLat': latitude,
              'currentLocationLong': longitude,
            },
          },
        );
        _destination.clear();
        _avgDistance.clear();
        for (Item item in listOfModel) {
          for (String pref in selectedPrefs) {
            if (item.pref == pref) {
              setState(() {
                item.isSelected = !item.isSelected;
              });
            }
          }
        }
        widget.panelController.close();
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Transform.rotate(
              angle: 4.68,
              child: Icon(
                Icons.arrow_back_ios,
                color: Color.fromARGB(255, 141, 141, 218),
                size: 23,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Trip Info',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 20),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Destination",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color.fromARGB(255, 99, 96, 118),
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: _destination,
                // ignore: prefer_const_constructors
                key: ValueKey('destination'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Must enter';
                  }
                  return null;
                },
                style: TextStyle(color: Color.fromARGB(255, 141, 141, 218)),
                // ignore: prefer_const_constructors
                // onChanged: (newValue) {
                //   _destination = newValue;
                // },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15, bottom: 35),
                  hintText: 'Mexico Border',
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(104, 110, 137, 100),
                      width: 1.75,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(104, 110, 137, 100),
                      width: 1.75,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(104, 110, 137, 100),
                      width: 1.75,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(104, 110, 137, 100),
                      width: 1.75,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ]),
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40, top: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Avg. Distance Per Stop",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color.fromARGB(255, 99, 96, 118),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _avgDistance,
                      // ignore: prefer_const_constructors
                      key: ValueKey('distance'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Must Enter';
                        }
                        return null;
                      },
                      style:
                          TextStyle(color: Color.fromARGB(255, 141, 141, 218)),
                      // ignore: prefer_const_constructors
                      // onChanged: (newValue) {
                      //   _avgDistance = newValue;
                      // },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15, bottom: 35),
                        hintText: '50 mi.',
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(104, 110, 137, 100),
                            width: 1.75,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(104, 110, 137, 100),
                            width: 1.75,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(104, 110, 137, 100),
                            width: 1.75,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(104, 110, 137, 100),
                            width: 1.75,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 45),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(
                            "Stop Preferences",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Color.fromARGB(255, 99, 96, 118),
                            ),
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: 100,
                          ),
                          itemBuilder: (BuildContext context, index) {
                            return Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: [
                                for (int i = 0; i < listOfModel.length; i++)
                                  prefContainer(listOfModel[i])
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Transform.rotate(
              angle: 3.95,
              child: FloatingActionButton(
                heroTag: "btn2",
                elevation: 0,
                backgroundColor: Color.fromARGB(255, 141, 141, 218),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                onPressed: () {
                  // togglePanel();
                  _pushData();
                },
                child: Transform.rotate(
                  angle: 3.9,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white, width: 3)),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget prefContainer(Item item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          item.isSelected = !item.isSelected;
        });
        addPref(item.pref);
      },
      child: Container(
        decoration: BoxDecoration(
            color: item.isSelected
                ? Color.fromARGB(255, 141, 141, 218)
                : Color.fromARGB(255, 104, 110, 137),
            borderRadius: BorderRadius.circular(7)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 7),
          child: Text(
            item.pref,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
    );
  }
}

class Item {
  String pref;
  bool isSelected;

  Item({
    required this.pref,
    this.isSelected = false,
  });
}
