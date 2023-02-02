// ignore_for_file: file_names

class GoNaira {
  ///Receiver's token
  String? recToken;

  ///sender's token
  String? senderToken;

  ///Transaction value
  String? value;

  ///eNaira wallet password
  String? password;

  ///eNaira walletID
  String? walletId;

  GoNaira(
      {this.recToken,
      this.senderToken,
      this.value,
      this.password,
      this.walletId});

  factory GoNaira.fromJson(Map<String, dynamic> json) {
    return GoNaira(
      recToken: json['recToken'],
      senderToken: json['senderToken'],
      value: json['value'],
      password: json['password'],
      walletId: json['walletId'],
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['recToken'] = recToken;
    map['senderToken'] = senderToken;
    map['value'] = value;
    map['password'] = password;
    map['walletId'] = walletId;
    return map;
  }
}
