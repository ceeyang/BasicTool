import 'package:basic_tools/basic_tools_config.dart';
import 'package:basic_tools/config/app_status_holder.dart';
import 'package:basic_tools/config/app_theme_config.dart';
import 'package:basic_tools/config/app_constant_value.dart';
import 'package:basic_tools/default/default_route_error_page/state.dart';
import 'package:basic_tools/http/dio_util.dart';
import 'package:basic_tools/plugin/plugin_event_bus.dart';
import 'package:basic_tools/routes.dart';
import 'package:basic_tools/vistor.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'http/dio_util.dart';

/// 程序主入口
void main() => runApp(BasicToolApp());

class BasicToolApp extends StatefulWidget {

  final BasicToolsConfig _config;

  BasicToolApp({
    Key key,
    BasicToolsConfig config
  }) : 
    _config = config ?? BasicToolsConfig.defaultConfig(),
    super(key: key);

  @override
  _BasicToolAppState createState() => _BasicToolAppState();
}

class _BasicToolAppState extends State<BasicToolApp> {

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((it){
      gCurrentThemeIndex = it.getInt(Constant.key_theme_index) ?? 0;
      String token = it.getString(Constant.key_user_token) ?? '';
      DioUtil().configBaseUrlAndToken(widget._config.root, token);
    });

    /// 当通知系统时,刷新一下状态(换肤)
    eventBus.on<SystemThemeSwitch>().listen((it) {
      setState(() {
        /// 修改皮肤
        gCurrentThemeIndex = it.currentThemeIndex;
      });
    });

    /// 执行外部初始化内容
    if (widget._config.initState != null) {
      widget._config.initState();
    }
  }

  @override
  Widget build(BuildContext context) {

    /// 设置 Android 导航栏透明
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    
    /// 合并路由
    mergePages(widget._config.pages);

    /// 路由
    final AbstractRoutes routes = PageRoutes(pages: basicToolPages, visitor: vistor);

    return MaterialApp(
      title: 'Basic Tools',
      debugShowCheckedModeBanner: false,
      home: routes.buildPage(widget._config.root, null),
      theme: themes[gCurrentThemeIndex],
      onGenerateRoute: (RouteSettings settings) {

        return CupertinoPageRoute<Object>(builder: (BuildContext context) {

          /// 路由不存在的时候,默认跳转到错误页面
          if (!basicToolPages.containsKey(settings.name)) {
            return routes.buildPage(r_basic_tools_page_error, {key_error_route: settings.name});
          }
          
          /// 全局设置路由为 CupertinoPageRoute 类型, 并传递参数
          return routes.buildPage(settings.name, settings.arguments);
        });
      },
    );
  }
}
