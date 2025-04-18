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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Text(
                "Notes List horizontal pagination",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Obx(
              () {
                return controller.isLoading.value
                    ? const Expanded(
                        child: Center(child: CircularProgressIndicator()))
                    : controller.notes.isEmpty
                        ? const Expanded(
                            child: Center(
                              child: Text(
                                "No Notes Found",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
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
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(right: 10),
                                    child: const CircularProgressIndicator(
                                      color: Colors.green,
                                      strokeWidth: 2.5,
                                    ),
                                  );
                                }

                                // Existing note item
                                final note = controller.notes[index];
                                return circleItem(
                                  title: note.title,
                                  onTap: () =>
                                      controller.updateNote(note: note),
                                  onLongPress: () =>
                                      controller.deleteNote(noteId: note.id),
                                );
                              },
                            ),
                          );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Text(
                "Notes pages horizontal pagination",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Obx(() => Container(
                  height: Get.height * 0.52,
                  child: PageView.builder(
                      controller: controller.pageController,
                      itemCount: controller.notes.length +
                          (controller.isFetchingMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        // Show loading indicator at the end
                        if (index >= controller.notes.length) {
                          return Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 20, left: 20),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          );
                        }
                        return Container(
                          // height: 100,
                          width: Get.width,
                          margin: const EdgeInsets.only(
                            right: 20,
                            left: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              controller.notes[index].title.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }),
                )),
          ],
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
