import 'package:dio/dio.dart';
import 'package:flutter_demo/repository/datas/auth_data.dart';
import 'package:flutter_demo/repository/datas/common_website_data.dart';
import 'package:flutter_demo/repository/datas/knowledge_detail_list_data.dart';
import 'package:flutter_demo/repository/datas/search_data.dart';
import 'package:flutter_demo/repository/datas/search_hot_key_data.dart';
import '../http/dio_instance.dart';
import 'datas/home_banner_data.dart';
import 'datas/home_list_data.dart';
import 'datas/knowledge_list_data.dart';

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
    Response response = await DioInstance.instance().get(
        path: "article/list/$pageCount/json");
    HomeListData homeData = HomeListData.fromJson(response.data);

    return homeData.datas;
  }

  ///获取首页置顶列表
  Future<List<HomeListItemData>?> getHomeTopList() async {
    Response response = await DioInstance.instance().get(
        path: "article/top/json");
    HomeTopListData listItemData = HomeTopListData.fromJson(response.data);

    return listItemData.topList;
  }

  ///获取常用网站
  Future<List<CommonWebsiteData>?> getWebsiteList() async {
    Response response = await DioInstance.instance().get(path: "friend/json");
    CommonWebsiteListData websiteData = CommonWebsiteListData.fromJson(
        response.data);

    return websiteData.websiteList;
  }

  ///获取搜索热点
  Future<List<SearchHotKeyData>?> getHotKeyList() async {
    Response response = await DioInstance.instance().get(path: "hotkey/json");
    SearchHotKeyListData listData = SearchHotKeyListData.fromJson(
        response.data);

    return listData.keyList;
  }

  ///注册
  Future<dynamic> register(
      {String? name, String? password, String? rePassord}) async {
    Response response = await DioInstance.instance().post(
        path: "user/register", params: {
      "username": name,
      "password": password,
      "repassword": rePassord,
    });
    return response.data;
  }

  ///登录
  Future<AuthData> login({String? name, String? password}) async {
    Response response = await DioInstance.instance().post(
        path: "user/login", params: {
      "username": name,
      "password": password,
    });
    return AuthData.fromJson(response.data);
  }

  ///获取体系数据
  Future<List<KnowledgeListData?>?> getKnowledgeList() async {
    Response response = await DioInstance.instance().get(path: "tree/json");
    KnowledgetData knowledgetData = KnowledgetData.fromJson(response.data);

    return knowledgetData.list;
  }

  ///收藏、取消收藏
  Future<bool?> collect(String id, bool isCollect) async {
    Response response = await DioInstance.instance().post(path: isCollect
        ? "lg/collect/$id/json"
        : "lg/uncollect_originId/$id/json");
    print("收藏： ${response.data}");
    return boolcallback(response.data);
  }

  ///退出登录
  Future<bool?> logout() async {
    Response response = await DioInstance.instance().get(path: "user/logout/json");
    return boolcallback(response.data);
  }

  bool? boolcallback(dynamic data) {
    if (data != null && data is bool) {
      return data;
    }
    return false;
  }

  ///知识体系明细数据
  Future<List<KnowledgeDetailItemData>?> detailKnowledgeList(String cid, String pageCount) async {
    Response response = await DioInstance.instance().get(path: "article/list/$pageCount/json", params: {"cid": cid});
    KnowledgeDetailListData detailData = KnowledgeDetailListData.fromJson(response.data);

    return detailData.datas;
  }

  ///搜索
  Future<List<SearchListData>?> searchList(String pageCount, String keyword) async {
    Response response = await DioInstance.instance().post(path: "article/query/$pageCount/json", params: {"k": keyword});
    SearchData searchData = SearchData.fromJson(response.data);
    return searchData.datas;
  }
}