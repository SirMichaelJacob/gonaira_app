// ignore_for_file: must_be_immutable,prefer_const_constructors

import 'package:gonaira_app/screens/loadingWidget.dart';
import 'package:gonaira_app/screens/mainWidget.dart';
import 'package:gonaira_app/screens/mid_widget.dart';
import 'package:gonaira_app/screens/top_screen.dart';
import 'package:gonaira_app/screens/top_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/SurveyController.dart';
import '../controllers/transactionController.dart';
import '../others/AppConstants.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  TransactionController trxController = Get.find<TransactionController>();
  SurveyController surveyController = Get.find();
  String numOfRespondents = "";

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        AppConstants().getSurveys();
      },
      color: AppConstants.titleBackColor,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      child: Scaffold(
        backgroundColor: Color.fromARGB(179, 241, 239, 239),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Color.fromARGB(179, 241, 239, 239)),
          child: Obx(
            () => surveyController.currentUser.value != null &&
                    trxController.walletAlias != null
                ? Column(children: [
                    Stack(
                      children: [
                        Obx(() => surveyController.surveys.isNotEmpty
                            ? TopScreen(
                                trxcontroller: trxController,
                                surveyController: surveyController,
                                showInfo: true,
                              )
                            : SizedBox()),
                        Obx(
                          () => surveyController.surveys.isNotEmpty
                              ? MidWidget(
                                  trxcontroller: trxController,
                                  surveyController: surveyController,
                                  callback: AppConstants().loadSurveys,
                                )
                              : Center(
                                  child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.5,
                                    ),
                                    LoadingWidget(message: "Loading Data"),
                                  ],
                                )),
                        ),
                      ],
                    ),
                    Obx(() => surveyController.surveys.isNotEmpty
                        ? Expanded(
                            child: MainWidget(
                              mySurveys: surveyController.surveys,
                              isHistoryPage: false,
                            ),
                          )
                        : Container()),
                  ])
                : LoadingWidget(),
          ),
        ),
      ),
    );
  }
}
