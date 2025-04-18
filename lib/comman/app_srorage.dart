import 'package:get_storage/get_storage.dart';

class AppSrorage {
  static final getStorage = GetStorage();
  static const String isLogin = "isLogin";
  static const String user = 'user';

  void setLoginStatus(bool value) {
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
