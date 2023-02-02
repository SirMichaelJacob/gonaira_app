// ignore_for_file: non_constant_identifier_names, prefer_const_constructors,file_names, sort_child_properties_last

import 'package:flutter/material.dart';

Widget AppButton(String btnText, btnFunction) {
  return Container(
    child: TextButton(
      child: Text(
        btnText,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        btnFunction();
      },
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      // ignore: prefer_const_literals_to_create_immutables
      gradient: LinearGradient(colors: [
        Color.fromRGBO(0, 106, 224, 1),
        Color(0xffb74093),
        Color.fromRGBO(220, 10, 50, 1)
      ]),
    ),
  );
}
