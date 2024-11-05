import 'package:flutter/material.dart';
import 'package:jogo_match/utils/const.dart';

class ResultMessage extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  bool isSucess = false;
  final icon;

  ResultMessage(
      {super.key,
      required this.message,
      required this.onTap,
      required this.icon,
      required this.isSucess});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: Container(
        height: 480,
        color: Colors.deepPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // the result
            Center(
              child: Text(
                message,
                style: whiteTexStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              isSucess ? "assets/sucess_emoji.png" : "assets/error_emoji.png",
              fit: BoxFit.fill,
            ),

            // button to go to next question

            InkWell(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(4),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.deepPurple[300],
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
