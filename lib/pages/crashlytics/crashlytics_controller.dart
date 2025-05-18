import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';

class CrashlyticsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fun();
  }

  void fun() async {
    print("Called");
    await FirebaseCrashlytics.instance.setCustomKey('uid', 'Ritik');
  }
}
