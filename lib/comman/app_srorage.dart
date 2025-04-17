import 'package:authentication_ptcl/views/home/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class AppSrorage {
  static final getStorage = GetStorage();
  static const String isLogin = "isLogin";
  static const String user = 'user';

  static setLoginStatus(bool value) {
    getStorage.write(isLogin, value);
  }

  static bool getLoginStatus() {
    return getStorage.read(isLogin) ?? false;
  }

  static setUserData({required Map<String, dynamic> data}) {
    getStorage.write(user, data);
  }

  static Map<String, dynamic> getUser() {
    return getStorage.read(user);
  }

  static clear() {
    getStorage.remove(isLogin);
    getStorage.remove(user);
  }
}
