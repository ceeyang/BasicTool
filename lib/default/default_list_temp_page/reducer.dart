import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DefaultListTempState> buildReducer() {
  return asReducer(
    <Object, Reducer<DefaultListTempState>>{
      DefaultListTempAction.action: _onAction,
    },
  );
}

DefaultListTempState _onAction(DefaultListTempState state, Action action) {
  final DefaultListTempState newState = state.clone();
  return newState;
}
