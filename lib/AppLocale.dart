import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

mixin Applocale {
  static const String title = "title";
  static const String thisIs = "thisIs";

  static const Map<String, dynamic> EN = {
    title: "location===EN",
    thisIs: 'This is %a package, version %a.',
  };

  static const Map<String, dynamic> KM = {
    title: "location===KM",
    thisIs: 'នេះគឺជាកញ្ចប់%a កំណែ%a.',
  };

  static const Map<String, dynamic> JA = {
    title: "location===JA",
    thisIs: 'これは%aパッケージ、バージョン%aです。',
  };

  ///文本格式化
  static String getLocalText(BuildContext context, String fullText, {List<dynamic>? args}) {
    return context.formatString(fullText, args ?? []);
  }

  ///切换语言
  static void changeLange(String languageCode) {
    FlutterLocalization.instance.translate(languageCode);
  }
}