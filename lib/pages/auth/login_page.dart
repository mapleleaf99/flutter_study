import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/auth/register_page.dart';
import 'package:flutter_demo/pages/tab_page.dart';
import 'package:flutter_demo/route/route_untils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import '../../common_ui/common_style.dart';
import 'auth_vm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController? userInputController;
  TextEditingController? passwordInputController;

  AuthViewModel viewModel = AuthViewModel();

  @override
  void initState() {
    super.initState();

    userInputController = TextEditingController();
    passwordInputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          alignment: Alignment.center,
          child: Consumer<AuthViewModel>(
            builder: (context, vm, chlid) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  commonInput(labelText: "输入账号", controller: userInputController),

                  SizedBox(height: 20.h,),

                  commonInput(labelText: "输入密码", obscureText: true, controller: passwordInputController),

                  SizedBox(height: 50.h,),

                  whiteBorderButton(title: "开始登录", onTap: () {
                    print("userName: ${userInputController?.text}, password: ${passwordInputController?.text}");
                    viewModel.setLoginInfo(userName: userInputController?.text, password: passwordInputController?.text);

                    viewModel.login().then((value) {
                      if (value == true) {
                        showToast("登录成功");
                        RouteUntils.pushAndRemoveUntil(context, TabPage());
                      }
                    });
                  }),

                  SizedBox(height: 5.h,),

                  registerButton(() {
                    RouteUntils.push(context, RegisterPage());
                  }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget registerButton(GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 100.w,
        height: 45.h,
        child: Text("注册", style: TextStyle(color: Colors.white, fontSize: 13.sp),),
      ),
    );
  }
}
