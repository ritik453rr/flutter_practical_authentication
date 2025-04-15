import 'package:authentication_ptcl/comman/app_srorage.dart';
import 'package:authentication_ptcl/navigation/app_pages.dart';
import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          AppSrorage.getLoginStatus() ? AppRoutes.dashboard : AppRoutes.login,
      getPages: AppPages.pages,
    );
  }
}
