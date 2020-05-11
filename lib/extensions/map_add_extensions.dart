import 'package:fish_redux/fish_redux.dart';

extension MapAddExtension on Map<String, dynamic> {
  /// 合并路由, 用于其他项目
  Map<String, Page<Object, dynamic>> add(List<Map<String, dynamic>> modulPages) {
    modulPages.forEach((modulPage){
      modulPage.forEach((key,value) => this[key] = value);
    });
    return this;
  }
}