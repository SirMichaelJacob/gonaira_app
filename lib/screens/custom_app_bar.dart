// ignore_for_file: prefer_const_literals_to_create_immutables,use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, prefer_const_constructors, unused_element, avoid_init_to_null

import 'package:gonaira_app/others/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonaira_app/screens/dashboard.dart';

import '../controllers/SurveyController.dart';

class CustomAppBar extends StatelessWidget {
  final IconData leftIcon;
  final IconData? rightIcon;
  final Function? leftCallback;
  final String? title;
  final SurveyController? controller;
  CustomAppBar(this.leftIcon,
      {this.rightIcon = null,
      this.controller,
      this.title = '',
      this.leftCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.tealishColor,
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 25,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
          onTap: leftCallback != null ? () => leftCallback!() : null,
          child: _buildIcon(leftIcon),
        ),
        Column(children: [
          Text('GoNaira',
              style: TextStyle(
                  fontFamily: 'Font1',
                  fontSize: 30,
                  color: Colors.white,
                  letterSpacing: 1.0)),
          Text('Real People, Real Money',
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  letterSpacing: 1.0)), //For Space Under
          SizedBox(
            height: 20,
          ),
        ]),
        rightIcon != null ? _buildRightIcon(rightIcon!) : Container(),
      ]),
    );
  }

  Container _buildIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(icon),
    );
  }

  Widget _buildRightIcon(IconData icon) {
    return GestureDetector(
      onTap: () => Get.to(() => Dashboard()),
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(icon)),
    );
  }
}
