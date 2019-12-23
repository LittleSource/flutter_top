import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_top/pages/index_page.dart';

void main() {
  runApp(IndexPage());
  SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      ///这是设置状态栏的图标和字体的颜色
      ///Brightness.light  一般都是显示为白色
      ///Brightness.dark 一般都是显示为黑色
      statusBarIconBrightness: Brightness.dark
  );
  SystemChrome.setSystemUIOverlayStyle(style);
}