import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TripWidget extends StatelessWidget {
  String destinationName;
  // String fromLocation;
  // String time;
  // String stops;
  // String date;

  TripWidget({
    super.key,
    required this.destinationName,
    // required this.fromLocation,
    // required this.time,
    // required this.stops,
    // required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(55, 0, 0, 0),
            offset: Offset(0.0, 4.0), //(x,y)
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Color.fromARGB(255, 255, 214, 123),
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destinationName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'From Orgin',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33, top: 10, bottom: 5),
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 14,
                        color: Color.fromARGB(255, 18, 19, 26),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          'test',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.route_outlined,
                          size: 14,
                          color: Color.fromARGB(255, 18, 19, 26),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            'test',
                            style: TextStyle(fontSize: 12),
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
                          size: 14,
                          color: Color.fromARGB(255, 18, 19, 26),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            'test',
                            style: TextStyle(fontSize: 12),
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
    );
  }
}
