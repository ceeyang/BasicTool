import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DefaultRouteErrorState> buildReducer() {
  return asReducer(
    <Object, Reducer<DefaultRouteErrorState>>{
      DefaultRouteErrorAction.action: _onAction,
    },
  );
}

DefaultRouteErrorState _onAction(DefaultRouteErrorState state, Action action) {
  final DefaultRouteErrorState newState = state.clone();
  return newState;
}
