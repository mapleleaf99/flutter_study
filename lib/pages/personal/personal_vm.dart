import 'package:flutter/foundation.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/repository/api.dart';
import 'package:flutter_demo/utils/sp_utils.dart';

class PersonalViewModel extends ChangeNotifier {
  String? username;

  bool shouldLogin = false;

  Future initData() async {
    SpUtils.getString(Constants.K_User_Name).then((value) {
      if (value == null || value == "") {
        username = "未登录";
        shouldLogin = true;
      } else {
        username = value;
        shouldLogin = false;
      }
      notifyListeners();
    });
  }

  ///退出登录
  Future logout(ValueChanged<bool> callback) async {
    bool? success = await Api.instance.logout();
    if (success == true) {
      SpUtils.removeAll();
      callback.call(true);
    } else {
      callback.call(false);
    }
  }
}