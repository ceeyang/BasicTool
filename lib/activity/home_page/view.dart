import 'package:basic_tools/routes.dart';
import 'package:basic_tools/views/custom_app_bar.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      appBar: CustomAppBar(
        title: state.title,
        autoBackBtn: false,
        trailingWidget: IconButton(icon: Icon(Icons.settings), onPressed: () {
          Navigator.pushNamed(viewService.context, r_basic_tools_setting_root);
        }),
      ),
      body: Container(
      child: FutureBuilder(
        future: rootBundle.loadString('assets/README.md'),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return Markdown(data: snapshot.data);
          }else{
            return Center(
              child: Text("加载中..."),
            );
          }
        },
      ),
    )
  );
}
