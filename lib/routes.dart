/// 基础组件路由
/// Mr. Yang
/// 2020年05月11日10:06:59
import 'package:basic_tools/activity/home_page/page.dart';
import 'package:fish_redux/fish_redux.dart';

/// 基础组件路由
/// 基础组件 路由 自定义
/// 以 r_bt_ 作为前缀, 避免重复
const r_bt_home_root = 'route_home_root';
const r_bt_setting_root = 'route_setting_root';

/// 基础组件路由
Map<String, Page<Object, dynamic>> basicToolPages = {
  r_bt_home_root: HomePage(),
};

/// 合并路由, 用于其他项目
void insertPages(Map<String, Page<Object, dynamic>> pages) {
  pages.forEach((key,item) => basicToolPages[key] = item);
}