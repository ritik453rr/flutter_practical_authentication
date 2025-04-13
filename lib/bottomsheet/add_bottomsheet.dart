import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A class to display a bottom sheet for adding note.
class AddNoteBottomsheet {
  Future showSheet({
    required TextEditingController? titleController,
    required TextEditingController? subtitleController,
    required void Function()? onTapButton,
    bool isUpdation = false,
  }) {
    return Get.bottomSheet(
      //isScrollControlled: true,
      Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Title",
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            TextField(
              controller: subtitleController,
              decoration: const InputDecoration(
                hintText: "Subtitle",
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            ElevatedButton(
              onPressed: onTapButton,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
              ),
              child: Text(
                isUpdation ? "Update" : "Add",
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
