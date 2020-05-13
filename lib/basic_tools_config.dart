import 'package:fish_redux/fish_redux.dart';

import 'config/app_config.dart';
import 'routes.dart';

/// 基础工具配置文件
class BasicToolsConfig {
  
  /// 外部传入的路由集合, 多个项目,多个路由
  List<Map<String, Page<Object, dynamic>>> pages = [];

  /// 根路由, 由外部项目决定
  String root = '';

    /// 网络请求地址
  String baseUrl = '';
  
  /// 外部传入的初始化方法, 用于其他项目初始化
  Function initState;

  BasicToolsConfig({
    this.pages,
    this.baseUrl,
    this.root,
    this.initState
  });

  /// 默认配置
  static BasicToolsConfig defaultConfig() {
    return BasicToolsConfig()
      ..pages = []
      ..root = r_basic_tools_home_root
      ..baseUrl = Config.baseUrl
      ..initState = null;
  }
}