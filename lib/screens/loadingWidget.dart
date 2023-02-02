// ignore_for_file: file_names,prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, no_leading_underscores_for_local_identifiers

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:gonaira_app/others/AppConstants.dart';

class LoadingWidget extends StatefulWidget {
  String? message;
  LoadingWidget({this.message = ""});
  @override
  _loadingWidgetState createState() => _loadingWidgetState();
}

class _loadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: _width / 2.7,
      width: _width / 2.7,
      child: Animator<double>(
        duration: Duration(milliseconds: 1000),
        cycles: 0,
        curve: Curves.easeInOutCubicEmphasized,
        tween: Tween<double>(begin: 15.0, end: 25.0),
        builder: (context, animatorState, child) => Column(
          children: [
            Text(
              'GoNaira',
              style: TextStyle(
                letterSpacing: 1.0,
                color: AppConstants.primaryColor,
                fontFamily: 'Font3',
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              this.widget.message!.isNotEmpty
                  ? this.widget.message!
                  : 'Please wait...',
              style: TextStyle(
                letterSpacing: 2.0,
                color: AppConstants.darkGreenColor,
                fontFamily: 'Font1',
                fontSize: animatorState.value / 2,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
