// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables,use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/SurveyController.dart';
import '../controllers/transactionController.dart';
import '../others/AppConstants.dart';

class TopScreen extends StatelessWidget {
  final TransactionController? trxcontroller;
  final SurveyController? surveyController;
  final bool? showInfo;

  TopScreen({
    this.trxcontroller,
    this.surveyController,
    this.showInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      height:
          // showInfo
          //     ?
          //     MediaQuery.of(context).size.height / 4
          MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppConstants.tealishColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment:
              !showInfo! ? MainAxisAlignment.center : MainAxisAlignment.start,
          // ignore:
          children: [
            Text('GoNaira',
                style: TextStyle(
                    fontSize: 30, color: Colors.white, letterSpacing: 1.0)),
            Text('Real People, Real Money',
                style: TextStyle(
                    fontSize: 10, color: Colors.white, letterSpacing: 1.0)),
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
                          Obx(() {
                            return Text(
                                NumberFormat.simpleCurrency(name: 'NGN').format(
                                    surveyController!.totalEarnings.value),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Font3',
                                    fontSize: 28,
                                    color: Colors.white,
                                    letterSpacing: 1.0));
                          }),
                        ],
                      ),
                      //
                    ],
                  )
                : SizedBox(),
            SizedBox(height: 20),
            showInfo!
                ? Row(
                    children: [
                      Text('eNaira available to earn:',
                          style: TextStyle(
                              fontFamily: 'Font3',
                              fontSize: 10,
                              color: Colors.white)),
                    ],
                  )
                : SizedBox(),
            showInfo!
                ? Row(
                    children: [
                      Obx(() {
                        return Text(
                          NumberFormat.simpleCurrency(name: 'NGN')
                              .format(surveyController!.possibleEarnings.value),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Font3',
                              fontSize: 20,
                              color: Colors.white,
                              letterSpacing: 1.0),
                        );
                      }),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
