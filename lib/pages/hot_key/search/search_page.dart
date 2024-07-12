import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/common_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:flutter_demo/pages/hot_key/search/search_vm.dart';
import 'package:flutter_demo/route/route_untils.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common_ui/web/webview_page.dart';
import '../../../common_ui/web/webview_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.keyword});

  final String? keyword;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController inputController;

  SearchViewModel viewModel = SearchViewModel();

  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();

    inputController = TextEditingController(text: widget.keyword ?? "");
    refreshOrLoad(false);
  }

  void refreshOrLoad(loadMore) {
    viewModel.search(widget.keyword, loadMore);
    if (loadMore) {
      refreshController.loadComplete();
    } else {
      refreshController.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _searchBar(onBack: () {
                RouteUntils.pop(context);
              }, onCancel: () {
                inputController.text = "";
                viewModel.clear();
                //隐藏软键盘:第二种方法
                FocusScope.of(context).unfocus();

              }, onSubmitted: (value) {
                viewModel.search(value, false);
                //隐藏软键盘:第一种方法
                SystemChannels.textInput.invokeMethod("TextInput.hide");
              }),

              Consumer<SearchViewModel>(
                builder: (context, vm, child) {
                  return Expanded(
                    child: SmartRefreshWidget(
                      controller: refreshController,
                      onRefresh: () {
                        refreshOrLoad(false);
                      },
                      onLoading: () {
                        refreshOrLoad(true);
                      },
                      child: ListView.builder(
                        itemCount: vm.searchList.length,
                        itemBuilder: (context, index) {
                          return _listList(vm.searchList[index].title, () {
                            ///跳转网页
                            RouteUntils.push(context, WebViewPage(
                              loadResource: vm.searchList[index].link ?? "",
                              webViewType: WebViewType.URL,
                              showTitle: true,
                              title: vm.searchList[index].title,));
                          });
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _listList(String? title, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.r, color: Colors.black12))
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Html(data: title ?? "", style: {
          "html": Style(fontSize: FontSize(15.sp)),
        },),
      ),
    );
  }

  Widget _searchBar({GestureTapCallback? onBack, GestureTapCallback? onCancel, ValueChanged<String>? onSubmitted}) {
    return Container(
      color: Colors.teal,
      height: 50.h,
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(width: 5.w,),
          GestureDetector(
            onTap: onBack,
              child: Image.asset("assets/images/icon_back.png", width: 35.r, height: 35.r,)
          ),
          Expanded(child: Container(
            padding: EdgeInsets.all(6.r),
            child: TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              onSubmitted: onSubmitted,
              controller: inputController,
              decoration: InputDecoration(
                  filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(left: 10.w),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(17.5.r)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  )
                ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17.5.r)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      )
                  )
              ),

            ),
          )),
          SizedBox(width: 5.w,),
          GestureDetector(
            onTap: onCancel,
              child: Text("取消", style: TextStyle(fontSize: 13.sp, color: Colors.white),)
          ),
          SizedBox(width: 15.w,),
        ],
      ),
    );
  }
}
