import 'package:authentication_ptcl/dialog/adaptive_dialog.dart';
import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/services/firebase_services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{

  // @override
  // void onInit() async{
  //  super.onInit();
  // //  await FirebaseAnalytics.instance
  // // .logScreenView(
  // //   screenName: 'Profile Screen'
  // // );
  // }


   /// Logout
  void logout() {
    AdaptiveDialog.showDialog(
      title: "Logout",
      content: "Are you sure you want to logout?",
      onPressedYes: () async {
        Get.back();
        await FirebaseServices.signOut();
        Get.offNamed(AppRoutes.login);
      },
    );
  }
}