import 'package:fish_redux/fish_redux.dart';

class DefaultListTempState implements Cloneable<DefaultListTempState> {

  @override
  DefaultListTempState clone() {
    return DefaultListTempState();
  }
}

DefaultListTempState initState(Map<String, dynamic> args) {
  return DefaultListTempState();
}
