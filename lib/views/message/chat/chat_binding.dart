import 'package:get/get.dart';
import 'chat_controller.dart';

/// A binding class that manages the dependencies for the ChatView.
class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}
