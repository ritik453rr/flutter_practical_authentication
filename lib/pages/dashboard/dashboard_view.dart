import 'package:authentication_ptcl/pages/dashboard/dashboard_controller.dart';
import 'package:authentication_ptcl/pages/dashboard/home/home_view.dart';
import 'package:authentication_ptcl/pages/dashboard/message/message_view.dart';
import 'package:authentication_ptcl/pages/dashboard/profile/profile_view.dart';
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
              selectedItemColor: Colors.green,
              onTap: controller.changePage,
              selectedLabelStyle: const TextStyle(fontSize: 5),
              items: [
                bottomNavBar(icon: Icons.home),
                bottomNavBar(icon: Icons.message),
                bottomNavBar(icon: Icons.person),
              ],
            ),
          )),
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: [HomeView(), MessageView(), ProfileView()],
        ),
      ),
    );
  }
}

/// method to create a bottom navigation bar item
BottomNavigationBarItem bottomNavBar({required IconData icon}) {
  return BottomNavigationBarItem(icon: Icon(icon), label: '');
}
