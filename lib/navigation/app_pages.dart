import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/pages/analytics/analytics_binding.dart';
import 'package:authentication_ptcl/pages/analytics/analytics_view.dart';
import 'package:authentication_ptcl/pages/crashlytics/crashlytics_binding.dart';
import 'package:authentication_ptcl/pages/crashlytics/crashlytics_view.dart';
import 'package:authentication_ptcl/pages/dashboard/dashboard_binding.dart';
import 'package:authentication_ptcl/pages/dashboard/dashboard_view.dart';
import 'package:authentication_ptcl/pages/dashboard/home/home_binding.dart';
import 'package:authentication_ptcl/pages/dashboard/home/home_view.dart';
import 'package:authentication_ptcl/pages/dashboard/profile/profile_binding.dart';
import 'package:authentication_ptcl/pages/dashboard/profile/profile_view.dart';
import 'package:authentication_ptcl/pages/login/login_binding.dart';
import 'package:authentication_ptcl/pages/login/login_view.dart';
import 'package:authentication_ptcl/pages/dashboard/message/chat/chat_binding.dart';
import 'package:authentication_ptcl/pages/dashboard/message/chat/chat_view.dart';
import 'package:authentication_ptcl/pages/dashboard/message/message_binding.dart';
import 'package:authentication_ptcl/pages/dashboard/message/message_view.dart';
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
          ProfileBinding(),
        ]),
    GetPage(
      name: AppRoutes.home,
      page: () =>  HomeView(),
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
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.analytics,
      page: () => AnalyticsView(),
      binding: AnalyticsBinding(),
    ),
    GetPage(
      name: AppRoutes.crashlytic,
      page: () =>  CrashlyticsView(),
      binding: CrashlyticsBinding(),
    ),
  ];
}
