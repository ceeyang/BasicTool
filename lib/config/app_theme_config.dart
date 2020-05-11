// 主题配置类

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 配置项目中可能用到的主题颜色等内容
/// 默认首先显示的系统样式为 0 位置
List<ThemeData> themes = [
  ThemeData(
    // theme : light 模式
    scaffoldBackgroundColor: Color(0xFFeef1f5),
    accentColor: Color(0xFF8144E5),
    primaryColor: Color(0xFF2599f9),
    primaryColorDark: Colors.white,
    backgroundColor: Colors.white,
    dividerColor: Color(0xFFeaeaea),
    indicatorColor: Color(0xFF8144E5),
    dialogBackgroundColor: Colors.white,
    splashColor: Color(0xFFF4F4F4),
    textSelectionColor: Color(0xFF323232),
    textSelectionHandleColor: Color(0xFF989898),
    brightness: Brightness.light,
    selectedRowColor: Colors.purple,
    unselectedWidgetColor: Colors.black45,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.white,
      splashColor: Color(0xFFF4F4F4),
      disabledColor: Color(0xFFafb0c9),
      highlightColor: Colors.transparent,
      height: 48,
    ),
    textTheme: TextTheme(
      title: TextStyle(
        fontSize: 17,
        color: Color(0xFF323232),
        fontWeight: FontWeight.w600,
      ),
      body1: TextStyle(
        fontSize: 14,
        color: Color(0xFF323232),
        fontWeight: FontWeight.w400,
      ),
      body2: TextStyle(
        fontSize: 14,
        color: Color(0xFF2599f9),
        fontWeight: FontWeight.w400,
      ),
      display1: TextStyle(
        // label标签提示效果,或者提示性文字
        fontSize: 12,
        color: Color(0xFF989898),
        fontWeight: FontWeight.w400,
      ),
      display2: TextStyle(
        // label标签提示效果,或者提示性文字
        fontSize: 14,
        color: Color(0xFF989898),
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        // 按钮样式
        color: Color(0xFFF85D5A),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ), 
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(
        color: Color(0xFF8144E5),
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        color: Color(0xFFB8B9C1),
        fontSize: 12,
      ),
    ),
  ),

  ThemeData(
    // 默认theme 效果(dark模式)

    textSelectionColor: Color(0xFF323232),
    textSelectionHandleColor: Color(0xFF989898),
    selectedRowColor: Colors.purple,
    unselectedWidgetColor: Colors.grey[200],
    scaffoldBackgroundColor: Color(0xFF1d2037),
    accentColor: Color(0xFF8144E5),
    backgroundColor: Color(0xFF272a3f), // A color that contrasts with the [primaryColor], e.g. used as the remaining part of a progress bar.
    primaryColor: Color(0xFF272a3f), // The background color for major parts of the app (toolbars, tab bars, etc)
    primaryColorDark: Color(0xFF272a3f),
    dividerColor: Color(0xFF454860),
    indicatorColor: Color(0xFF8144E5),
    dialogBackgroundColor: Color(0xFF272a3f),
    splashColor: Color(0xFF1d2037), // ripple color
    brightness: Brightness.dark,
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF272a3f),
      splashColor: Color(0xFF1d2037),
      disabledColor: Color(0xFF32364e),
      highlightColor: Colors.transparent,
      height: 48,
    ),
    textTheme: TextTheme(
      title: TextStyle(
        // 标题效果模式值
        fontSize: 17,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      body1: TextStyle(
        // 系统正常使用的颜色值,一般默认的字体颜色值使用效果
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      body2: TextStyle(
        fontSize: 14,
        color: Color(0xFF2599f9),
        fontWeight: FontWeight.w400,
      ),
      display1: TextStyle(
        // label标签提示效果,或者提示性文字
        fontSize: 12,
        color: Color(0xFF666986),
        fontWeight: FontWeight.w400,
      ),
      display2: TextStyle(
        // label标签提示效果,或者提示性文字
        fontSize: 14,
        color: Color(0xFF666986),
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        // 按钮样式
        color: Color(0xFFF85D5A),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
    tabBarTheme: TabBarTheme(
            labelStyle: TextStyle(
              color: Color(0xFF8144E5),
              fontSize: 12,
            ),
            unselectedLabelStyle: TextStyle(
              color: Color(0xFFB8B9C1),
              fontSize: 12,
            ),
    ),
  ),
];
