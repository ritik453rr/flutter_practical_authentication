import 'package:authentication_ptcl/bottomsheet/add_bottomsheet.dart';
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
          onTapTrailingIcon: controller.onTapLogout,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.onTapAddButton,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
              ///color: Colors.red,
              height: 80,
              child: Stack(
                children: [
                  // Main horizontal list
                  ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.notes.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      final note = controller.notes[index];
                      return Container(
                        height: 70,
                        width: 70,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            note.title[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Loading indicator at the end
                  if (controller.isFetchingMore.value)
                    Positioned(
                        right: 10,
                        child: Container(
                          height: 80,
                          width: 90,
                          //margin: const EdgeInsets.only(right: 10),
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
                        )
                        // Transform.translate(
                        //   offset: const Offset(25, 0),
                        //   child: const SizedBox(
                        //     width: 30,
                        //     height: 30,
                        //     child: CircularProgressIndicator(
                        //       strokeWidth: 3,
                        //       valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        //     ),
                        //   ),
                        // ),
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
