// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:get/get.dart';
import 'package:gonaira_app/controllers/transactionController.dart';
import 'package:flutter/material.dart';
import 'package:gonaira_app/screens/historyScreen.dart';
import 'package:gonaira_app/screens/productsWidget.dart';
import 'package:intl/intl.dart';

import '../controllers/SurveyController.dart';
import '../others/AppConstants.dart';

class MidWidget extends StatelessWidget {
  final TransactionController? trxcontroller;
  final SurveyController? surveyController;
  final Function? callback;

  MidWidget({this.trxcontroller, this.surveyController, this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3.5,
        ), //SizedBox is for Spacing
        SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ProductsScreen());
                  },
                  child: Chip(
                    backgroundColor: AppConstants.iconsColor,
                    avatar: Icon(Icons.shopping_cart,
                        color: AppConstants.itemsColor),
                    label: Text(
                      "Shop with eNaira",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  //await AppConstants().getSurveys();
                  Get.to(() => HistoryScreen());
                },
                child: Chip(
                  avatar: Icon(Icons.history, color: AppConstants.itemsColor),
                  label: Text("Survey history",
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: AppConstants.iconsColor,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }
}
