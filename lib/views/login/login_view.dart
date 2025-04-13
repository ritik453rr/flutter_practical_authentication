import 'package:authentication_ptcl/comman/app_srorage.dart';
import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/services/firebase_services.dart';
import 'package:authentication_ptcl/views/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await FirebaseServices.signInWithGoogle();
            if (AppSrorage.getvalue(AppSrorage.isLogin) ?? false) {
              Get.offNamed(AppRoutes.home);
            } else {
              Get.snackbar(
                "Error",
                "Sign in failed",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
          child: const Text(
            "Sign in with Google",
          ),
        ),
      ),
    );
  }
}
