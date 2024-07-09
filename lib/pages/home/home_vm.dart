import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/repository/api.dart';
import 'package:flutter_demo/repository/datas/home_banner_data.dart';
import 'package:flutter_demo/repository/datas/home_list_data.dart';

class HomeViewModel extends ChangeNotifier {
  int pageCount = 0;

  List<HomeBannerData?>? bannerList;

  List<HomeListItemData>? listData = [];

  ///获取首页banner数据
  Future getBanner() async {
    List<HomeBannerData?>? list = await Api.instance.getBanner();
    bannerList = list ?? [];

    notifyListeners();
  }

  Future initHomeListData(bool loadMore, {ValueChanged<bool>? callback}) async {
    if (loadMore) {
      pageCount++;
    } else {
      pageCount = 1;
      listData?.clear();
    }

    //先获取置顶数据
    getHomeTopList(loadMore).then((value) {
      if (!loadMore) {
        listData?.addAll(value ?? []);
      }

      //在获取首页列表
      getHomeList(loadMore).then((value) {
        listData?.addAll(value ?? []);
        //刷新
        notifyListeners();

        callback?.call(loadMore);
      });
    });
  }

  ///获取首页文章列表
  Future<List<HomeListItemData>?> getHomeList(bool loadMore) async {

    List<HomeListItemData>? list = await Api.instance.getHomeList("$pageCount");

    if (list != null && list.isNotEmpty) {
      return list;
    } else {
      if (loadMore && pageCount > 0) {
        pageCount--;
      }
      return [];
    }
  }

  ///获取首页置顶数据
  Future<List<HomeListItemData>?> getHomeTopList(bool loadMore) async {
    if (loadMore) {
      return [];
    }
    List<HomeListItemData>? list = await Api.instance.getHomeTopList();
    return list;
  }
}