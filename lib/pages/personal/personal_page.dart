import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _settingsItem("我的收藏", () {}),
            _settingsItem("检查更新", () {}),
            _settingsItem("关于我们", () {}),
          ],
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

  Widget _header() {
    return Container(
      alignment: Alignment.center,
      color: Colors.teal,
      width: double.infinity,
      height: 200.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            child: Image.asset("assets/images/logo.png", width: 70.r, height: 70.r,),
            borderRadius: BorderRadius.circular(35.r),
          ),
          SizedBox(height: 6,),
          Text("未登录", style: TextStyle(color: Colors.white, fontSize: 13.sp),)
        ],
      ),
    );
  }
}
