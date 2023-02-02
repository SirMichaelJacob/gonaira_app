// import this Package in pubspec.yaml file
// dependencies:
//
//   flutter_staggered_animations:

// ignore_for_file: unnecessary_import, use_key_in_widget_constructors, camel_case_types, prefer_const_constructors, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:gonaira_app/controllers/transactionController.dart';
import 'package:gonaira_app/screens/custom_app_bar.dart';
import 'package:gonaira_app/screens/dashboard.dart';
import 'package:gonaira_app/screens/invoice_screen/invoice_screen_page.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../others/AppConstants.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 2;

    List<Widget> products = [
      productWidget(
          w: _w,
          title: "Transfer",
          desc: "Send eNaira",
          color: Color.fromARGB(255, 187, 40, 14)),
      productWidget(
          w: _w,
          title: "Pay for Flights",
          desc: "Air tickets",
          color: Color.fromARGB(255, 47, 75, 240)),
      productWidget(
          w: _w,
          title: "Pay for Utilities",
          desc: "Pay for power",
          color: Color.fromARGB(255, 19, 179, 86)),
      productWidget(
          w: _w,
          title: "Buy Airtime",
          desc: "Recharge phone",
          color: Color.fromARGB(255, 230, 80, 197)),
      productWidget(
          w: _w,
          title: "TV Subscription",
          desc: "Pay Dstv/Gotv",
          color: Color.fromARGB(255, 187, 85, 17)),
      productWidget(
          w: _w,
          title: "Pay Bills",
          desc: "Pay Medical Bills",
          color: Color.fromARGB(255, 20, 199, 169)),
    ];

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            CustomAppBar(
              Icons.arrow_back,
              leftCallback: () {
                Get.to(() => Dashboard());
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Shop with eNaira',
                  style: TextStyle(
                      color: AppConstants.darkTealColor, fontSize: 15)),
            ),
            Expanded(
              child: AnimationLimiter(
                child: GridView.count(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: EdgeInsets.all(_w / 60),
                  crossAxisCount: columnCount,
                  children: products
                      .map((product) => AnimationConfiguration.staggeredGrid(
                          position: products.indexOf(product),
                          duration: Duration(milliseconds: 500),
                          columnCount: columnCount,
                          child: ScaleAnimation(
                              duration: Duration(milliseconds: 900),
                              curve: Curves.fastLinearToSlowEaseIn,
                              scale: 1.5,
                              child: FadeInAnimation(child: product))))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class productWidget extends StatelessWidget {
  final String? title;
  final String? desc;
  final Color? color;
  productWidget({
    this.title,
    this.desc,
    this.color,
    Key? key,
    required double w,
  })  : _w = w,
        super(key: key);

  final double _w;
  static final UniqueKey formkey1 = UniqueKey();
  final TransactionController trxController = Get.find();
  FormGroup get formGroup1 {
    return FormBuilder().group(
      {
        'rWalletAlias': FormControl<String>(validators: [
          Validators.required,
        ]),
        'amount': FormControl<String>(validators: [
          Validators.number,
          Validators.required,
        ]),
        'password': FormControl<String>(validators: [
          Validators.minLength(7),
          Validators.required,
        ]),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        title!.substring(0).toLowerCase().contains('transfer')
            ? Get.defaultDialog(
                title: 'Enter Transfer Details',
                titleStyle: TextStyle(
                    color: AppConstants.titleBackColor,
                    fontSize: 16,
                    letterSpacing: 2,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Font3'),
                content: Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: ReactiveFormBuilder(
                        key: formkey1,
                        form: () => formGroup1,
                        builder: (context, formGroup1, child) =>
                            ListView(children: [
                          ReactiveTextField(
                            style: TextStyle(fontSize: 14),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                label: Text("Recipient wallet alias:")),
                            formControlName: 'rWalletAlias',
                            textInputAction: TextInputAction.next,
                            validationMessages: (control) => {
                              ValidationMessage.required:
                                  'Wallet Alias must not be empty',
                            },
                          ),
                          ReactiveTextField(
                            style: TextStyle(fontSize: 14),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                labelText: "Amount:"),
                            formControlName: 'amount',
                            textInputAction: TextInputAction.next,
                            validationMessages: (control) => {
                              ValidationMessage.required:
                                  'Amount must not be empty',
                            },
                          ),
                          ReactiveTextField(
                            style: TextStyle(fontSize: 14),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            // obscuringCharacter: '#',
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                labelText: "Password:"),
                            formControlName: 'password',
                            textInputAction: TextInputAction.next,
                            validationMessages: (control) => {
                              ValidationMessage.required:
                                  'Password is required',
                              ValidationMessage.minLength:
                                  'Must be at least 7 characters',
                            },
                          ),
                          ReactiveFormConsumer(
                            builder: (context, formGroup1, child) =>
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppConstants.tealishColor)),
                                    onPressed: formGroup1.valid
                                        ? () async {
                                            trxController.tranxAmount.value =
                                                double.parse(formGroup1
                                                    .control('amount')
                                                    .value);
                                            trxController.rWalletALias.value =
                                                formGroup1
                                                    .control('rWalletAlias')
                                                    .value;

                                            Get.off(() => InvoiceScreen());
                                          }
                                        : null,
                                    // icon:
                                    //     Icon(Icons.check, color: Colors.white),
                                    child: Text('Send')),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Cancel'))
                        ]),
                      ),
                    ),
                  ),
                ))
            : Get.defaultDialog(
                title: 'Coming Soon',
                titleStyle: TextStyle(
                    color: AppConstants.titleBackColor,
                    fontSize: 16,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Font3'),
                content: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Icon(Icons.hourglass_top_sharp,
                          size: 30, color: AppConstants.tealishColor)
                    ])));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: _w / 30, left: _w / 60, right: _w / 60),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              title!.substring(0).toLowerCase().contains('transfer')
                  ? Icons.attach_money
                  : Icons.task,
              color: Colors.white,
              size: 35,
            ),
            Text(title!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15)),
            Text(desc!,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppConstants.itemsColor, fontSize: 10)),
            SizedBox(
              height: 3,
            ),
          ],
        )),
      ),
    );
  }
}
