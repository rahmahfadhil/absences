import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Login.dart';


void main() {

  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,

            body: Login(),
        ),
  ));
}
