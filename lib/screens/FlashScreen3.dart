// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonaira_app/screens/dashboard.dart';
import 'package:gonaira_app/screens/signup_screen.dart';

import '../controllers/SurveyController.dart';
import '../controllers/transactionController.dart';

class FlashScreen3 extends StatelessWidget {
  TransactionController trxController = Get.find<TransactionController>();
  SurveyController surveyController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
          GestureDetector(
              child: Image.asset("assets/images/3.png"),
              onTap: () {
                surveyController.appToken.isNotEmpty &&
                        trxController.walletAlias.isNotEmpty
                    ? Get.off(() => Dashboard())
                    : Get.off(() => SignupScreen());
              })
      ],
    ),
        ));
  }
}
