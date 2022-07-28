import 'package:flutter/material.dart';
import '../Widgets/body.dart';

class FrequentQuestionsScreen extends StatelessWidget {
  static const routeName = '/frequent-questions-screen';
  const FrequentQuestionsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF638D8D),
      title: Text(
        "الأسئلة المتكررة",
      ),
      centerTitle: true,
      actions: [
        Image.asset(
          'assets/images/2.png',
        )
      ],
    );
  }
}
