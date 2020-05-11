import 'package:basic_tools/routes.dart';
import 'package:basic_tools/views/custom_app_bar.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      appBar: CustomAppBar(
        title: state.title,
        autoBackBtn: false,
        trailingWidget: IconButton(icon: Icon(Icons.settings), onPressed: () {
          Navigator.pushNamed(viewService.context, r_bt_setting_root);
        }),
      ),
      body: Center(
        child: Text(state.title),
      ),
    );
}
