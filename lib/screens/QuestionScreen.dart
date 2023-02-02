// ignore_for_file: file_names, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, invalid_use_of_protected_member, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:gonaira_app/Controllers/DBServer.dart';
import 'package:gonaira_app/controllers/SurveyController.dart';
import 'package:gonaira_app/models/Survey.dart';
import 'package:gonaira_app/models/SurveyQuestion.dart';
import 'package:gonaira_app/others/AppButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gonaira_app/screens/dashboard.dart';

import '../others/AppConstants.dart';
import 'IntroScreen.dart';

class QuestionScreen extends StatelessWidget {
  SurveyController surveyController = Get.find<SurveyController>();
  late SurveyQuestion myQuestion;
  TextEditingController optionController = TextEditingController();

  QuestionScreen(SurveyQuestion question) {
    myQuestion = question;
  }

  void closeSurvey() async {
    print("User Id: ${surveyController.userId.value}");
    for (var survs in surveyController.surveys.value) {
      if (survs.id == surveyController.currentSurvey.value.id) {
        var indx = surveyController.surveys.value.indexOf(survs);
        //Set completed to YES
        surveyController.surveys.value[indx].completed = 'Yes';

        for (var response in surveyController.responses.value) {
          if (response.title == 'KYC') {
            //Do nothing
          } else {
            await Server.sendResponse(surveyController.currentUser.value.id!,
                response); //send response
          }
        }

        //Add to list of completed surveys
        surveyController.completedSurveys.value.addIf(
            !surveyController.completedSurveys.value.contains(survs), survs);

        log("HERE:>> ${surveyController.completedSurveys.length}");
        break;
      }
    }

    //Check if the Just-completed Survey was the KYC questionnaire
    if (surveyController.currentSurvey.value.title == 'KYC') {
      surveyController.setKycStatus(true); //KYC is completed
    }

    var completedAsMap = surveyController.completedSurveys.value
        .map((survey) => survey.toJson())
        .toList();

    String jsonStr = jsonEncode(completedAsMap);
    log("JSTRING: " + jsonStr);
    await surveyController.surveyStore.write('completed', jsonStr);

    print(GetStorage().hasData('completed'));

    //Set questionIndex to 0
    surveyController.questionIndex.value = 0;

    ///set Selected answer to ''
    surveyController.selectedAnswer.value = '';

    ///Set Current Survey to Default
    surveyController.currentSurvey.value = Survey();
    //

    ///Go to HomeScreen
    // Get.off(() => HomeScreen());
    AppConstants().loadSurveys();
    Get.off(() => Dashboard());
    // Get.off(()=>IntroScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Obx(() {
        Widget displayedWidget = Container();
        surveyController.currentSurvey.value.completed != 'Yes' &&
                surveyController.questionIndex.value <
                    surveyController.questions.value.length
            ? displayedWidget = ListView(
                children: [
                  Text(
                      "${surveyController.questionIndex.value + 1}/${surveyController.questions.value.length}"),
                  ListTile(
                    title: Text(
                      surveyController
                          .questions[surveyController.questionIndex.value]
                          .question!,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: surveyController
                        .questions[surveyController.questionIndex.value]
                        .options!
                        .map((option) => Obx(
                              () => RadioListTile<String>(
                                  // dense:true,
                                  title: option != 'Other'
                                      ? Text(
                                          option) //If options is 'Other' allow user to input response
                                      : TextField(
                                          onTap: () {
                                            surveyController
                                                .selectedAnswer.value = option!;
                                          },
                                          controller: optionController,
                                          decoration: InputDecoration(
                                            hintText: option,
                                          ),
                                        ),
                                  value: option,
                                  groupValue:
                                      surveyController.selectedAnswer.value,
                                  onChanged: (String? value) {
                                    var resp = surveyController.selectedAnswer;
                                    //print(value);
                                    //If User Selects 'Other' Dont Set the Selected answer
                                    if (value == 'Other') {
                                      surveyController.selectedAnswer.value =
                                          value!;
                                    } else {
                                      resp.value = value!;
                                      //Add 'answer' key and value to responses JSON object
                                      surveyController
                                          .responses[surveyController
                                              .questionIndex.value]
                                          .response = resp.value;

                                      //Set Selected Answer
                                      surveyController.selectedAnswer = resp;
                                    }

                                    //
                                  }),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (surveyController.questionIndex.value > 0) {
                              surveyController.questionIndex.value -=
                                  1; //Decrease
                            }

                            Get.off(() => IntroScreen(
                                survey: surveyController.currentSurvey.value,
                                myQuestion: surveyController.questions.value[
                                    surveyController.questionIndex.value]));
                          },
                          child: Text('Previous')),
                      ElevatedButton(
                          onPressed: () {
                            //print(
                            // "Current Index -> ${surveyController.questionIndex.value}");
                            if (surveyController
                                .selectedAnswer.value.isNotEmpty) {
                              //Check if survey questions is exhausted
                              if (surveyController.questionIndex.value <
                                      surveyController.questions.length &&
                                  surveyController.questionIndex.value !=
                                      surveyController.questions.length) {
                                ///If User Selected Other as Option
                                if (surveyController.selectedAnswer.value ==
                                    'Other') {
                                  surveyController.selectedAnswer.value =
                                      optionController.text;
                                  //Add 'answer' key and value to responses JSON object
                                  surveyController
                                          .responses[surveyController
                                              .questionIndex.value]
                                          .response =
                                      surveyController.selectedAnswer.value;
                                }

                                ///Increment questionIndex
                                surveyController.questionIndex.value += 1;

                                ///

                                ///set Selected answer to ''
                                surveyController.selectedAnswer.value = '';

                                Get.off(() => IntroScreen(
                                    survey:
                                        surveyController.currentSurvey.value,
                                    myQuestion: surveyController
                                            .questions.value[
                                        surveyController.questionIndex.value]));
                              } else {
                                ///Set Status to COMPLETED
                                surveyController.currentSurvey.value.completed =
                                    'Yes';
                                // surveyController.completedSurveys.value
                                //     .add(surveyController.currentSurvey.value);
                              }
                            } else {
                              Get.snackbar(
                                '',
                                "",
                                messageText: Text(
                                  'Select an option to proceed',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                titleText: Container(),
                                duration: Duration(seconds: 2),
                                animationDuration: Duration(seconds: 1),
                                backgroundColor: Colors.black,
                                colorText: Colors.white,
                                overlayColor: Colors.white,
                                snackStyle: SnackStyle.GROUNDED,
                                snackPosition: SnackPosition.TOP,
                                isDismissible: true,
                                dismissDirection: DismissDirection.endToStart,
                              );
                            }
                          },
                          child: Text('Next')),
                    ],
                  )
                ],
              )
            : displayedWidget = Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Survey Completed'),
                        SizedBox(height: 40.0),
                        AppButton('Home', closeSurvey),
                      ],
                    ),
                  ),
                ),
              );
        return displayedWidget;
      }),
    );
    //);
  }
}
