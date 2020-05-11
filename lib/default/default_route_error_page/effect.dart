import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<DefaultRouteErrorState> buildEffect() {
  return combineEffects(<Object, Effect<DefaultRouteErrorState>>{
    DefaultRouteErrorAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DefaultRouteErrorState> ctx) {
}
