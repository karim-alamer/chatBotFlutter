import '../Widgets/chat_messages_block.dart';

import '../Widgets/input_field.dart';
import '../../1MainHelper/Colors/colors.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = "/chat-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF638D8D),
        title: Text(
          "محادثة الية",
          textScaleFactor: 1,
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/images/2.png',
          )
        ],
      ),
      body: Container(
        color: chatScreenBackground,
        child: Column(
          children: [
            Expanded(
              child: ChatMessagesBlock(),
            ),
            InputFullCard(),
          ],
        ),
      ),
    );
  }
}
