// ignore_for_file: file_names, prefer_const_constructors

//import 'dart:js';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/DBServer.dart';
import '../controllers/SurveyController.dart';
import '../controllers/transactionController.dart';
import '../models/Survey.dart';
import '../models/User.dart';

class AppConstants {
  static const String appName = 'Errand Boy';
  static String pageTitle = "";

//Colors
  static const Color trueBlue = Color.fromRGBO(0, 106, 224, 1);
  static const Color blueishGreenColor = Color.fromRGBO(16, 118, 145, 1);
  static const Color itemColor1 = Color.fromRGBO(160, 183, 10, 1);
  static const Color iconsColor = Color.fromRGBO(112, 128, 170, 1);
  static const Color appBarColor = Color.fromRGBO(220, 10, 50, 1);
  static const Color lightTealColor = Color.fromRGBO(35, 163, 154, 1);
  static const Color darkGreenColor = Color.fromRGBO(8, 50, 33, 1);
  static const Color greenishColor = Color.fromRGBO(30, 82, 24, 1);
  static const Color darkTealColor = Color.fromRGBO(16, 118, 145, 1);
  static const Color tealishColor = Color.fromRGBO(1, 170, 161, 1);
  static const Color titleBackColor = Color.fromARGB(255, 231, 65, 23);
  static const Color itemsColor = Color.fromRGBO(220, 220, 220, 1);
  static const Color secondaryColor = Color.fromRGBO(210, 200, 210, 1);
  static const Color mainColor = Color(0xffb74093);
  static const Color primaryColor = Color.fromARGB(255, 102, 206, 238);
  static const Color backColor = Color.fromARGB(179, 241, 239, 239);

  static const String salt = 'edima';
  TransactionController trxController = Get.find<TransactionController>();
  SurveyController surveyController = Get.find();
  String numOfRespondents = "";

  //Get Surveys
  Future<List<Survey>> getSurveys() async {
    
    surveyController.surveys.clear();
    surveyController.completedSurveys.clear();
    double totalIncome = 0;
    // String userId = surveyController.userID;
    /**Temp */

    String userId = surveyController.appToken; //SetUserId
    log("USER ID: ${surveyController.appToken}");
    surveyController.currentUser.value = User(
        id: userId,
        email: 'mjunits@yahoo.com',
        password: "6d7422b23c2f0b7fa67be6d8373cc8b9");
    //
    var survs = await Server.getSurveys(); //Load Surveys from Server
    for (var surv in survs) {
      bool didSurvey = await Server.userDidSurvey(surv.id!.toString(), userId);
      if (!didSurvey) {
        var resp = await getRespondents(surv.id!);
        surv.respondents = resp;
        surveyController.surveys.add(
            surv); //If User has not done the survey, then add it to the list
      } else {
        var resp = await getRespondents(surv.id!);
        surv.respondents = resp;
        surveyController.completedSurveys.add(surv);
        totalIncome += surv.reward;
        surveyController.totalEarnings.value = totalIncome;
      }
      trxController.isFetching.value = false;
    }

    //Compute Total,
    double total = 0;
    for (var survey in surveyController.surveys) {
      total += survey.reward!;
    }
    surveyController.possibleEarnings.value = total;

    return survs;
  }

  //
  Future<String> getRespondents(String surveyId) async {
    numOfRespondents = await Server.countRespondents(surveyId);
    return numOfRespondents;
  }

  loadSurveys() async {
    await getSurveys();
  }
}
