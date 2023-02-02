// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:gonaira_app/screens/IntroScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:developer';

import '../controllers/DBServer.dart';
import '../controllers/SurveyController.dart';
import '../models/Survey.dart';
import '../others/AppConstants.dart';

class SurveyWidget extends StatelessWidget {
  SurveyController? controller;
  Survey? survey;
  String? title;
  String? reward;
  String? respondents;
  bool? forHistoryScreen;
  SurveyWidget(
      {this.controller,
      this.survey,
      this.title,
      this.reward,
      this.respondents,
      this.forHistoryScreen=false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.3,
      height: MediaQuery.of(context).size.height / 6,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          GestureDetector(
              child: Container(
                height: MediaQuery.of(context).size.height / 8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          width: 90,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppConstants.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              respondents! +
                                  " / " +
                                  survey!.population.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ),
                    Row(
                      children: [
                        Text(
                          'NGN',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                        Text(
                          reward!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_circle_right_sharp,
                            color: AppConstants.blueishGreenColor, size: 35))
                  ],
                ),
              ),
              onTap: forHistoryScreen!
                  ? null
                  : () async {
                      log("User Id: ${controller!.userId.value}");

                      /// Set the Current Survey

                      for (var surv in controller!.surveys.value) {
                        if (surv.id == survey!.id) {
                          ///
                        }
                      }
                      //Set Current Survey
                      controller!.currentSurvey.value =
                          Survey(); //Set to Null Survey

                      /// Set Question
                      var questions = controller!.questions;
                      log("SURVEY ID: ${survey!.id!.toString()}");
                      questions.value = await Server.getSurveyQuestions(
                          survey!.id!.toString());
                      controller!.questions = questions;

                      //This creates a JSON List that will hold the Questions and the User's answer
                      var myResponse = controller!.responses;
                      myResponse.value = controller!.questions.value;
                      controller!.responses = myResponse;

                      //Set question index to 0
                      controller!.questionIndex.value = 0;
                      log(GetStorage().hasData('completed').toString());

                      Get.to(() => IntroScreen(
                          survey: controller!.currentSurvey.value,
                          myQuestion: controller!.questions
                              .value[controller!.questionIndex.value]));
                    }),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppConstants.titleBackColor,
                      borderRadius: BorderRadius.circular(24)),
                  child: Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
