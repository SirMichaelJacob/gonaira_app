// ignore_for_file: non_constant_identifier_names

import 'package:gonaira_app/models/WalletInfo.dart';

class ResponseData {
  String? uid;
  String? uid_type;
  String? kyc_status;
  String? phone;
  String? email_id;
  String? first_name;
  String? last_name;
  String? middle_name;
  String? title;
  String? town;
  String? state_of_residence;
  String? lga;
  String? address;
  String? country_of_origin;
  String? account_number;
  String? tier;
  String? country_of_birth;
  String? state_of_origin;
  String? inst_code;
  String? enaira_bank_code;
  String? relationship_bank;
  WalletInfo? wallet_info;
  String? password;
  String? referrers_code;

  ResponseData({
    this.uid,
    this.uid_type,
    this.kyc_status,
    this.phone,
    this.email_id,
    this.first_name,
    this.last_name,
    this.middle_name,
    this.title,
    this.town,
    this.state_of_residence,
    this.lga,
    this.address,
    this.country_of_origin,
    this.account_number,
    this.tier,
    this.country_of_birth,
    this.state_of_origin,
    this.inst_code,
    this.enaira_bank_code,
    this.relationship_bank,
    this.wallet_info,
    this.password,
    this.referrers_code,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      uid: json['uid'],
      uid_type: json['uid_type'],
      kyc_status: json['kyc_status'],
      phone: json['phone'],
      email_id: json['email_id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      middle_name: json['middle_name'],
      title: json['title'],
      town: json['town'],
      state_of_residence: json['state_of_residence'],
      lga: json['lga'],
      address: json['address'],
      country_of_origin: json['country_of_origin'],
      account_number: json['account_number'],
      tier: json['tier'],
      country_of_birth: json['country_of_birth'],
      state_of_origin: json['state_of_origin'],
      inst_code: json['inst_code'],
      enaira_bank_code: json['enaira_bank_code'],
      relationship_bank: json['relationship_bank'],
      password: json['password'],
      referrers_code: json['referrers_code'],
      wallet_info: WalletInfo.fromJson(json['wallet_info']),
    );
  }
}
