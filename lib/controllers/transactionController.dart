// ignore_for_file: unused_import, file_names

import 'dart:convert';
import 'dart:developer';

import 'package:gonaira_app/models/goNaira.dart';
import 'package:gonaira_app/models/User.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TransactionController extends GetxController {
  RxDouble walletBalance = (0.0).obs;
  RxDouble tranxAmount = (0.0).obs;
  RxString rWalletALias = "".obs;
  Rx<GoNaira> goNaira = GoNaira().obs;
  RxList<GoNaira> transactions = <GoNaira>[].obs;
  RxBool isFetching = false.obs;
  //Getters
  GetStorage tranxStore = GetStorage('TRANX_BOX');
  GetStorage userStore = GetStorage('USER_SETTING');
  String get userPhone => tranxStore.read('userPhone') ?? "";
  String get walletAddress => tranxStore.read('walletAddress') ?? "";
  String get walletAlias => tranxStore.read('walletAlias') ?? "";
  //Setters
  void setUserPhone(String value) => tranxStore.write('userPhone', value);
  void setWalletAddress(String wAddress) =>
      tranxStore.write('walletAddress', wAddress);
  void setWalletAlias(String value) => tranxStore.write('walletAlias', value);

  @override
  void onInit() async {
    super.onInit();
    //Stored Completed Transactions in GetStorage
    var completed = await tranxStore.read('completed');

    if (completed != null) {
      List jsonData = json.decode(completed);
      transactions =
          jsonData.map((trnx) => GoNaira.fromJson(trnx)).toList().obs;
      log("CompletedTransactions in storage >> ${transactions.length}");
    }
    log("CompletedTransactions in storage >> ${transactions.length}");
  }
}
