import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNoteBottomsheet {
  Future showSheet({TextEditingController? titleController, TextEditingController? subtitleController,required void Function()? onTapAdd}) { 
    return    Get.bottomSheet(
              Container(
                height: Get.height * 0.4,
                width: Get.width,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: "Title",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: subtitleController,
                      decoration: const InputDecoration(
                        hintText: "Subtitle",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed:onTapAdd,
                      child: const Text("Add"),
                    )
                  ],
                ),
              ),
            );
         
  }
}