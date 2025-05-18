import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/pages/dashboard/profile/profile_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.analytics);
                },
                child: Text("Analytics")),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.crashlytic);
                },
                child: Text("Crashlytics")),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  controller.logout();
                },
                child: Text("Logout")),
          ],
        ),
      ),
    );
  }
}
