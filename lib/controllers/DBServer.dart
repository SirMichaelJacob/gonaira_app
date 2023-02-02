// ignore_for_file: file_names, unused_local_variable, avoid_print, constant_identifier_names
import 'dart:convert';
import 'dart:developer';

import 'package:gonaira_app/models/Survey.dart';
import 'package:gonaira_app/models/SurveyQuestion.dart';
import 'package:gonaira_app/models/User.dart';
import 'package:gonaira_app/models/wResponse.dart';
import 'package:http/http.dart' as http;

class Server {
  static const ROOT = "http://www.ccpgroup.com.ng/webaction.php";
  static const ROOT2 = "http://www.ccpgroup.com.ng/secure.php";
  // static const ROOT = "http://192.168.68.1/survey_app/actions.php";
  // static const ROOT2 = "http://192.168.68.1/survey_app/secure.php";
  static const String _GET_SURVEY_QUESTIONS = "GET_SURVEY_QUESTIONS";
  static const String _GET_ALL_SURVEYS = "GET_SURVEYS";
  static const String _SEND_RESPONSE = "POST_RESPONSE";
  static const String _COUNT_RESPONSE = "COUNT_RESPONSE";
  static const String _GET_USER = "GET_USER";
  static const String _GET_ALL_USERS = "ALL_USERS";
  static const String _DID_SURVEY = "HAS_DONE_SURVEY";
  static const String _GEN_TOKEN = 'GEN_TOKEN';
  static const String _VERIFY_WALLET = 'VERIFY_WALLET';
  static const String _PAY_REWARD = 'PAY_REWARD';

  //Get All Surveys
  static Future<List<Survey>> getSurveys() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_ALL_SURVEYS;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (response.statusCode == 200) {
        //log(response.body);
        var list = <Survey>[];
        list = parseSurveys(response.body);
        return list;
      } else {
        var list = <Survey>[];
        return list;
      }
    } catch (e) {
      log("Get Surveys: $e");
      var list = <Survey>[];
      return list;
    }
  }

  //Get Survey
  static Future<List<SurveyQuestion>> getSurveyQuestions(
      String surveyId) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_SURVEY_QUESTIONS;
      map['surveyId'] = surveyId;

      final response = await http.post(Uri.parse(ROOT), body: map);
      if (response.statusCode == 200) {
        //log(response.body);
        var list = <SurveyQuestion>[];
        list = parseQuestions(response.body);

        return list;
      } else {
        var list = <SurveyQuestion>[];
        return list;
      }
    } catch (e) {
      log("Get SurveyQuestions: $e");
      var list = <SurveyQuestion>[];
      return list;
    }
  }

  static Future<String> sendResponse(
      String userId, SurveyQuestion response) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _SEND_RESPONSE;
      map['userId'] = userId;
      map['surveyId'] = response.surveyId;
      map['title'] = response.title;
      map['description'] = response.description;
      map['questionNumber'] = response.questionNumber;
      map['question'] = response.question;
      map['response'] = response.response;
      final webResponse = await http.post(Uri.parse(ROOT), body: map);
      if (webResponse.statusCode == 200) {
        log(webResponse.body);
        return webResponse.body;
      } else {
        return "error";
      }
    } catch (e) {
      log("Get SendResponse: $e");
      return "error";
    }
  }

  static Future<String> countRespondents(String surveyId) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _COUNT_RESPONSE;
      map['surveyId'] = surveyId;

      final response = await http.post(Uri.parse(ROOT), body: map);

      if (response.statusCode == 200) {
        log("No. of respondents: ${response.body}");
        return response.body;
      } else {
        return 'error';
      }
    } catch (e) {
      log("Count Respondents: $e");
      return 'error';
    }
  }

  ///Get User
  static Future<User> getUser(String email) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_USER;
      map['email'] = email;

      http.Response response = await http.post(Uri.parse(ROOT), body: map);
      if (response.statusCode == 200) {
        log(response.body);
        User user = User.fromJson(json.decode(response.body));
        return user;
      } else {
        return User();
      }
    } catch (e) {
      log("Get User: $e");
      return User();
    }
  }

  ///

  ///GET ALL USERS///
  static Future<List<User>> getAllUsers() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_ALL_USERS;
      final response = await http.post(Uri.parse(ROOT), body: map);
      var list = <User>[];
      if (response.statusCode == 200) {
        log("ALL USERS response: ${response.body}");
        list = parseUsers(response.body);
        return list;
      } else {
        return list;
      }
    } on Exception catch (e) {
      log("Get All Users: $e");

      return <User>[];
    }
  }

  ///
  ///User did survey
  static Future<bool> userDidSurvey(String surveyId, String userId) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _DID_SURVEY;
      map['surveyId'] = surveyId;
      map['userId'] = userId;

      final response = await http.post(Uri.parse(ROOT), body: map);
      if (response.statusCode == 200) {
        log("User_done_Survey: ${response.body}");
        return json.decode(response.body) as bool;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  ///

  ///SignUp User
  static Future<String> addUser(String email, String password) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = ROOT;
      map['email'] = email;
      map['password'] = password;

      final response = await http.post(Uri.parse(ROOT), body: map);
      if (response.statusCode == 200) {
        log(response.body);
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      log(e.toString());
      return "error";
    }
  }

  ///Generate 64 byte Token
  static Future<String> genToken() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GEN_TOKEN;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (response.statusCode == 200) {
        log("Token: ${response.body}");
        return response.body;
      } else {
        return "failed to generate Token";
      }
    } catch (e) {
      log("Token generation Error $e");
      return "Token generation Error $e";
    }
  }

  //Verify eNaira Wallet
  static Future<WResponse> verifyWallet(String walletId) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _VERIFY_WALLET;
      map["wallet_alias"] = walletId;
      map["user_type"] = "user";
      map["channel_code"] = "APISNG";
      final response = await http.post(Uri.parse(ROOT2), body: map);
      if (response.statusCode == 200) {
        log("${response.statusCode} ${response.body}");
        return parseWResponse(response.body);
      } else {
        log("${response.statusCode} ${response.body}");
        return WResponse();
      }
    } catch (e) {
      log(e.toString());
      return WResponse();
    }
  }

  ///Pay User Reward
  Future<String> payUser(String channelCode, String userEmail, String userType,
      String destWalletAlias, int amount, String ref, String narration) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _PAY_REWARD;
      map['channel_code'] = channelCode;
      map['user_email'] = userEmail;
      map['user_type'] = userType;
      map['destination_wallet_alias'] = destWalletAlias;
      map['amount'] = amount;
      map['reference'] = ref;
      map['narration'] = narration;

      final response = await http.post(Uri.parse(ROOT2), body: map);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'error';
      }
    } catch (e) {
      return e.toString();
    }
  }

  ///

  static List<SurveyQuestion> parseQuestions(String responseBody) {
    var parsed = jsonDecode(responseBody);
    //log("RESPONSE: $responseBody");
    return parsed
        .map<SurveyQuestion>((json) => SurveyQuestion.fromJson(json))
        .toList();
  }

  static List<Survey> parseSurveys(String responseBody) {
    var parsed = json.decode(responseBody);
    return parsed.map<Survey>((json) => Survey.fromJson(json)).toList();
  }

  static List<User> parseUsers(String responseBody) {
    var parsed = json.decode(responseBody);
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static WResponse parseWResponse(String responseBody) {
    var parsed = json.decode(responseBody);
    return WResponse.fromJson(parsed);
  }
}
