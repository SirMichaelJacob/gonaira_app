// ignore_for_file: use_key_in_widget_constructors,file_names, prefer_const_constructors,prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:gonaira_app/controllers/SurveyController.dart';
import 'package:gonaira_app/models/Survey.dart';
import 'package:gonaira_app/models/SurveyQuestion.dart';
import 'package:gonaira_app/others/AppButton.dart';
import 'package:gonaira_app/others/AppConstants.dart';
import 'package:gonaira_app/screens/QuestionScreen.dart';
import 'package:gonaira_app/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class IntroScreen extends StatelessWidget {
  SurveyController surveyController = Get.find<SurveyController>();
  SurveyQuestion? myQuestion;
  Survey? survey;

  IntroScreen({this.survey, this.myQuestion});

  void startSurvey() {
    //Set currentSurvey
    for (var surv in surveyController.surveys) {
      if (surv.id == myQuestion!.surveyId!) {
        survey = surv;
        surveyController.currentSurvey.value = surv;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    for (var surv in surveyController.surveys) {
      if (surv.id == myQuestion!.surveyId!) {
        survey = surv;
        break;
      }
    }
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(myQuestion!.title!),
        //   backgroundColor: AppConstants.mainColor,
        // ),
        body: Obx(
      () => surveyController.currentSurvey.value.id != null
          ? QuestionScreen(myQuestion!)
          : Container(
              decoration: BoxDecoration(
                color: AppConstants.backColor,
              ),
              child: ListView(children: [
                CustomAppBar(Icons.arrow_back,
                    title: 'GoNaira', leftCallback: () => Get.back()),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        survey!.title!,
                        style: TextStyle(
                            fontFamily: 'Font2',
                            color: AppConstants.darkGreenColor,
                            fontSize: 16.0),
                      ),
                      Text(
                        'Reward:',
                        style: TextStyle(
                            fontFamily: 'Font3',
                            color: AppConstants.darkGreenColor,
                            fontSize: 16.0),
                      ),
                      Text(
                        NumberFormat.simpleCurrency(name: 'NGN')
                            .format(survey!.reward!),
                        style: TextStyle(
                            fontFamily: 'Font3',
                            color: AppConstants.darkGreenColor,
                            fontSize: 16.0),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        survey!.description!,
                        style: TextStyle(
                          fontFamily: 'Font1',
                          color: AppConstants.blueishGreenColor,
                          fontSize: 14.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.0),
                      Text("Questions: ${survey!.numberOfQuestions}"),
                      SizedBox(height: 40.0),
                      AppButton('Start Survey', startSurvey)
                    ],
                  ),
                ),
              ])),
    ));
  }
}
