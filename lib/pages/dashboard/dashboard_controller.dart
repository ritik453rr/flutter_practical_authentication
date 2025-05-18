import 'package:get/get.dart';
class DashboardController extends GetxController {
  var currentIndex = 0.obs;
  var pageNames = [
    'Home',
    'Profile',
    'Settings',
  ];
  /// method to change the page index
  void changePage(int index) {
    currentIndex.value = index;
  }
}
