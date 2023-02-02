// ignore_for_file: file_names, unused_import

import 'dart:convert';

class SurveyQuestion {
  String? questionNumber;
  String? surveyId;
  String? title;
  String? description;
  String? question;
  String? response;
  List? options;

  SurveyQuestion({
    this.questionNumber,
    this.surveyId,
    this.title,
    this.description,
    this.question,
    this.response,
    this.options,
  });

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) {
    return SurveyQuestion(
      questionNumber: json['questionNumber'] as String,
      surveyId: json['surveyId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      question: json['question'] as String,
      response: json['response'] as String,
      options: json['options'],
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[' questionNumber'] = questionNumber;
    map['surveyId'] = surveyId;
    map['title'] = title;
    map['description'] = description;
    map['question'] = question;
    map['response'] = response;
    map['options'] = options;
    return map;
  }
}
