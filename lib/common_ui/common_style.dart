import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///标题文本15号
TextStyle titleTextStyle15 = TextStyle(color: Colors.black, fontSize: 15.sp);

Text normalText(String? text) {
  return Text(text ?? "", style: titleTextStyle15,);
}

///通用输入框
Widget commonInput({String? labelText, ValueChanged<String>? onChanged, TextEditingController? controller, bool? obscureText}) {
  return TextField(
    obscureText: obscureText ?? false,
    onChanged: onChanged,
    controller: controller,
    style: TextStyle(color: Colors.white, fontSize: 14.sp),
    cursorColor: Colors.white,
    decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 0.5.r,
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.r,
            )
        )
    ),
  );
}

///白色边框圆角按钮
Widget whiteBorderButton({required String title, GestureTapCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 45.h,
      margin: EdgeInsets.only(left: 40.w, right: 40.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.5.r),
        border: Border.all(color: Colors.white, width: 1.r),
      ),
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 15.sp),),
    ),
  );
}