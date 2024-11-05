import 'package:flutter/material.dart';
import 'package:jogo_match/controller/match_controller.dart';
import 'package:jogo_match/utils/const.dart';
import 'package:jogo_match/utils/colors_app.dart';

class MyButton extends StatelessWidget {
  final String child;
  final VoidCallback onTap;
  MatchController controller;
  MyButton(
      {super.key,
      required this.child,
      required this.onTap,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    Color? buttonColor =
        controller.finalFaze ? Colors.orange : ColorsApp.purple400;
    if (child == 'C') {
      buttonColor = controller.finalFaze ? Colors.deepPurple : Colors.orange;
    } else if (child == 'DEL') {
      buttonColor = Colors.red;
    } else if (child == '=') {
      buttonColor = Colors.green;
    }

    return Padding(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: buttonColor,
          elevation: 4,
          child: Center(
            child: Text(
              child,
              style: whiteTexStyle,
            ),
          ),
        ),
      ),
    );
  }
}
