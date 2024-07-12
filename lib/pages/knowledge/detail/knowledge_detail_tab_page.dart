import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/knowledge/detail/knowledge_detail_vm.dart';
import 'package:flutter_demo/pages/knowledge/detail/knowledge_tab_chlid_page.dart';
import 'package:provider/provider.dart';

import '../../../repository/datas/knowledge_list_data.dart';

class KnowledgeDetailTabPage extends StatefulWidget {
  final List<KnowlegeChildren>? tabList;

  const KnowledgeDetailTabPage({super.key, this.tabList});

  @override
  State<KnowledgeDetailTabPage> createState() => _KnowledgeDetailTabPageState();
}

class _KnowledgeDetailTabPageState extends State<KnowledgeDetailTabPage> with SingleTickerProviderStateMixin {

  KnowledgeDetailViewModel viewModel = KnowledgeDetailViewModel();

  late TabController tabController;
  
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: widget.tabList?.length ?? 0, vsync: this);
    viewModel.initTabs(widget.tabList);
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: viewModel.tabs,
            controller: tabController,
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            isScrollable: true,

          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: childen(),
            controller: tabController,
          ),
        ),
      ),
    );
  }

  List<Widget> childen() {
    return widget.tabList?.map((element) {
      return KnowledgeTabChlidPage(cid: "${element.id}",);
    }).toList() ?? [];
  }
}
