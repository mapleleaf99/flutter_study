import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/auth/login_page.dart';
import 'package:flutter_demo/pages/auth/register_page.dart';
import 'package:flutter_demo/pages/home/home_page.dart';
import 'package:flutter_demo/pages/tab_page.dart';
import 'package:flutter_demo/pages/web_view_page.dart';

///路由管理类
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case RoutePath.tab:
          return pageRoute(TabPage(), settings: settings);
      case RoutePath.webViewPage:
        return pageRoute(WebViewPage(title: "首页跳转来的"), settings: settings);
      case RoutePath.loginPage:
        return pageRoute(LoginPage(), settings: settings);
      case RoutePath.resgisterPage:
        return pageRoute(RegisterPage(), settings: settings);
    }

    return pageRoute(
      Scaffold(
        body: SafeArea(
          child: Center(
            child: Text("路由：${settings.name} 不存在"),
          ),
        ),
      )
    );
  }

  static MaterialPageRoute pageRoute(Widget page, {RouteSettings? settings,
        bool? fullScreenDialog,
        bool? maintainState,
        bool? allowSnapshotting,
        bool? barrierDismissible}) {
    return MaterialPageRoute(builder: (context) {
      return page;
    },
      settings: settings,
      fullscreenDialog: fullScreenDialog ?? false,
      allowSnapshotting: allowSnapshotting ?? true,
      maintainState: maintainState ?? true,
      barrierDismissible: barrierDismissible ?? false,
    );
  }
}

//路由地址
class RoutePath {

  //tab
  static const String tab = "/";

  //webView
  static const String webViewPage = "/webViewPage";

  //登录
  static const String loginPage = "/loginPage";
  //注册
  static const String resgisterPage = "/resgisterPage";
}