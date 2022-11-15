import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wayah_app/screens/signup_screen.dart';
import 'package:wayah_app/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userPassword = '';

  void _submitSignInForm(String email, String password) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    try {
      if (isValid) {
        UserCredential authResult;
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.only(top: 15)),
              Spacer(),
              Text(
                "Wayah",
                style: TextStyle(
                  fontSize: 62,
                  color: Color.fromARGB(255, 141, 141, 218),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .8,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color.fromARGB(255, 84, 92, 122),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      // ignore: prefer_const_constructors
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      // ignore: prefer_const_constructors
                      onChanged: (newValue) {
                        _userEmail = newValue;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15, bottom: 35),
                        hintText: 'Email address',
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
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * .8,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
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
                      onChanged: (newValue) {
                        _userPassword = newValue;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15, bottom: 35),
                        hintText: 'Password',
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 84, 92, 122),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 141, 141, 218),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    _submitSignInForm(_userEmail, _userPassword);
                  },
                  // ignore: prefer_const_constructors
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SignUpScreen.routeName);
                        },
                        // ignore: prefer_const_constructors
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 214, 123),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
