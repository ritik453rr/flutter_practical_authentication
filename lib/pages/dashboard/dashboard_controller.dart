import 'package:authentication_ptcl/comman/app_srorage.dart';
import 'package:authentication_ptcl/services/firestore_services.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentIndex = 0.obs;
  var pageNames = [
    'Home',
    'Profile',
    'Settings',
  ];

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  /// method to change the page index
  void changePage(int index) {
    currentIndex.value = index;
  }
}
