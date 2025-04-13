import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdaptiveDialog {
  static Future showDialog({
    required String title,
    required String content,
    String yesText = "Yes",
    required void Function()? onPressedYes,
  }) {
    return showAdaptiveDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onPressedYes,
              child:  Text(yesText),
            ),
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }
}
