import 'package:flutter/material.dart';
import 'package:flutter_demo/http/dio_instance.dart';
import 'package:flutter_demo/route/route_untils.dart';
import 'package:flutter_demo/route/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  DioInstance.instance().initDio(baseUrl: "https://www.wanandroid.com/");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(child: ScreenUtilInit(
      // designSize: ,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          navigatorKey: RouteUntils.navigatorKey,
          onGenerateRoute: Routes.generateRoute,
          initialRoute: RoutePath.tab,
        );
      },
    ));
  }
}
