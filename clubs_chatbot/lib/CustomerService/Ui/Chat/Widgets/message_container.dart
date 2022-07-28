import 'package:flutter/material.dart';
import '../../1MainHelper/Colors/colors.dart';

// ignore: must_be_immutable
class LeftSideMessage extends StatelessWidget {
  String message;
  LeftSideMessage(this.message);

  @override
  Widget build(BuildContext context) {
    message = message.replaceAll('. ', '.\n\n');
    message = message.replaceAll(':-', ':-\n');
    print(message);
    double font = 18;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        top: 5,
      ),
      child: Stack(
        // ignore: deprecated_member_use
        overflow: Overflow.visible,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 16,
                  bottom: 8,
                  left: 26,
                ),
                decoration: BoxDecoration(
                  color: containerLeftBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                constraints: BoxConstraints(
                  minWidth: 200,
                  maxWidth: size.width - 80,
                ),
                child: Text(
                  message,
                  textScaleFactor: 1,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: font,
                    color: containerLeftText,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: CircleAvatar(
              backgroundColor: circleLeftBackground,
              child: Image.asset(
                'assets/icons/bot2.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RightSideMessage extends StatelessWidget {
  final String message;
  RightSideMessage(this.message);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double font = 18;
    return Padding(
      padding: const EdgeInsets.only(
        right: 5,
        top: 5,
      ),
      child: Stack(
        // ignore: deprecated_member_use
        overflow: Overflow.visible,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 16,
                  bottom: 8,
                  right: 26,
                ),
                decoration: BoxDecoration(
                  color: containerRightBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                constraints: BoxConstraints(
                  minWidth: 200,
                  maxWidth: size.width - 80,
                ),
                child: Text(
                  message,
                  textScaleFactor: 1,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: font,
                    color: containerRightText,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Image.asset(
                'assets/icons/person.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
