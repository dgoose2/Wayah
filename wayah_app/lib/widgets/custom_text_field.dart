import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextField extends StatefulWidget {
  String value;
  String title;
  String formValue;
  String hintText;
  Function errorValidation;

  CustomTextField({
    super.key,
    required this.value,
    required this.title,
    required this.formValue,
    required this.errorValidation,
    required this.hintText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.title),
            ),
          ),
          TextFormField(
            // ignore: prefer_const_constructors
            key: ValueKey(widget.formValue),
            validator: widget.errorValidation(),
            keyboardType: TextInputType.emailAddress,
            // ignore: prefer_const_constructors
            onChanged: (newValue) {
              widget.value = newValue;
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
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
    );
  }
}
