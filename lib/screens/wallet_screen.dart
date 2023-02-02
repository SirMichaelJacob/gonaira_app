// ignore_for_file: unused_import, must_be_immutable, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonaira_app/controllers/DBServer.dart';
import 'package:gonaira_app/controllers/SurveyController.dart';
import 'package:gonaira_app/screens/dashboard.dart';
import 'package:gonaira_app/screens/loadingWidget.dart';
import 'package:gonaira_app/screens/top_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'dart:developer';
import '../controllers/transactionController.dart';
import '../others/AppConstants.dart';

class WalletScreen extends StatelessWidget {
  static final UniqueKey formkey1 = UniqueKey();
  TransactionController trxController = Get.find();
  SurveyController surveyController = Get.find();
  TextEditingController phoneController = TextEditingController();
  FormGroup get formGroup1 {
    return FormBuilder().group(
      {
        'walletId': FormControl<String>(validators: [
          Validators.required,
        ]),
      },
    );
  }

  WalletScreen({Key? key}) : super(key: key);

  bool phoneNumberIsTrue(String walletPhone, String value) {
    return walletPhone == value ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            topWidget(
              trxcontroller: trxController,
              surveyController: surveyController,
              showInfo: false,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Connect to your eNaira Wallet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppConstants.darkTealColor, fontSize: 24)),
            ),
            Obx(() => trxController.isFetching.value == false
                ? ReactiveFormBuilder(
                    key: formkey1,
                    form: () => formGroup1,
                    builder: (context, formGroup1, child) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 30),
                          child: SizedBox(
                            height: 60,
                            child: ReactiveTextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  label: Text('eNaira WalletID/Alias:'),
                                  border: OutlineInputBorder()),
                              formControlName: 'walletId',
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                        ReactiveFormConsumer(
                          builder: (context, formGroup1, child) =>
                              ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppConstants.tealishColor)),
                            child: Text('Verify'),
                            onPressed: formGroup1.valid
                                ? () async {
                                    trxController.isFetching.value = true;
                                    var resp = await Server.verifyWallet(
                                            formGroup1
                                                .control('walletId')
                                                .value)
                                        .whenComplete(() {
                                      trxController.isFetching.value = false;
                                    });
                                    if (resp.response_code == '00') {
                                      trxController.isFetching.value = false;
                                      Get.defaultDialog(
                                        title:
                                            'Enter Your Wallet Phone number to Proceed',
                                        titleStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Font3'),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // Text(
                                              //     "Name: ${resp.response_data!.first_name} ${resp.response_data!.last_name}"),
                                              // Text(
                                              //     "Address:${resp.response_data!.address}"),
                                              // Text(
                                              //     "Phone:${resp.response_data!.phone}"),
                                              TextField(
                                                controller: phoneController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    labelText: "Phone no:"),
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              //Save User Token in App and Connect Wallet
                                              if (phoneNumberIsTrue(
                                                  resp.response_data!.phone!,
                                                  phoneController.text)) {
                                                //Set App Credentials
                                                trxController.setUserPhone(
                                                    resp.response_data!.phone!);
                                                trxController.setWalletAlias(
                                                    resp
                                                        .response_data!
                                                        .wallet_info!
                                                        .wallet_alias!);
                                                trxController.setWalletAddress(
                                                    resp
                                                        .response_data!
                                                        .wallet_info!
                                                        .wallet_address!);

                                                //
                                                //Redirect to Dashboard
                                                Get.off(() => Dashboard());
                                              } else {
                                                Get.defaultDialog(
                                                  title:
                                                      'Phone number does not match Wallet Information',
                                                  titleStyle: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily: 'Font3'),
                                                );
                                              }
                                            },
                                            child: Text("Yes, Connect Wallet"),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        AppConstants
                                                            .titleBackColor)),
                                          ),
                                        ],
                                      );
                                    } else {
                                      Get.defaultDialog(
                                          title: 'Invalid Wallet alias',
                                          titleStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Font3'),
                                          content: SingleChildScrollView(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                Icon(Icons.warning_amber,
                                                    size: 30,
                                                    color: Color.fromARGB(
                                                        255, 170, 1, 1))
                                              ])));
                                    }

                                    // log("WALLET ALIAS:${resp.response_data!.wallet_info!.wallet_alias}");
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  )
                : LoadingWidget()),
          ],
        ),
      ))),
    );
  }
}
