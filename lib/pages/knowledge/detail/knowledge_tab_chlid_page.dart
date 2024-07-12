import 'package:flutter/material.dart';
import 'package:flutter_demo/common_ui/common_style.dart';
import 'package:flutter_demo/common_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:flutter_demo/pages/knowledge/detail/knowledge_detail_vm.dart';
import 'package:flutter_demo/route/route_untils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common_ui/web/webview_page.dart';
import '../../../common_ui/web/webview_widget.dart';
import '../../../repository/datas/knowledge_detail_list_data.dart';

class KnowledgeTabChlidPage extends StatefulWidget {
  const KnowledgeTabChlidPage({super.key, required this.cid});

  final String cid;

  @override
  State<KnowledgeTabChlidPage> createState() => _KnowledgeTabChlidPageState();
}

class _KnowledgeTabChlidPageState extends State<KnowledgeTabChlidPage> {
  KnowledgeDetailViewModel viewModel = KnowledgeDetailViewModel();

  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();

    refreshOrLoad(false);
  }

  void refreshOrLoad(bool loadMore) {
    viewModel.getDetaiList(widget.cid, loadMore).then((value) {
      if (loadMore) {
        refreshController.loadComplete();
      } else {
        refreshController.refreshCompleted();
     }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return viewModel;
    },
    child: Scaffold(
      body: Consumer<KnowledgeDetailViewModel>(builder: (context, vm, child) {
        return SmartRefreshWidget(
          controller: refreshController,
          onLoading: () {
            refreshOrLoad(true);
          },
          onRefresh: () {
            refreshOrLoad(false);
          },
          child: ListView.builder(
            itemCount: vm.detailList.length ?? 0,
              itemBuilder: (context, index) {
            return _listItem(vm.detailList[index], onTap: () {
                 ///跳转网页
               RouteUntils.push(context, WebViewPage(
                  loadResource: vm.detailList[index].link ?? "",
                  webViewType: WebViewType.URL,
                  showTitle: true,
                  title: vm.detailList[index].title,));
            });
          }),
        );
        },
      ),
      ),
    );
  }


  Widget _listItem(KnowledgeDetailItemData item, {GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
        padding: EdgeInsets.all(10.r),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 0.5.r),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                normalText(item.superChapterName),
                Text("${item.niceShareDate}"),
              ],
            ),

            Text(item.title ?? "", style: titleTextStyle15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                normalText(item.chapterName),
                Text(item.shareUser ?? ""),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
