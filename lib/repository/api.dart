import 'package:dio/dio.dart';
import 'package:flutter_demo/repository/datas/auth_data.dart';
import 'package:flutter_demo/repository/datas/common_website_data.dart';
import 'package:flutter_demo/repository/datas/search_hot_key_data.dart';
import '../http/dio_instance.dart';
import 'datas/home_banner_data.dart';
import 'datas/home_list_data.dart';

class Api {
  static Api instance = Api._();

  Api._();


  ///获取首页banner数据
  Future<List<HomeBannerData?>?> getBanner() async {
    Response response = await DioInstance.instance().get(path: "banner/json");
    HomeBannerListData bannerData = HomeBannerListData.fromJson(response.data);

    return bannerData.bannerList;
  }

  ///获取首页文章列表
  Future<List<HomeListItemData>?> getHomeList(String pageCount) async {
    Response response = await DioInstance.instance().get(path: "article/list/$pageCount/json");
    HomeListData homeData = HomeListData.fromJson(response.data);

    return homeData.datas;
  }

  ///获取首页置顶列表
  Future<List<HomeListItemData>?> getHomeTopList() async {
    Response response = await DioInstance.instance().get(path: "article/top/json");
    HomeTopListData listItemData = HomeTopListData.fromJson(response.data);

    return listItemData.topList;
  }

  ///获取常用网站
  Future<List<CommonWebsiteData>?> getWebsiteList() async {
    Response response = await DioInstance.instance().get(path: "friend/json");
    CommonWebsiteListData websiteData = CommonWebsiteListData.fromJson(response.data);

    return websiteData.websiteList;
  }

  ///获取搜索热点
  Future<List<SearchHotKeyData>?> getHotKeyList() async {
    Response response = await DioInstance.instance().get(path: "hotkey/json");
    SearchHotKeyListData listData = SearchHotKeyListData.fromJson(response.data);

    return listData.keyList;
  }

  ///注册
  Future<dynamic> register({String? name, String? password, String? rePassord}) async {
    Response response = await DioInstance.instance().post(path: "user/register", params: {
      "username": name,
      "password": password,
      "repassword": rePassord,
    });
    return response.data;
  }

  ///登录
  Future<AuthData> login({String? name, String? password}) async {
    Response response = await DioInstance.instance().post(path: "user/login", params: {
      "username": name,
      "password": password,
    });
    return AuthData.fromJson(response.data);
  }
}