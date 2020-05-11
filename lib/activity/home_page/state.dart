import 'package:fish_redux/fish_redux.dart';

class HomeState implements Cloneable<HomeState> {

  String title = '消安科技 Flutter 基础组件';

  @override
  HomeState clone() {
    return HomeState()
      ..title = title;
  }
}

HomeState initState(Map<String, dynamic> args) {
  return HomeState();
}
