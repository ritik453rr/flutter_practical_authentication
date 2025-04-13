import 'package:authentication_ptcl/comman/custom_appbart.dart';
import 'package:authentication_ptcl/views/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(
          onTapTrailingIcon: controller.logout,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: controller.addNote,
          child: const Icon(Icons.add),
        ),
        body: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.notes.isEmpty) {
              return const Center(
                child: Text(
                  "No Notes Found",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return Container(
              height: 80,
              margin: const EdgeInsets.only(top: 20),
              child: Stack(
                children: [
                  ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.notes.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    itemBuilder: (context, index) {
                      final note = controller.notes[index];
                      return listItem(
                        title: note.title,
                        onTap: () {
                          controller.updateNote(note: note);
                        },
                        onLongPress: () {
                          controller.deleteNote(noteId: note.id);
                        },
                      );
                    },
                  ),

                  // Loading indicator at the end
                  if (controller.isFetchingMore.value)
                    Positioned(
                      right: 20,
                      child: Container(
                        height: 80,
                        width: 90,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

//// Widget to display each note in the list
Widget listItem({
  required String title,
  void Function()? onLongPress,
  void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    onLongPress: onLongPress,
    child: Container(
      height: 70,
      width: 70,
      margin: const EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          title[0].toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
