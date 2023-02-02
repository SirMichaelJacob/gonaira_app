// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable, invalid_use_of_protected_member, avoid_print, prefer_const_literals_to_create_immutables, non_constant_identifier_names
import 'package:gonaira_app/controllers/DBServer.dart';
import 'package:gonaira_app/controllers/SurveyController.dart';
//import 'package:gonaira_app/models/Survey.dart';
//import 'package:gonaira_app/others/AppButton.dart';
import 'package:gonaira_app/others/AppConstants.dart';
//import 'package:gonaira_app/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//import 'Question.dart';
import 'IntroScreen.dart';

class SurveysScreen extends StatelessWidget {
  SurveysScreen({
    required this.surveyController,
  });

  SurveyController surveyController = Get.find<SurveyController>();
  Widget initialWidget = Container();
  String numOfRespondents = '';

  Future<String> getRespondents(String surveyId) async {
    numOfRespondents = await Server.countRespondents(surveyId);
    return numOfRespondents;
  }

  Widget ShowSurvey(SurveyController surveyController) {
    /** Check if KYC has been completed */

    if (surveyController.kycCompleted) {
      //Load List of Available Surveys if User has Completed KYC
      initialWidget = Obx(() {
        List<Widget> widgets = [];
        late Widget _widget;
        Widget noSurveyWidget = Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('C-Survey App.'),
                Text('No.1 Research app in Nigeria.')
              ],
            ),
          ),
        );
        if (surveyController.surveys.value.isNotEmpty) {
          _widget = ListView(
            children: surveyController.surveys.map<Widget>((survey) {
              getRespondents(survey.id!.toString());
              bool found =
                  false; //Checks if Survey is found in the Completed Survey List
              for (var item in surveyController.completedSurveys.value) {
                if (item.id == survey.id) {
                  found = true;
                  break;
                } else {
                  found = false;
                }
              }
              if (found) {
                return Container();
              } else {
                Widget card = Card(
                  child: Card(
                    margin: EdgeInsets.all(20.0),
                    elevation: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            survey.title!,
                            style: TextStyle(
                                fontFamily: 'Font2',
                                color: AppConstants.mainColor,
                                fontSize: 16.0),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            survey.description!,
                            style: TextStyle(
                              fontFamily: 'Font1',
                              color: AppConstants.greenishColor,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40.0),
                          Text(
                            "Number of Respondents: ${surveyController.userSetting.read(survey.id!.toString())}",
                            style: TextStyle(
                              fontFamily: 'Font1',
                              color: AppConstants.greenishColor,
                              fontSize: 13.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Questions: ${survey.numberOfQuestions}"),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(0, 106, 224, 1),
                                    Color(0xffb74093),
                                    Color.fromRGBO(220, 10, 50, 1)
                                  ]),
                                ),
                                child: TextButton(
                                  onPressed: found
                                      ? null
                                      : () async {
                                          print(
                                              "User Id: ${surveyController.userId.value}");

                                          /// Set the Current Survey

                                          for (var surv in surveyController
                                              .surveys.value) {
                                            if (surv.id == survey.id) {
                                              ///
                                            }
                                          }
                                          //Set Current Survey
                                  // surveyController.currentSurvey.value = survey;

                                          /// Set Question
                                          var questions =
                                              surveyController.questions;
                                          print(
                                              "SURVEY ID: ${survey.id!.toString()}");
                                          questions.value =
                                              await Server.getSurveyQuestions(
                                                  survey.id!.toString());
                                          surveyController.questions =
                                              questions;

                                          //This creates a JSON List that will hold the Questions and the User's answer
                                          var myResponse =
                                              surveyController.responses;
                                          myResponse.value =
                                              surveyController.questions.value;
                                          surveyController.responses =
                                              myResponse;

                                          //Set question index to 0
                                          surveyController.questionIndex.value =
                                              0;
                                          print(GetStorage()
                                              .hasData('completed'));

                                          Get.off(() => IntroScreen(
                                              survey: surveyController
                                                  .currentSurvey.value,
                                              myQuestion: surveyController
                                                      .questions.value[
                                                  surveyController
                                                      .questionIndex.value]));
                                        },
                                  child: Text(
                                    'Take Survey',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                );
                widgets.add(card);
                return card;
              }
            }).toList(),
          );

          if (widgets.isEmpty) {
            //If All Surveys have been completed
            return noSurveyWidget;
          }
        } else {
          //If no new Surveys
          _widget = Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('C-Survey App.\nNo Connection'),
                  Text('No.1 Research app in Nigeria.')
                ],
              ),
            ),
          );
        }

        return _widget;
      });
    } else {
      initialWidget = Card(
        child: Card(
          margin: EdgeInsets.all(20.0),
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "Kindly Complete the KYC Questionnaire.",
                  style: TextStyle(
                      color: AppConstants.blueishGreenColor, fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  surveyController.currentSurvey.value.title!,
                  style: TextStyle(
                      fontFamily: 'Font2',
                      color: AppConstants.mainColor,
                      fontSize: 16.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  surveyController.currentSurvey.value.description!,
                  style: TextStyle(
                    fontFamily: 'Font2',
                    color: AppConstants.greenishColor,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Text(
                    "Questions: ${surveyController.currentSurvey.value.numberOfQuestions}"),
                SizedBox(height: 40.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(0, 106, 224, 1),
                      Color(0xffb74093),
                      Color.fromRGBO(220, 10, 50, 1)
                    ]),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      /// Set Question
                      var questions = surveyController.questions;

                      questions.value = await Server.getSurveyQuestions(
                          surveyController.currentSurvey.value.id!.toString());

                      surveyController.questions = questions;

                      //This creates a JSON List that will hold the Questions and the User's answer
                      var myResponse = surveyController.responses;
                      myResponse.value = surveyController.questions.value;
                      surveyController.responses = myResponse;

                      //Set question index to 0
                      surveyController.questionIndex.value = 0;

                      Get.off(() => IntroScreen(
                          survey: surveyController.currentSurvey.value,
                          myQuestion: surveyController.questions
                              .value[surveyController.questionIndex.value]));
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return initialWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppConstants.mainColor,
              AppConstants.lightTealColor,
              AppConstants.trueBlue
            ],
          ),
        ),
        child: ShowSurvey(surveyController)
        //ShowSurvey(surveyController),
        );
  }
}
