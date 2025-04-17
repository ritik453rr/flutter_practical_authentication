import 'package:authentication_ptcl/views/dashboard/dashboard_controller.dart';
import 'package:authentication_ptcl/views/home/home_view.dart';
import 'package:authentication_ptcl/views/message/chat/chat_view.dart';
import 'package:authentication_ptcl/views/message/message_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              backgroundColor: Colors.white,
              onTap: controller.changePage,
              selectedLabelStyle: const TextStyle(fontSize: 5),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '',
                ),
              ],
            ),
          )),
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            HomeView(),
            MessageView(),
            Center(child: Text("Profile")),
          ],
        ),
      ),
    );
  }
}
