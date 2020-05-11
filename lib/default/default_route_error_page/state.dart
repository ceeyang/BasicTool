import 'package:fish_redux/fish_redux.dart';

const key_error_route = 'route_error_route_key';

class DefaultRouteErrorState implements Cloneable<DefaultRouteErrorState> {

  String route = '';  

  @override
  DefaultRouteErrorState clone() {
    return DefaultRouteErrorState()
      ..route = route;
  }
}

DefaultRouteErrorState initState(Map<String, dynamic> args) {
  return DefaultRouteErrorState()
    ..route = args[key_error_route] ?? '';
}
