// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonaira_app/screens/FlashScreen3.dart';

import '../controllers/SurveyController.dart';
import '../controllers/transactionController.dart';

class FlashScreen2 extends StatelessWidget {
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
          Dismissible(
            direction: DismissDirection.horizontal,
            key: UniqueKey(),
            onDismissed: (direction) {
              Get.off(() => FlashScreen3());
            },
            child: GestureDetector(
                child: Image.asset("assets/images/2.png"),
                onTap: () {
                  Get.off(() => FlashScreen3());
                }),
          )
      ],
    ),
        ));
  }
}
