// ignore_for_file: file_names, unused_local_variable, avoid_print, unnecessary_overrides

import 'dart:convert';
import 'dart:developer';

import 'package:gonaira_app/controllers/DBServer.dart';
import 'package:gonaira_app/models/Survey.dart';
import 'package:gonaira_app/models/SurveyQuestion.dart';
import 'package:gonaira_app/models/User.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SurveyController extends GetxController {
  var totalEarnings = (0.0).obs;
  var possibleEarnings = (0.0).obs;
  var userId = "".obs;
  var responses =
      <SurveyQuestion>[].obs; //Holds the User Responses to a Survey.
  var surveys = <Survey>[].obs; //Holds all Surveys
  var currentSurvey = Survey().obs;

  var questions = <SurveyQuestion>[].obs;
  var questionIndex = 0.obs;

  var selectedAnswer = "".obs;

  var completedSurveys = <Survey>[].obs;

  var users = <User>[].obs;
  var currentUser = User().obs;

  bool get kycCompleted => userSetting.read('kycCompleted') ?? false;
  bool get userIsLoggedIn => userSetting.read('loggedIn') ?? false;
  String get userID => userSetting.read('userId') ?? "";
  String get appToken => userSetting.read('userToken') ?? "";

  void setKycStatus(bool value) => userSetting.write('kycCompleted', value);
  void setIsLoggedIn(bool value) => userSetting.write('loggedIn', value);
  void setUserId(String value) => userSetting.write('userId', value);
  void setRegToken(String token) => userSetting.write('userToken', token);
  void setUserData(String data) => userSetting.write("", "");

  GetStorage surveyStore = GetStorage('SURVEY_BOX');
  GetStorage userSetting = GetStorage('USER_SETTING');

  @override
  void onInit() async {
    super.onInit();
/** This code gets all Users from Server */
    users = (await Server.getAllUsers()).obs;
    log(users.length.toString());
//

/** This code counts the current number of survey respondents for each survey*/
    var allSurveys = await Server.getSurveys();
    for (var surv in allSurveys) {
      var numResp = await Server.countRespondents(surv.id!.toString());
      await userSetting.write(surv.id!.toString(), numResp);

      ///Saves it in Local storage
    }

/**/

    currentSurvey.value = Survey();

//Stored Completed Surveys in GetStorage
    // var completed = await surveyStore.read('completed');
    var kycData = await userSetting.read('kycdone');

    //userId.value = userID; //Uncomment later
    userId.value = appToken;

    print("Storage has data?: ${surveyStore.hasData('completed')}");

    // print("Stored Data = $completed");

    // if (completed != null) {
    //   List jsonData = json.decode(completed);

    //   completedSurveys =
    //       jsonData.map((item) => Survey.fromJson(item)).toList().obs;

    //   print("CompletedSURVEYS in storage >> ${completedSurveys.length}");
    // }

//Check if User has done the KYC
    if (kycCompleted == false) {
      var survs = await Server.getSurveys();
      for (var survey in survs) {
        if (survey.title == 'KYC') {
          currentSurvey.value = survey;
        }
      }
    }

    // ever(completedSurveys,
    //     (_) => surveyStore.write('completed', completedSurveys.toList()));
  }
}
