import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A controller for managing chat messages.
class ChatController extends GetxController {
  var msgController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bottomJump();
    });
  }


  

  /// Sends a message to the chat list.
  void sendMessage() {
    if (msgController.text.trim().isNotEmpty) {
      //chatList.add(ChatModel(msg: msgController.text));
      msgController.clear();
      bottomJump();
    }
  }

  /// Scrolls to the bottom of the chat list.
  void bottomJump() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(0.0);
      }
    });
  }



   /// Shows a confirmation dialog to delete the chat.
  // void onTapDeleteIcon() {
  //   OkCancelDialog().customAlertBox(
  //     title: Strings.textDeleteChat.tr,
  //     subTitle: Strings.textDeleteChatSubTitle.tr,
  //     icon: Icons.delete,
  //     onConfirmPressed: () {
  //       clearChat();
  //       Get.back();
  //     },
  //   );
  // }
}
