import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonaira_app/screens/reg_screen.dart';
import 'package:gonaira_app/screens/top_screen.dart';
import 'package:gonaira_app/screens/top_widget.dart';

import '../controllers/transactionController.dart';

class SignupScreen extends StatelessWidget {
  TransactionController trxController = Get.find<TransactionController>();
  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          // child: completedWidget(context)
          child: Container(
            height: MediaQuery.of(context).size.height,
            // ignore: prefer_const_constructors
            decoration:
                BoxDecoration(color: Color.fromARGB(179, 241, 239, 239)),
            child: Column(children: [
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  // topWidget(
                  //   trxcontroller: trxController,
                  // ),
                  TopScreen(
                    trxcontroller: trxController,
                  )
                ],
              ),
              Expanded(
                child: RegWidget(),
              ),
            ]),
          )),
    );
  }
}
