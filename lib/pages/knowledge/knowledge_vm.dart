import 'package:flutter/material.dart';
import 'package:flutter_demo/repository/api.dart';
import 'package:flutter_demo/repository/datas/knowledge_list_data.dart';

class KnowledgeViewModel with ChangeNotifier {
  List<KnowledgeListData?>? list;

  Future getKnowledgeList() async {
    list = await Api.instance.getKnowledgeList();
    notifyListeners();
  }

  String generalSubtitle(List<KnowlegeChildren?>? chlidren) {
    if (chlidren == null || chlidren?.isEmpty == true) {
      return "";
    }
    
    StringBuffer stringBuffer = StringBuffer("");
    
    for (var element in chlidren) {
      stringBuffer.write("${element?.name} ");
    }

    return stringBuffer.toString();
  }
}