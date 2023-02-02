// ignore_for_file: unused_local_variable

import 'package:gonaira_app/others/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gonaira_app/screens/FlashScreen1.dart';
import 'package:gonaira_app/screens/dashboard.dart';
import 'package:gonaira_app/screens/signup_screen.dart';
import 'controllers/SurveyController.dart';
import 'controllers/transactionController.dart';

void main() async {
  await GetStorage.init('TRANX_BOX');
  await GetStorage.init('SURVEY_BOX');
  await GetStorage.init('USER_SETTING');
  TransactionController trxController = Get.put(TransactionController());
  SurveyController surveyController = Get.put(SurveyController());
  //
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Font1',
      ),
      home: FlashScreen1(),
      // home: surveyController.appToken.isNotEmpty &&
      //         trxController.walletAlias.isNotEmpty
      //     ? Dashboard()
      //     : SignupScreen(),
      // home: WalletScreen(),
      onInit: () async {
        await GetStorage.init('TRANX_BOX');
        await GetStorage.init('SURVEY_BOX');
        await GetStorage.init('USER_SETTING');
        AppConstants().loadSurveys();
      }));
}
