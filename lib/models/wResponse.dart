// ignore_for_file: non_constant_identifier_names

import 'package:gonaira_app/models/ResponseData.dart';

class WResponse {
  String? response_code;
  String? response_message;
  ResponseData? response_data;

  WResponse({this.response_code, this.response_message, this.response_data});

  factory WResponse.fromJson(Map<String, dynamic> json) {
    return WResponse(
        response_code: json['response_code'],
        response_message: json['response_message'],
        response_data: ResponseData.fromJson(json['response_data']));
  }
}
