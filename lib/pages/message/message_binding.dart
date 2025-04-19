import 'package:authentication_ptcl/pages/message/message_controller.dart';
import 'package:get/get.dart';

/// MessageBinding class is used to bind MessageController
class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageController());
  }
}