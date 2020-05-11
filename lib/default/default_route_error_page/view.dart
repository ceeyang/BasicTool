import 'package:basic_tools/views/custom_app_bar.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(DefaultRouteErrorState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: CustomAppBar(
      title: '不支持的跳转',
    ),
    body: Center(
      child: RichText(
        text: TextSpan(
          text: '${state.route}\n该路由并未注册到路由中',
          style: TextStyle(color: Colors.red)
        )
      )
    ),
  );
}
