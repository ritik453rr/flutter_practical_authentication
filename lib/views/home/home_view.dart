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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Obx(
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
                  return SizedBox(
                    height: 80,
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.notes.length +
                          (controller.isFetchingMore.value ? 1 : 0),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 10,
                      ),
                      itemBuilder: (context, index) {
                        // Show loading indicator at the end
                        if (index >= controller.notes.length) {
                          return Container(
                            width: 70, // Match your listItem width
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(right: 10),
                            child: const CircularProgressIndicator(),
                          );
                        }

                        // Existing note item
                        final note = controller.notes[index];
                        return circleItem(
                          title: note.title,
                          onTap: () => controller.updateNote(note: note),
                          onLongPress: () =>
                              controller.deleteNote(noteId: note.id),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//// Widget to display each note in the list
Widget circleItem({
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
      margin: const EdgeInsets.only(
        right: 10,
      ),
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
