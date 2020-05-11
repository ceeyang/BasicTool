import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DefaultRouteErrorAction { action }

class DefaultRouteErrorActionCreator {
  static Action onAction() {
    return const Action(DefaultRouteErrorAction.action);
  }
}
