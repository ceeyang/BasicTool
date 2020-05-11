import 'package:basic_tools/views/custom_app_bar.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SettingState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: CustomAppBar(
      title: 'setting',
    ),
  );
}
