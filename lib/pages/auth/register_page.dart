import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/auth/auth_vm.dart';
import 'package:flutter_demo/route/route_untils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import '../../common_ui/common_style.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthViewModel viewModel = AuthViewModel();

  @override
  void initState() {
    super.initState();

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
          padding: EdgeInsets.only(left: 20.r, right: 20.r),
          alignment: Alignment.center,
          child: Consumer<AuthViewModel>(
            builder: (context, vm, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  commonInput(labelText: "输入账号", onChanged: (value) {
                    vm.resiterInfo.name = value;
                  }),
                  SizedBox(height: 20.h,),
                  commonInput(labelText: "输入密码", obscureText: true, onChanged: (value) {
                    vm.resiterInfo.password = value;
                  }),
                  SizedBox(height: 20.h,),
                  commonInput(labelText: "再次输入密码", obscureText: true, onChanged: (value) {
                    vm.resiterInfo.repassword = value;
                  }),

                  SizedBox(height: 50.h,),

                  whiteBorderButton(title: "点我注册", onTap: () {
                    vm.register().then((value) {
                      if (value == true) {
                        showToast("注册成功");
                        RouteUntils.pop(context);
                      }
                    });
                  }),

                ],
              );
            },
          ),
        ),
      ),
    );
  }


}
