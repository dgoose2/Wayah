import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InnerOpenPanel extends StatelessWidget {
  void togglePanel() {
    print('toggle');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
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
              // ignore: prefer_const_constructors
              key: ValueKey('password'),
              validator: (value) {
                if (value!.isEmpty || value.length < 7) {
                  return 'Password must be at least 7 characters';
                }
                return null;
              },
              style: TextStyle(color: Theme.of(context).primaryColor),
              // ignore: prefer_const_constructors
              obscureText: true,
              onChanged: (newValue) {},
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
        Padding(
          padding: EdgeInsets.only(left: 40, right: 40, top: 15),
          child: Column(children: [
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
              // ignore: prefer_const_constructors
              key: ValueKey('password'),
              validator: (value) {
                if (value!.isEmpty || value.length < 7) {
                  return 'Password must be at least 7 characters';
                }
                return null;
              },
              style: TextStyle(color: Theme.of(context).primaryColor),
              // ignore: prefer_const_constructors
              obscureText: true,
              onChanged: (newValue) {},
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
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5, top: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Stop Preferences",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color.fromARGB(255, 99, 96, 118),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Transform.rotate(
                angle: 3.95,
                child: FloatingActionButton(
                  heroTag: "btn1",
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 141, 141, 218),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                  onPressed: () {
                    togglePanel();
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
          ]),
        ),
      ],
    );
    ;
  }
}
