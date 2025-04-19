import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/pages/dashboard/dashboard_binding.dart';
import 'package:authentication_ptcl/pages/dashboard/dashboard_view.dart';
import 'package:authentication_ptcl/pages/home/home_binding.dart';
import 'package:authentication_ptcl/pages/home/home_view.dart';
import 'package:authentication_ptcl/pages/login/login_binding.dart';
import 'package:authentication_ptcl/pages/login/login_view.dart';
import 'package:authentication_ptcl/pages/message/chat/chat_binding.dart';
import 'package:authentication_ptcl/pages/message/chat/chat_view.dart';
import 'package:authentication_ptcl/pages/message/message_binding.dart';
import 'package:authentication_ptcl/pages/message/message_view.dart';
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
