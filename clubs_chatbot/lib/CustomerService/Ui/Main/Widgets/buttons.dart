import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Function function;
  final backgroundColor;
  final textColor;

  const Button(
      {Key key,
      this.title,
      this.function,
      this.backgroundColor,
      this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 5,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: backgroundColor,
          minimumSize: Size(205, 50),
        ),
        child: Text(
          title,
          textScaleFactor: 1,
          style: TextStyle(
            fontSize: 17,
            color: textColor,
          ),
        ),
        onPressed: () {
          function();
        },
      ),
    );
  }
}
