import 'package:get_storage/get_storage.dart';

class AppSrorage {
  static final getStorage = GetStorage();
  static const String isLogin = "isLogin";
  static const String uid = 'uid';

  static setLoginStatus(bool value) {
    getStorage.write(isLogin, value);
  }

  static bool getLoginStatus() {
    return getStorage.read(isLogin) ?? false;
  }

  static setUid(String value) {
    getStorage.write(uid, value);
  }

  static String getUId() {
    return getStorage.read(uid) ?? "";
  }
}
