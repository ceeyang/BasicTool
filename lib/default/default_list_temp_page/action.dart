import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DefaultListTempAction { action }

class DefaultListTempActionCreator {
  static Action onAction() {
    return const Action(DefaultListTempAction.action);
  }
}
