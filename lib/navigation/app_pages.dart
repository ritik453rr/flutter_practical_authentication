import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/views/login/login_binding.dart';
import 'package:authentication_ptcl/views/login/login_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
