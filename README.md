# Basic Tools
    
    消安科技 Flutter 基础组件

# 创建项目时候请设置 iOS 语言为 swift 的方式
    
    flutter create -i swift -a kotlin your_project_name

# 基础组件规范
    
    - 文件命名方式: 采用小写与下划线的方式 `just_like_this`
    - 基础组件所有类名使用大驼峰命名法 `HomeActivity`, `ListItemComponent`
    - widget 作为单个简单视图,可以直接用 StatefulWidget 或者 StatelessWidget
    - 页面统一采用  fish_redux 方式
    - 各个项目路由映射不能重复, 请注意

# How to use

1. 在 pubspec.yaml 文件中添加 依赖
```shell
basic_tools
    git: https://github.com/ceeyang/BasicTool.git
```
        
2. 新项目主程序入口为 BasicToolApp, 类似的 main.dart 代码如下:
```dart
import 'package:basic_tools/main.dart';
import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:project_one/login_page/page.dart';

/// 路由
const r_project_one_login_root = 'route_project_one_login_root';

/// 当前项目路由
final Map<String, Page<Object, dynamic>> projectOneRoutes = {
  r_project_one_login_root: LoginPage()
};

/// 当前项目需要初始化的东西
void projectOneInit() {

  /// 依赖于其他项目的初始化的时候调用
  otherProjectInit();

  /// 本项目初始化调用
  print('BasicToolApp 初始化的时候会执行这个方法');
}

/// 其他项目初始化,引入其他项目,导入其他项目的初始化方法
void otherProjectInit() {

}


/// 程序入口
void main() => runApp(
  BasicToolApp(
    /// pages 类型为: List<Map<String, Page<Object, dynamic>>> 多个路由,用于集成其他项目时候路由调用
    pages: [projectOneRoutes],
    /// app 根路由
    root: r_project_one_login_root,
    /// app 同步初始化
    initState: projectOneInit,
  )
);

```