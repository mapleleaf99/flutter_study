import 'package:flutter/material.dart';
import 'package:flutter_demo/repository/api.dart';
import 'package:flutter_demo/repository/datas/search_data.dart';

class SearchViewModel with ChangeNotifier {

  int _pageCount = 0;

  List<SearchListData> searchList = [];

  Future search(String? keyword, bool loadMore) async {

    if (loadMore) {
      _pageCount ++;
    } else {
      _pageCount = 0;
      searchList.clear();
    }

    var list = await Api.instance.searchList("$_pageCount", keyword ?? "");

    if (list != null) {
      searchList.addAll(list ?? []);
      notifyListeners();
    } else {
      if (loadMore && _pageCount > 0) {
        _pageCount --;
      }
    }
  }

  void clear() {
   searchList.clear();
   notifyListeners();
  }
}