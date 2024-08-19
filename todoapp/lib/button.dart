import 'package:flutter/material.dart';

class Mubutton extends StatelessWidget {
  Color color;
  void Function()? onPressed;
  String text;
  Mubutton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.all(7),
        // margin: EdgeInsets.symmetric(horizontal: 9),
        color: color,
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(text),
        ));
  }
}
