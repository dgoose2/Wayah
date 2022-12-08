import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:map_launcher/map_launcher.dart';

class StopWidget extends StatelessWidget {
  String stopName;
  double lat;
  double long;

  StopWidget(
      {super.key,
      required this.stopName,
      required this.lat,
      required this.long});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 1,
            color: Color.fromARGB(255, 2, 0, 39),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Row(children: [
          Icon(
            Icons.directions_railway_outlined,
            size: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              stopName,
              style: TextStyle(
                  color: Color.fromARGB(255, 2, 0, 39),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () async {
              await MapLauncher.showMarker(
                  mapType: MapType.apple,
                  coords: Coords(lat, long),
                  title: stopName);
            },
            child: Icon(
              Icons.near_me_outlined,
              size: 20,
            ),
          )
        ]),
      ),
    );
  }
}
