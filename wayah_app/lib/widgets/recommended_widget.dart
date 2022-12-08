import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReccomendedPlace extends StatelessWidget {
  String name;
  String imageUrl;
  ReccomendedPlace({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 170,
          width: 140,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 0.5)],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(imageUrl),
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.darken),
              ),
              // border: Border.all(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(10)),
          // child: ClipRRect(
          //   borderRadius: BorderRadius.circular(10),
          //   child: Image.network(
          //     imageUrl,
          //     fit: BoxFit.cover,
          //   ),
          // ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6, left: 3),
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        )
      ],
    );
  }
}
