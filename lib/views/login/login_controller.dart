import 'package:authentication_ptcl/comman/app_srorage.dart';
import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/services/firebase_services.dart';
import 'package:authentication_ptcl/services/firestore_services.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  void onTapSignIn() async {
    await FirebaseServices.signInWithGoogle();
    if (AppSrorage.getLoginStatus()) {
      FirestoreServices().addUserToFirestore();
      Get.offNamed(AppRoutes.dashboard);
    }
  }
}
