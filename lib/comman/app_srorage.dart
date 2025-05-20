import 'package:get_storage/get_storage.dart';

class AppStorage {
  /// Instance of GetStorage
  static final getStorage = GetStorage();

  ///Keys
  static const String isLogin = "isLogin";
  static const String user = 'user';
  static const String uid = "uid";

  void setLoginStatus(bool value) {
    getStorage.write(isLogin, value);
  }

  static bool getLoginStatus() {
    return getStorage.read(isLogin) ?? false;
  }

  static setUid({required String val}) {
    getStorage.write(uid, val);
  }

  static String getUid() {
    return getStorage.read(uid) ?? "";
  }

  // static setUserData({required Map<String, dynamic> data}) {
  //   getStorage.write(user, data);
  // }

  // static Map<String, dynamic> getUser() {
  //   return getStorage.read(user);
  // }

  static clear() {
    getStorage.remove(isLogin);
    getStorage.remove(user);
  }
}
