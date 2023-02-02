// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, file_names, use_key_in_widget_constructors

import 'package:get/get.dart';
import 'package:gonaira_app/screens/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:gonaira_app/screens/survey_widget.dart';
import '../controllers/SurveyController.dart';
import '../models/Survey.dart';

class MainWidget extends StatelessWidget {
  late List<Survey>? surveys;
  late bool? historyPage;
  SurveyController surveyController = Get.find();

  MainWidget({mySurveys: null, isHistoryPage: null}) {
    surveys = mySurveys;
    historyPage = isHistoryPage;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Obx(() => surveys!.isNotEmpty
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                  // itemExtent: surveyController.surveys.length,
                  children: surveys!
                      .map(
                        (survey) => SurveyWidget(
                          controller: surveyController,
                          survey: survey,
                          title: survey.title,
                          reward: survey.reward!.toString(),
                          respondents: survey.respondents,
                          forHistoryScreen: historyPage,
                        ),
                      )
                      .toList()),
              // child: FutureBuilder(
              //     future: AppConstants().getSurveys(),
              //     builder: (context, snapShot) {
              //       Widget result = LoadingWidget();
              //       switch (snapShot.connectionState) {
              //         case ConnectionState.none:
              //           return result;
              //         case ConnectionState.active:
              //           return result;
              //         case ConnectionState.waiting:
              //           return result;
              //         case ConnectionState.done:
              //           result = ListView(
              //     // itemExtent: surveyController.surveys.length,
              //     children:
              //       surveyController.surveys.map((survey) => SurveyWidget(
              //         controller: surveyController,
              //         survey: survey,
              //         title: survey.title,
              //         reward: survey.reward!.toString(),
              //         respondents: survey.respondents,
              //       )).toList()

              //     );

              //           return result;
              //       }
              //     }),
            )
          : LoadingWidget()),
    );
  }
}
