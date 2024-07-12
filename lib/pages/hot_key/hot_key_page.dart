import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/hot_key/hot_key_vm.dart';
import 'package:flutter_demo/pages/hot_key/search/search_page.dart';
import 'package:flutter_demo/route/route_untils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../common_ui/web/webview_page.dart';
import '../../common_ui/web/webview_widget.dart';
import '../../repository/datas/common_website_data.dart';
import '../../repository/datas/search_hot_key_data.dart';

class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});

  @override
  State<HotKeyPage> createState() => _HotKeyPageState();
}

///常用网站回调
typedef WebsiteClick = Function(String name, String link);

class _HotKeyPageState extends State<HotKeyPage> {
  HotKeyViewModel viewModel = HotKeyViewModel();

  @override
  void initState() {
    super.initState();

    viewModel.initData();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return viewModel;
    },
    child:  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              children: [
                //标题
                Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 0.5, color: Colors.grey),
                        bottom: BorderSide(width: 0.5, color: Colors.grey),
                      )
                  ),
                  padding: EdgeInsets.only(left: 20.w, right: 20.w,),
                  child: Row(
                    children: [
                      Text("搜索热词", style: TextStyle(fontSize: 14, color: Colors.black),),
                      Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          //进入搜索页面
                          RouteUntils.push(context, SearchPage());
                        },
                          child: Image.asset("assets/images/icon_search.png", width: 30.r, height: 30.r,)
                      )
                    ],
                  ),
                ),
                
                //搜索热词列表
                Consumer<HotKeyViewModel>(builder: (context,vm, child) {
                  return _gridView(false, keyList: vm.keyList, itemTap: (value) {
                    //进入搜索页面
                    RouteUntils.push(context, SearchPage(keyword: value,));
                  });
                }),

                //标题
                Container(
                  height: 45.h,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 0.5, color: Colors.grey),
                        bottom: BorderSide(width: 0.5, color: Colors.grey),
                      )
                  ),
                  margin: EdgeInsets.only(top: 20.h),
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Text("常用网站", style: TextStyle(fontSize: 14, color: Colors.black),),
                ),

                Consumer<HotKeyViewModel>(builder: (context,vm, child) {
                  return _gridView(true, websiteList: vm.websiteList, websiteClick: (name, link) {
                    ///跳转网页
                    RouteUntils.push(context, WebViewPage(
                      loadResource: link,
                      webViewType: WebViewType.URL,
                      showTitle: true,
                      title: name,));
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }

  Widget _gridView(bool? isWebsite, {
    List<CommonWebsiteData>? websiteList,
    List<SearchHotKeyData>? keyList,
    ValueChanged<String>? itemTap,
    WebsiteClick? websiteClick,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //最大横轴范围
          maxCrossAxisExtent: 120.w,
          //主轴的间隔
          mainAxisSpacing: 8.r,
          //宽高比
          childAspectRatio: 3,
          //横轴的间隔
          crossAxisSpacing: 8.r,
        ), itemBuilder: (context, index) {
          if (isWebsite == true) {
            return _item(websiteList?[index].name, itemTap: itemTap, link: websiteList?[index].link);
          } else {
            return _item(keyList?[index].name, itemTap: itemTap);
          }
      },
        itemCount: isWebsite == true ? websiteList?.length ?? 0 : keyList?.length ?? 0,),
    );
  }

  Widget _item(String? name, {String? link, ValueChanged<String>? itemTap, WebsiteClick? websiteClick}) {
    return GestureDetector(
      onTap: () {
        if (link != null) {
          websiteClick?.call(name ?? "", link);
        } else {
          itemTap?.call(name ?? "");
        }
      },
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 0.5.r),
          ),
          child: Text(name ?? "")
      ),
    );
  }
}
