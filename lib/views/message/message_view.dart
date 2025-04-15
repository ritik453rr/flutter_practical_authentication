import 'package:authentication_ptcl/comman/custom_appbart.dart';
import 'package:authentication_ptcl/views/message/message_controller.dart';
import 'package:authentication_ptcl/views/message/widgets/messages_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A view that displays a list of messages.
class MessageView extends GetView<MessageController> {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(),
      // CustomAppBar(
      //   title: Strings.textChats.tr,
      //   centerTitle: false,
      //   trailingIcon: Icons.search,
      //   hideBackButton: true,
      //   shadow: false,
      //   onTapTrailingIcon: () {
      //     Get.toNamed(AppRoutes.routeSearchUser);
      //   },
      // ),
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
