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
        child: Obx(
          () {
            if (loginController.isSignedIn.value) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome:, ${loginController.user.value?.displayName}"),
                  Text("Email:, ${loginController.user.value?.email}"),
                  Text("Phone, ${loginController.user.value?.phoneNumber}"),
                  Text("Photo, ${loginController.user.value?.photoURL}"),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )
                    ),
                    onPressed: () {
                      loginController.signOut();
                    },
                    child: const Text("Sign Out",style: TextStyle(color: Colors.white),),
                  ),
                ],
              );
            } else {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )
                  ),
                onPressed: () {
                  loginController.signInWithGoogle();
                },
                child: const Text("Sign in with Google",style: TextStyle(color: Colors.white)),
              );
            }
          },
        ),
      ),
    );
  }
}
