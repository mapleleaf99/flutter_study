import 'package:flutter/material.dart';
import 'package:flutter_demo/common_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:flutter_demo/repository/datas/home_list_data.dart';
import 'package:flutter_demo/pages/home/home_vm.dart';
import 'package:flutter_demo/route/route_untils.dart';
import 'package:flutter_demo/route/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();

  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();

    viewModel.getBanner();
    viewModel.initHomeListData(false);
  }

  void refreshOrLoad(bool loadMore) {
    viewModel.initHomeListData(loadMore, callback: (loadMore) {
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
      body: SafeArea(
        child: SmartRefreshWidget(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _banner(),
                _homeListView(),
              ],
            ),
          ),
          controller: refreshController,
          onLoading: () {
            //上拉加载回调
            refreshOrLoad(true);
          },
          onRefresh: () {
            //下拉加载回调
            viewModel.getBanner().then((value) {
              refreshOrLoad(false);
            });
          },
        ),
      ),
    ),
    );
  }

  Widget _homeListView() {
    print("_homeListView 刷新");
    return Consumer<HomeViewModel>(builder: (context, vm, child) {
      return ListView.builder(itemBuilder: (context, index) {
        return _listItemView(vm.listData?[index]);
      },
        itemCount: vm.listData?.length ?? 0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      );
    });
  }
  //列表
  Widget _listItemView(HomeListItemData? item) {
    var name;
    if (item?.author?.isNotEmpty == true) {
      name = item?.author ?? "";
    } else {
      name = item?.shareUser ?? "";
    }
    return GestureDetector(
      onTap: () {

        RouteUntils.pushForNamed(context, RoutePath.webViewPage, arguments: {
          "name": "使用路由传值"
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 15.h, bottom: 15.h, left: 10.w, right: 10.w),
        margin: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 0.5.r),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.network("https://img1.baidu.com/it/u=3705579380,546574030&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
                    height: 30.r,
                    width: 30.r,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(width: 5.w,),
                Text(name, style: TextStyle(color: Colors.black),),
                Expanded(child: SizedBox()),
                Padding(padding: EdgeInsets.only(right: 5.w),
                  child: Text(item?.niceShareDate ?? "", style: TextStyle(color: Colors.black, fontSize: 12.sp),),
                ),
                (item?.type?.toInt() == 1) ? Text("置顶", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),) : SizedBox()
              ],
            ),
            SizedBox(height: 5.h,),
            Text(item?.title ?? "", style: TextStyle(color: Colors.black, fontSize: 14.sp),),
            SizedBox(height: 5.h,),
            Row(
              children: [
                Text(item?.chapterName ?? "", style: TextStyle(fontSize: 12.sp, color: Colors.green),),
                Expanded(child: SizedBox()),
                Icon(Icons.favorite),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///banner
  Widget _banner() {
    return Consumer<HomeViewModel>(builder: (context, vm, child) {
      print("_banner 刷新");
      return SizedBox(
        height: 150.h,
        width: double.infinity,
        child: Swiper(
          indicatorLayout: PageIndicatorLayout.NONE,
          autoplay: true,
          pagination: const SwiperPagination(),
          control: const SwiperControl(),
          itemCount: vm.bannerList?.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              height: 150.h,
              child: Image.network(vm.bannerList?[index]?.imagePath ?? "", fit: BoxFit.fill,),
            );
          },
        ),
      );
    });
  }
}
