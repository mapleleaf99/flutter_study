
import 'package:flutter/material.dart';
import 'package:flutter_demo/repository/api.dart';

import '../../repository/datas/common_website_data.dart';
import '../../repository/datas/search_hot_key_data.dart';

class HotKeyViewModel with ChangeNotifier {
  List<CommonWebsiteData>? websiteList;

  List<SearchHotKeyData>? keyList;

  ///获取数据
  Future initData() async {
    getWebsiteList().then((value) {
      getSearchHotKeys().then((value) {
        notifyListeners();
      });
    });
  }

  ///获取常用网站
  Future getWebsiteList() async {
    websiteList = await Api.instance.getWebsiteList();
  }

  ///获取搜索热点
  Future getSearchHotKeys() async {
    keyList = await Api.instance.getHotKeyList();
  }
}