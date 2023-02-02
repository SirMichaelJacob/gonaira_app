import 'package:flutter/material.dart';
import 'package:gonaira_app/screens/top_screen.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Color.fromARGB(179, 241, 239, 239)),
          child: TopScreen()),
    );
  }
}
