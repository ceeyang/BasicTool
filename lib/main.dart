import 'package:basic_tools/config/app_status_holder.dart';
import 'package:basic_tools/config/app_theme_config.dart';
import 'package:basic_tools/config/app_constant_value.dart';
import 'package:basic_tools/default/default_route_error_page/state.dart';
import 'package:basic_tools/extensions/map_add_extensions.dart';
import 'package:basic_tools/global_store/state.dart';
import 'package:basic_tools/global_store/store.dart';
import 'package:basic_tools/activity/home_page/page.dart';
import 'package:basic_tools/plugin/plugin_event_bus.dart';
import 'package:basic_tools/routes.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

/// 程序主入口
void main() => runApp(BasicToolApp());

class BasicToolApp extends StatefulWidget {

  /// 外部传入的路由集合, 多个项目,多个路由
  final List<Map<String, Page<Object, dynamic>>> _pages;
  
  /// 根路由, 由外部项目决定
  final String _root;
  
  /// 外部传入的初始化方法, 用于其他项目初始化
  final Function _initState;

  BasicToolApp({
    Key key,
    List<Map<String, Page<Object, dynamic>>> pages,
    String root,
    Function initState
  }) : 
    _pages = pages ?? [],
    _root = root ?? r_bt_home_root,
    _initState = initState ?? null,
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
    });

    /// 当通知系统时,刷新一下状态(换肤)
    eventBus.on<SystemThemeSwitch>().listen((it) {
      setState(() {
        /// 修改皮肤
        gCurrentThemeIndex = it.currentThemeIndex;
      });
    });

    /// 执行外部初始化内容
    if (widget._initState != null) {
      widget._initState();
    }
  }

  @override
  Widget build(BuildContext context) {

    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    
    /// 合并路由
    insertPages(widget._pages);

    /// 采用 fish_redux 后, 程序采用 AbstractRoutes 类型的 route 作为 home 入口, 原有 gActivityRoutes 路由不可用,
    /// fish_redux 类型页面, 集成到 reduxPages 里面, 导航代码: Navigator.pushNamed(r_page_name);
    /// 页面跳转出现 The builder for route "null" returned null.请参照上面两条内容进行修改方式
    //final AbstractRoutes routes = PageRoutes(pages: reduxPages, visitor: vistor);
    final AbstractRoutes routes = PageRoutes(pages: basicToolPages, visitor: vistor);

    return MaterialApp(
      title: 'Basic Tools',
      debugShowCheckedModeBanner: false,
      home: routes.buildPage(widget._root, null),
      theme: themes[gCurrentThemeIndex],
      onGenerateRoute: (RouteSettings settings) {

        return CupertinoPageRoute<Object>(builder: (BuildContext context) {

          /// 路由不存在的时候,默认跳转到错误页面
          if (!basicToolPages.containsKey(settings.name)) {
            return routes.buildPage(r_bt_page_error, {key_error_route: settings.name});
          }
          
          /// 全局设置路由为 CupertinoPageRoute 类型, 并传递参数
          return routes.buildPage(settings.name, settings.arguments);
        });
      },
    );
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    /// 采用 fish_redux 后, 程序采用 AbstractRoutes 类型的 route 作为 home 入口, 原有 gActivityRoutes 路由不可用,
    /// fish_redux 类型页面, 集成到 reduxPages 里面, 导航代码: Navigator.pushNamed(r_page_name);
    /// 页面跳转出现 The builder for route "null" returned null.请参照上面两条内容进行修改方式
    //final AbstractRoutes routes = PageRoutes(pages: reduxPages, visitor: vistor);
    final AbstractRoutes routes = PageRoutes(pages: basicToolPages, visitor: vistor);

    return MaterialApp(
      title: 'Basic Tools',
      debugShowCheckedModeBanner: false,
      home: routes.buildPage(HomePage().toString(), null),
      onGenerateRoute: (RouteSettings settings) {
        return CupertinoPageRoute<Object>(builder: (BuildContext context) {
          return routes.buildPage(settings.name, settings.arguments);
        });
      },
    );
  }
}

void vistor(String path, Page<Object, dynamic> page) {

  /// 只有特定的范围的 Page 才需要建立和 AppStore 的连接关系
  /// 满足 Page<T> ，T 是 GlobalBaseState 的子类
  if (page.isTypeof<GlobalBaseState>()) {
  
    /// 建立 AppStore 驱动 PageStore 的单向数据连接
    /// 1. 参数1 AppStore
    /// 2. 参数2 当 AppStore.state 变化时, PageStore.state 该如何变化
    page.connectExtraStore<GlobalState>(GlobalStore.store,(Object pagestate, GlobalState appState) {
      
      final GlobalBaseState p = pagestate;
      
      if (p.themeColor != appState.themeColor) {
        if (pagestate is Cloneable) {
          final Object copy = pagestate.clone();
          final GlobalBaseState newState = copy;
          newState.themeColor = appState.themeColor;
          return newState;
        }
      }
      
      return pagestate;
    });
  }

  /// AOP
  /// 页面可以有一些私有的 AOP 的增强， 但往往会有一些 AOP 是整个应用下，所有页面都会有的。
  /// 这些公共的通用 AOP ，通过遍历路由页面的形式统一加入。
  page.enhancer.append(
    /// View AOP
    viewMiddleware: <ViewMiddleware<dynamic>>[
      safetyView<dynamic>(),
    ],

    /// Adapter AOP
    adapterMiddleware: <AdapterMiddleware<dynamic>>[
      safetyAdapter<dynamic>()
    ],

    /// Effect AOP
    effectMiddleware: <EffectMiddleware<dynamic>>[
      _pageAnalyticsMiddleware<dynamic>(),
    ],

    /// Store AOP
    middleware: <Middleware<dynamic>>[
      logMiddleware<dynamic>(tag: page.runtimeType.toString()),
    ],
  );
}

/// 简单的 Effect AOP
/// 只针对页面的生命周期进行打印
EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'redux'}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          print('${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}