// ignore_for_file: non_constant_identifier_names

class WalletInfo {
  String? tier;
  String? nuban;
  String? message;
  String? wallet_alias;
  String? wallet_address;
  String? daily_tnx_limit;

  WalletInfo(
      {this.tier,
      this.nuban,
      this.message,
      this.wallet_alias,
      this.wallet_address,
      this.daily_tnx_limit});

  factory WalletInfo.fromJson(Map<String, dynamic> json) {
    return WalletInfo(
        tier: json['tier'],
        nuban: json['nuban'],
        message: json['message'],
        wallet_alias: json['wallet_alias'],
        wallet_address: json['wallet_address'],
        daily_tnx_limit: json['daily_tnx_limit']);
  }
}
