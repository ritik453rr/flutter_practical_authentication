import 'package:authentication_ptcl/comman/common_ui.dart';
import 'package:authentication_ptcl/comman/custom_appbart.dart';
import 'package:authentication_ptcl/comman/global.dart';
import 'package:authentication_ptcl/pages/dashboard/home/home_controller.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final refreshController = RefreshController();
  final easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppbar(
          title: "Home",
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: controller.addNote,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Obx(
          () {
            return controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.green,
                  ))
                : Obx(() => controller.notes.isEmpty
                    ? Center(
                        child: CommonUI.text(
                          "No data found",
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      )
                    : SmartRefresher(
                        controller: refreshController,
                        onRefresh: () async {
                          await Future.delayed(const Duration(seconds: 1));
                          await controller.fetchInitialData();
                          refreshController.refreshCompleted();
                        },
                        child: SingleChildScrollView(
                          controller: controller.bodyScrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Text(
                                  "Horizontal list pagination",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Obx(
                                () {
                                  return SizedBox(
                                    height: 80,
                                    child: ListView.builder(
                                      controller: controller.scrollController,
                                      itemCount: controller.notes.length +
                                          (controller.isFetchingMore.value
                                              ? 1
                                              : 0),
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
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child:
                                                const CircularProgressIndicator(
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
                                          onLongPress: () => controller
                                              .deleteNote(noteId: note.id),
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
                                  "Horizontal pages pagination",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Obx(() {
                                return SizedBox(
                                  height: Get.height * 0.45,
                                  child: PageView.builder(
                                      controller: controller.pageController,
                                      itemCount: controller.notes.length +
                                          (controller.isFetchingMore.value
                                              ? 1
                                              : 0),
                                      itemBuilder: (context, index) {
                                        // Show loading indicator at the end
                                        if (index >= controller.notes.length) {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.green,
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              controller.notes[index].title
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              }),
                              const SizedBox(
                                height: 20,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Text(
                                  "Vertical list pagination",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                itemCount: controller.notes.length +
                                    (controller.isFetchingMore.value ? 1 : 0),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                itemBuilder: (context, index) {
                                  // Show loading indicator at the end
                                  if (index >= controller.notes.length) {
                                    return Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(
                                        top: 0,
                                      ),
                                      child: const CircularProgressIndicator(
                                        color: Colors.green,
                                      ),
                                    );
                                  }
                                  return Card(
                                    color: Colors.green,
                                    margin: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: ListTile(
                                      title: CommonUI.text(
                                        controller.notes[index].title,
                                      ),
                                      subtitle: CommonUI.text(
                                        "Subtitle ${index + 1}",
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: Global.bottomPadding + 40,
                              )
                            ],
                          ),
                        ),
                      ));
          },
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
