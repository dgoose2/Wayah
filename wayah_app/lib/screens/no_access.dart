import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NoAccess extends StatelessWidget {
  static const routeName = '/no-access';

  String username;

  NoAccess({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        iconTheme: IconThemeData(color: Colors.black, size: 30),
        elevation: 0,
        // title: Text(
        //   'nooo',
        //   style: TextStyle(
        //       color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 45, right: 45),
        child: Center(
            child: Text(
          textAlign: TextAlign.center,
          "Sorry $username unfortanatley we currently do not offer this service.",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
