import 'package:flutter/material.dart';
import 'package:flutter_demo/repository/api.dart';
import 'package:flutter_demo/repository/datas/knowledge_list_data.dart';

import '../../../repository/datas/knowledge_detail_list_data.dart';

class KnowledgeDetailViewModel with ChangeNotifier {

  List<Tab> tabs = [];

  int _pageCount = 0;

  List<KnowledgeDetailItemData> detailList = [];


  void initTabs(List<KnowlegeChildren>? tabList) {
    tabList?.forEach((element) {
      tabs.add(Tab(text: element.name ?? "",));
    });
  }

  Future getDetaiList(String cid, bool loadMore) async {
    if (loadMore) {
      _pageCount ++;
    } else {
      _pageCount = 0;
      detailList.clear();
    }
    var list = await Api.instance.detailKnowledgeList(cid, "$_pageCount");
    if (list?.isNotEmpty == true) {
      detailList.addAll(list ?? []);
      notifyListeners();
    } else {
      if (loadMore && _pageCount > 0) {
        _pageCount --;
      }
    }
  }
}