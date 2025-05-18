import 'package:authentication_ptcl/pages/crashlytics/crashlytics_controller.dart';
import 'package:get/get.dart';

class CrashlyticsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CrashlyticsController());
  }
  
}