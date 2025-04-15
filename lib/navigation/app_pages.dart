import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/views/dashboard/dashboard_binding.dart';
import 'package:authentication_ptcl/views/dashboard/dashboard_view.dart';
import 'package:authentication_ptcl/views/home/home_binding.dart';
import 'package:authentication_ptcl/views/home/home_view.dart';
import 'package:authentication_ptcl/views/login/login_binding.dart';
import 'package:authentication_ptcl/views/login/login_view.dart';
import 'package:authentication_ptcl/views/message/chat/chat_binding.dart';
import 'package:authentication_ptcl/views/message/chat/chat_view.dart';
import 'package:authentication_ptcl/views/message/message_binding.dart';
import 'package:authentication_ptcl/views/message/message_view.dart';
import 'package:get/get.dart';
class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
        name: AppRoutes.dashboard,
        page: () => const DashboardView(),
        bindings: [
          DashboardBinding(),
          HomeBinding(),
          ChatBinding(),
        ]),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.messages,
      page: () => const MessageView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: AppRoutes.chats,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
  ];
}
