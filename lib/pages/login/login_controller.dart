import 'package:authentication_ptcl/comman/app_srorage.dart';
import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/services/firebase_services.dart';
import 'package:authentication_ptcl/services/firestore_services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  void onTapSignIn() async {
    if (await FirebaseServices.signInWithGoogle()) {
      //await FirestoreServices.addUserToFirestore();
      FirebaseServices.isSigning.value = false;
      Get.offNamed(AppRoutes.dashboard);
      AppStorage().setLoginStatus(true);
    } else {
      debugPrint("Error snackbar.....");
    }
  }
}
