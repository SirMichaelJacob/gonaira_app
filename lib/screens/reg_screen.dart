// ignore_for_file: unused_import, must_be_immutable, prefer_const_constructors, sort_child_properties_last
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonaira_app/controllers/DBServer.dart';
import 'package:gonaira_app/controllers/SurveyController.dart';
import 'package:gonaira_app/screens/loadingWidget.dart';
import 'package:gonaira_app/screens/wallet_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'dart:developer';
import '../controllers/transactionController.dart';
import '../others/AppConstants.dart';

class RegWidget extends StatelessWidget {
  static final UniqueKey formkey1 = UniqueKey();
  TransactionController trxController = Get.find();
  SurveyController surveyController = Get.find();
  FormGroup get formGroup1 {
    return FormBuilder().group({
      'email': FormControl<String>(validators: [
        Validators.email,
        Validators.required,
      ]),
      'terms': FormControl<bool>(
          value: false, validators: [Validators.requiredTrue]),
      // 'walletId': FormControl<String>(validators: [
      //   Validators.minLength(11),
      //   Validators.required,
      // ]),
      'password': FormControl<String>(validators: [
        Validators.minLength(7),
        Validators.required,
      ]),
      'confirmPassword': FormControl<String>(validators: [
        Validators.minLength(7),
        Validators.required,
      ]),
    }, [
      Validators.mustMatch('password', 'confirmPassword')
    ]);
  }

  RegWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Create Account',
                style:
                    TextStyle(color: AppConstants.darkTealColor, fontSize: 27)),
          ),
          Obx(
            () => !trxController.isFetching.value
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
                              keyboardType: TextInputType.emailAddress,
                              // controller: emailController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  label: Text(
                                    'Email:',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  border: OutlineInputBorder()),
                              formControlName: 'email',
                              textInputAction: TextInputAction.next,
                              validationMessages: (control) => {
                                ValidationMessage.required:
                                    'Email must not be empty',
                                ValidationMessage.email:
                                    'Email value must be a valid email',
                              },
                              
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 30),
                          child: SizedBox(
                            height: 60,
                            child: ReactiveTextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  label: Text('Password:'),
                                  border: OutlineInputBorder()),
                              formControlName: 'password',
                              textInputAction: TextInputAction.next,
                              validationMessages: (control) => {
                                ValidationMessage.minLength:
                                    'Password must be min 7 characters'
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 30),
                          child: SizedBox(
                            height: 60,
                            child: ReactiveTextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  label: Text('Confirm Password:'),
                                  border: OutlineInputBorder()),
                              formControlName: 'confirmPassword',
                              textInputAction: TextInputAction.next,
                              validationMessages: (control) => {
                                ValidationMessage.mustMatch:
                                    'Password and Confirm Password must match'
                              },
                            ),
                          ),
                        ),
                        ReactiveCheckboxListTile(
                          activeColor: AppConstants.primaryColor,
                          controlAffinity: ListTileControlAffinity.leading,
                          formControlName: 'terms',
                          title: Text(
                            'By Signing up you agree to our terms and Conditions',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        ReactiveFormConsumer(
                          builder: (context, formGroup1, child) =>
                              ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppConstants.tealishColor)),
                            child: Text('Register'),
                            onPressed: formGroup1.valid
                                ? () async {
                                    trxController.isFetching.value = true;
                                    //If all is ok
                                    //Set Token
                                    var token = await Server.genToken();
                                    token = token +
                                        md5
                                            .convert(utf8.encode(formGroup1
                                                    .control('email')
                                                    .value +
                                                AppConstants.salt))
                                            .toString();
                                    surveyController.setRegToken(token);
                                    var fromStr = await surveyController
                                        .userSetting
                                        .read('userToken');
                                    log("Read From Store: $fromStr");
                                    trxController.isFetching.value = false;
                                    //Verify Wallet
                                    Get.off(() => WalletScreen());
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  )
                : LoadingWidget(message: "Contacting \nServer..."),
          ),
        ],
      ),
    ));
  }
}
