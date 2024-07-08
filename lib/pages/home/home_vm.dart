
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/datas/home_banner_data.dart';
import 'package:flutter_demo/datas/home_list_data.dart';
import 'package:flutter_demo/http/dio_instance.dart';

class HomeViewModel extends ChangeNotifier {

  List<BannerItemData>? bannerList;

  List<HomeListItemData>? listData;

  ///获取首页banner数据
  Future getBanner() async {
    Response response = await DioInstance.instance().get(path: "banner/json");
    HomeBannerData bannerData = HomeBannerData.fromJson(response.data);
    if (bannerData.data != null) {
      bannerList = bannerData.data;
    } else {
      bannerList = [];
    }

    notifyListeners();
  }

  ///获取首页文章列表
  Future getHomeList() async {
    Response response = await DioInstance.instance().get(path: "article/list/0/json");
    HomeData homeData = HomeData.fromJson(response.data);

    if (homeData.data != null && homeData.data?.datas != null) {
      listData = homeData.data?.datas;
    } else {
      listData = [];
    }

    notifyListeners();
  }
}