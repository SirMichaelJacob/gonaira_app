// // ignore_for_file: file_names, must_be_immutable, use_key_in_widget_constructors
// import 'package:gonaira_app/controllers/SurveyController.dart';
// import 'package:gonaira_app/screens/HomeScreen.dart';
// import 'package:gonaira_app/screens/LoginScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class IndexScreen extends StatelessWidget {
//   SurveyController surveyController = Get.find<SurveyController>();

//   Widget currentScreen() =>
//       surveyController.userIsLoggedIn ? HomeScreen() : LoginScreen();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body:SimpleBuilder(
//       builder: (context) => currentScreen(),
//     ));
//   }
// }
