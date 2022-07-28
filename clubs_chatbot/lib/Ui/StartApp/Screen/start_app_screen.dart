import '../Widgets/body.dart';

import 'package:flutter/material.dart';

class StartAppScreen extends StatelessWidget {
  static const routeName = "/start_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Body(),
    );
  }
}
