import '../../../providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/message_details_model.dart';
import 'message_container.dart';

// ignore: must_be_immutable
class ChatMessagesBlock extends StatelessWidget {
  List<MessageDetailsModel> chatMessages = [];

  @override
  Widget build(BuildContext context) {
    chatMessages =
        Provider.of<ChatProvider>(context, listen: false).getChatMessages();
    chatMessages.sort((a, b) => a.sendDate.compareTo(b.sendDate));
    chatMessages = chatMessages.reversed.toList();

    return Consumer<ChatProvider>(
      builder: (context, value, child) {
        chatMessages = value.getChatMessages();
        chatMessages.sort((a, b) => a.sendDate.compareTo(b.sendDate));
        chatMessages = chatMessages.reversed.toList();
        return ListView.builder(
          reverse: true,
          itemCount: chatMessages.length,
          itemBuilder: (_, index) {
            if (chatMessages[index].senderType == "Client") {
              return RightSideMessage(chatMessages[index].meesage);
            } else {
              return LeftSideMessage(chatMessages[index].meesage);
            }
          },
        );
      },
    );
  }
}
