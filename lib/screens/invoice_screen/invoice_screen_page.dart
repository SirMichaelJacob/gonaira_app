// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonaira_app/controllers/SurveyController.dart';
import 'package:gonaira_app/controllers/transactionController.dart';
import 'package:gonaira_app/others/AppConstants.dart';

class InvoiceScreen extends StatelessWidget {
  SurveyController surveyController = Get.find();
  TransactionController trxController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Successful'),
        backgroundColor: AppConstants.appBarColor,
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: AppConstants.tealishColor,
                size: 60,
              ),
              Text('Transaction Successful',
                  style: TextStyle(
                      color: AppConstants.darkTealColor, fontSize: 24)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.red,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Text('Paid On:',
                          style: TextStyle(
                            color: Color.fromARGB(255, 126, 122, 126),
                            fontWeight: FontWeight.w100,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text('13 Aug 2022'),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        'Sender:',
                        style: TextStyle(
                          color: Color.fromARGB(255, 126, 122, 126),
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        surveyController.appToken.trim(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text(
                          'Beneficiary:',
                          style: TextStyle(
                            color: Color.fromARGB(255, 126, 122, 126),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Text(trxController.rWalletALias.value),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text('Amount:',
                          style: TextStyle(
                            color: Color.fromARGB(255, 126, 122, 126),
                            fontWeight: FontWeight.w100,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(trxController.tranxAmount.value.toString()),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
