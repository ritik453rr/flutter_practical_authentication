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
      body: Obx(
        () => Center(
          child: SizedBox(
            height: 40,
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseServices.signInWithGoogle();
                if (AppSrorage.getLoginStatus()) {
                  Get.offNamed(AppRoutes.dashboard);
                }
              },
              child: FirebaseServices.isLoading.value
                  ? const SizedBox(
                      height: 28,
                      width: 28,
                      child:CircularProgressIndicator(
                        color: Colors.blue,
                        strokeWidth: 3,
                      ),
                    )
                  : const Text(
                      "Sign in with Google",
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
