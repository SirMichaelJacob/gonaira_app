// ignore_for_file: must_be_immutable,prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:gonaira_app/screens/custom_app_bar.dart';
import 'package:gonaira_app/screens/dashboard.dart';
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

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);
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
                ? Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        CustomAppBar(
                          Icons.arrow_back,
                          leftCallback: () {
                            Get.to(() => Dashboard());
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Completed Surveys',
                              style: TextStyle(
                                  color: AppConstants.darkTealColor,
                                  fontSize: 15)),
                        ),
                        Obx(
                          () => surveyController.completedSurveys.isNotEmpty
                              ? Expanded(
                                  child: MainWidget(
                                    mySurveys:
                                        surveyController.completedSurveys,
                                    isHistoryPage: true,
                                  ),
                                )
                              : Center(
                                  child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.5,
                                    ),
                                    Text('Survey History is Empty'),
                                  ],
                                )),
                        )
                      ])
                : LoadingWidget(),
          ),
        ),
      ),
    );
  }
}
