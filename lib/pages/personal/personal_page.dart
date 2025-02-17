import 'package:flutter/material.dart';
import 'package:flutter_demo/common_ui/dialog/dialog_factory.dart';
import 'package:flutter_demo/pages/about_us_page/about_us_page.dart';
import 'package:flutter_demo/pages/auth/login_page.dart';
import 'package:flutter_demo/pages/my_collects/my_collects_page.dart';
import 'package:flutter_demo/pages/personal/personal_vm.dart';
import 'package:flutter_demo/route/route_untils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  PersonalViewModel viewModel = PersonalViewModel();

  @override
  void initState() {
    super.initState();

    viewModel.initData();
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
              _header(() {
                if (viewModel.shouldLogin) {
                  RouteUntils.push(context, LoginPage());
                }
              }),
              _settingsItem("我的收藏", () {
                RouteUntils.push(context, MyCollectsPage());
              }),
              _settingsItem("检查更新", () {
                DialogFactory.instance.showNeedUpdateDialog(
                    context: context,
                    dismissClick: () {

                    },
                    confirmClick: () {

                    });
              }),
              _settingsItem("关于我们", () {
                RouteUntils.push(context, AboutUsPage());
              }),
              Consumer<PersonalViewModel>(builder: (context, vm, chlid) {
                if (vm.shouldLogin) {
                  return SizedBox();
                } else {
                  return _settingsItem("退出登录", () {
                    viewModel.logout((value) {
                      RouteUntils.pushAndRemoveUntil(context, LoginPage());
                    });
                  });
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingsItem(String? title, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45.h,
        margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5.r),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title ?? "", style: TextStyle(color: Colors.black, fontSize: 13.sp),),
            Image.asset("assets/images/img_arrow_right.png", width: 20.r, height: 20.r,),
          ],
        ),
      ),
    );
  }

  Widget _header(GestureTapCallback? onTap) {
    return Container(
      alignment: Alignment.center,
      color: Colors.teal,
      width: double.infinity,
      height: 200.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              child: Image.asset("assets/images/logo.png", width: 70.r, height: 70.r,),
              borderRadius: BorderRadius.circular(35.r),
            ),
          ),
          SizedBox(height: 6,),
          Consumer<PersonalViewModel>(
            builder: (context, vm, chlid) {
              return GestureDetector(
                  onTap: onTap,
                  child: Text(vm.username ?? "", style: TextStyle(color: Colors.white, fontSize: 13.sp),)
              );
            }
            )
        ],
      ),
    );
  }
}
