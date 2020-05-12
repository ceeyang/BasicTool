/// 基础组件路由
/// Mr. Yang
/// 2020年05月11日10:06:59
import 'package:basic_tools/activity/home_page/page.dart';
import 'package:basic_tools/activity/setting_page/page.dart';
import 'package:basic_tools/default/default_route_error_page/page.dart';
import 'package:fish_redux/fish_redux.dart';

/// 基础组件路由
/// 基础组件 路由 自定义
/// 以 r_bt_ 作为前缀, 避免重复
const r_basic_tools_home_root = 'route_home_root';
const r_basic_tools_setting_root = 'route_setting_root';
const r_basic_tools_page_error = 'route_page_error';

/// 基础组件路由
Map<String, Page<Object, dynamic>> basicToolPages = {
  r_basic_tools_home_root: HomePage(),
  r_basic_tools_setting_root: SettingPage(),
  r_basic_tools_page_error: DefaultRouteErrorPage(),
};

/// 合并路由, 用于其他项目
void mergePages(List<Map<String, Page<Object, dynamic>>> pages) {
  
  pages.forEach((page) {
    page.forEach((key,value) {
      if (basicToolPages.containsKey(key)) {
        throw UnsupportedError("重复的路由: $key");
      } else {
        basicToolPages[key] = value;
      }
    });
  });
}