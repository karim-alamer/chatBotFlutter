import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

// ignore: must_be_immutable
class SingleQuestionAnswer extends StatelessWidget {
  final String question;
  String answer;
  final int counter;

  SingleQuestionAnswer({Key key, this.question, this.answer, this.counter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    answer = answer.replaceAll(':-', ':-\n');
    answer = answer.replaceAll('. ', '.\n\n');
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          title: Text(
            question,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontSize: 19,
            ),
          ),
          leading: CircleAvatar(
            child: Text(
              counter.toString(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Color(0xFF638D8D),
          ),
          subtitle: Text(
            answer,
            style: TextStyle(
              fontSize: 18,
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
            ),
          ),
        ),
      ),
    );
  }
}
