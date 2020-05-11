import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DefaultListTempPage extends Page<DefaultListTempState, Map<String, dynamic>> {
  DefaultListTempPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DefaultListTempState>(
                adapter: null,
                slots: <String, Dependent<DefaultListTempState>>{
                }),
            middleware: <Middleware<DefaultListTempState>>[
            ],);

}
