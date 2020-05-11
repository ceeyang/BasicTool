import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<DefaultListTempState> buildEffect() {
  return combineEffects(<Object, Effect<DefaultListTempState>>{
    DefaultListTempAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DefaultListTempState> ctx) {
}
