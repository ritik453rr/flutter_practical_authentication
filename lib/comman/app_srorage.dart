import 'package:get_storage/get_storage.dart';

class AppSrorage {
  var getStorage = GetStorage();
  static const String isLogin = "isLogin";
  
  static setvalue(String key, dynamic value) {
    GetStorage().write(key, value);
  }
  
  static getvalue(String key) {
    return GetStorage().read(key);
  }

}

