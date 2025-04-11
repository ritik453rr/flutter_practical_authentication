import 'package:authentication_ptcl/comman/app_srorage.dart';
import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/services/firebase_services.dart';
import 'package:authentication_ptcl/views/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          onPressed: () async {
            await FirebaseServices.signInWithGoogle();
            if (AppSrorage.getvalue(AppSrorage.isLogin)?? false) {
              Get.offAllNamed(AppRoutes.home);
            } else {
              Get.snackbar("Error", "Sign in failed",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white);
            }
          },
          child: const Text("Sign in with Google",
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
