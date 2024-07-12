import 'package:flutter/material.dart';
import 'package:flutter_demo/common_ui/web/webview_page.dart';
import 'package:flutter_demo/common_ui/web/webview_widget.dart';
import 'package:flutter_demo/pages/auth/login_page.dart';
import 'package:flutter_demo/pages/auth/register_page.dart';
import 'package:flutter_demo/pages/hot_key/search/search_page.dart';
import 'package:flutter_demo/pages/knowledge/detail/knowledge_detail_tab_page.dart';
import 'package:flutter_demo/pages/my_collects/my_collects_page.dart';
import 'package:flutter_demo/pages/tab_page.dart';

import '../pages/about_us_page/about_us_page.dart';

///路由管理类
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case RoutePath.tab:
          return pageRoute(TabPage(), settings: settings);
      case RoutePath.webviewPage:
        return pageRoute(WebViewPage(loadResource: "", webViewType: WebViewType.URL,), settings: settings);
      case RoutePath.loginPage:
        return pageRoute(LoginPage(), settings: settings);
      case RoutePath.resgisterPage:
        return pageRoute(RegisterPage(), settings: settings);
      case RoutePath.detailKnowledgePage:
        return pageRoute(KnowledgeDetailTabPage(), settings: settings);
      case RoutePath.searchPage:
        return pageRoute(SearchPage(), settings: settings);
      case RoutePath.myCollectsPage:
        return pageRoute(MyCollectsPage(), settings: settings);
      case RoutePath.aboutUsPage:
        return pageRoute(AboutUsPage(), settings: settings);
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
  static const String webviewPage = "/webview_page";

  //登录
  static const String loginPage = "/login_page";
  //注册
  static const String resgisterPage = "/resgister_page";

  //知识体系明细
  static const String detailKnowledgePage = "/detail_knowledge_page";

  //搜索
  static const String searchPage = "/search_page";

  //收藏
  static const String myCollectsPage = "/my_collects_page";

  //关于我们
  static const String aboutUsPage = "/about_us_page";


}