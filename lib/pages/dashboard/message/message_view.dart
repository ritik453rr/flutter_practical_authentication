import 'package:authentication_ptcl/comman/custom_appbart.dart';
import 'package:authentication_ptcl/pages/dashboard/message/message_controller.dart';
import 'package:authentication_ptcl/pages/dashboard/message/widgets/messages_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A view that displays a list of messages.
class MessageView extends GetView<MessageController> {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: EdgeInsets.only(top: 20, bottom: 30),
        itemCount: 10,
        itemBuilder: (context, index) {
          return messageItem(
            name: "Ritik",
          );
        },
      ),
    );
  }
}
