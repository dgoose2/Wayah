import 'package:flutter/material.dart';
import 'inner_open_panel.dart';

class PreferenceWidget extends StatefulWidget {
  String preference;

  PreferenceWidget({super.key, required this.preference});

  @override
  State<PreferenceWidget> createState() => _PreferenceWidgetState();
}

class _PreferenceWidgetState extends State<PreferenceWidget> {
  bool selected = false;

  Color selectedColor = Color.fromARGB(255, 141, 141, 218);

  togglePreference() {
    setState(() {
      selected = !selected;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        togglePreference();

        // print(widget.preference);
      },
      child: Container(
        decoration: BoxDecoration(
            color: selected
                ? Color.fromARGB(255, 141, 141, 218)
                : Color.fromARGB(255, 104, 110, 137),
            borderRadius: BorderRadius.circular(7)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 7),
          child: Text(
            widget.preference,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
