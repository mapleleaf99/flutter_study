import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/repository/api.dart';
import 'package:flutter_demo/repository/datas/auth_data.dart';
import 'package:flutter_demo/utils/sp_utils.dart';
import 'package:oktoast/oktoast.dart';

class AuthViewModel with ChangeNotifier {
  ResiterInfo resiterInfo = ResiterInfo();
  LoginInfo loginInfo = LoginInfo();

  ///注册
  Future<bool?> register() async {
    if (resiterInfo.name != null &&
        resiterInfo.password != null &&
        resiterInfo.repassword != null &&
        resiterInfo.repassword == resiterInfo.password) {

      if ((resiterInfo.password?.length ?? 0) >= 6) {
        dynamic callback = await Api.instance.register(
            name: resiterInfo.name,
            password: resiterInfo.password,
            rePassord: resiterInfo.repassword);

        if (callback is bool) {
          return callback;
        }

        return true;
      }
      showToast("密码长度必须大于6位");
      return false;
    }

    showToast("输入不能为空或者密码必须一致");
    return false;
  }

  ///登录
  Future<bool?> login() async {
    if (loginInfo.name != null &&
        loginInfo.password != null) {

      AuthData data = await Api.instance.login(
          name: loginInfo.name,
          password: loginInfo.password,
      );

      if (data.username != null && data.username?.isNotEmpty == true) {
        ///保存用户名
        SpUtils.saveString(Constants.K_User_Name, data.username ?? "");
        return true;
      }

      showToast("登录失败");
      return false;
    }

    showToast("输入不能为空");
    return false;
  }

  void setLoginInfo({String? userName, String? password}) {
    if (userName != null) {
      loginInfo.name = userName;
    }

    if (password != null) {
      loginInfo.password = password;
    }
  }
}

class ResiterInfo {
  String? name;
  String? password;
  String? repassword;
}

class LoginInfo {
  String? name;
  String? password;
}
