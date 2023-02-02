// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors,prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:get/get.dart';
import 'package:gonaira_app/controllers/transactionController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/SurveyController.dart';
import '../others/AppConstants.dart';

class topWidget extends StatelessWidget {
  final TransactionController? trxcontroller;
  final SurveyController? surveyController;
  final bool? showInfo;

  topWidget({
    this.trxcontroller,
    this.surveyController,
    this.showInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: showInfo!
            ? MediaQuery.of(context).size.height / 3
            : MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          color: AppConstants.tealishColor,
        ),
        child: Column(
          children: [
            //Profile
            Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Text('GoNaira',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              letterSpacing: 1.0)),
                      Text('Real People, Real Money',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              letterSpacing: 1.0)),
                    ],
                  ),
                  showInfo!
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25.0,
                                  child: Icon(Icons.person_pin_outlined,
                                      size: 30,
                                      color: AppConstants.blueishGreenColor),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.monetization_on_rounded,
                                    color: Colors.yellow),
                                Text(
                                    NumberFormat.simpleCurrency(name: 'NGN')
                                        .format(surveyController!
                                            .totalEarnings.value),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Font3',
                                        fontSize: 28,
                                        color: Colors.white,
                                        letterSpacing: 1.0)),
                              ],
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),

            SizedBox(width: 10), //For white Space

            showInfo!
                ? Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Obx(() => surveyController!.surveys.isNotEmpty
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('eNaira available to earn:',
                                            style: TextStyle(
                                                fontFamily: 'Font3',
                                                fontSize: 10,
                                                color: Colors.white)),
                                        Row(
                                          children: [
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Obx(() => surveyController!
                                                      .surveys.isNotEmpty
                                                  ? Text(
                                                      NumberFormat
                                                              .simpleCurrency(
                                                                  name: 'NGN')
                                                          .format(surveyController!
                                                              .possibleEarnings
                                                              .value),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontFamily: 'Font3',
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          letterSpacing: 1.0),
                                                    )
                                                  : SizedBox()),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : SizedBox()),
                        ),

                        // Chip(avatar: Icon(Icons.refresh), label: Text(""))
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ));
  }
}
