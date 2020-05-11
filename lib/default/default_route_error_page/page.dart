import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DefaultRouteErrorPage extends Page<DefaultRouteErrorState, Map<String, dynamic>> {
  DefaultRouteErrorPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DefaultRouteErrorState>(
                adapter: null,
                slots: <String, Dependent<DefaultRouteErrorState>>{
                }),
            middleware: <Middleware<DefaultRouteErrorState>>[
            ],);

}
