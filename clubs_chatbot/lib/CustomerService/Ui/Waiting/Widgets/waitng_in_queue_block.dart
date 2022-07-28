import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WaitingInQueueBlock extends StatelessWidget {
  int userNumber;
  int counter = 1;
  DateTime dateTemp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your number in queue :",
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              maxRadius: 30,
              backgroundColor: Color(0xFF364F8A),
              child: Text(
                userNumber.toString(),
                textScaleFactor: 1,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
