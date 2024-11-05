import 'package:flutter/material.dart';
import 'package:jogo_match/utils/colors_app.dart';

class Levels extends StatelessWidget {
  IconData icon;
  double size;
  Color color;
  Color? colorIcon = ColorsApp.purple;
  Levels(
      {super.key,
      required this.icon,
      required this.size,
      required this.color,
      this.colorIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(18)),
      child: Icon(
        icon,
        size: 40,
        color: colorIcon,
      ),
    );
  }
}
