# Basic Tools
    消安科技 Flutter 基础组件

## 目录结构

    ├── README.md  /// 项目说明
    ├── android  /// Android 目录
    ├── assets  /// 资源文件夹
    │   └── README.md  /// 展示在 APP 里的项目说明, 同外部 README.md 内容相同
    ├── build  /// flutter 编译产物
    ├── ios  /// iOS 目录
    ├── lib  /// 源代码文件夹
    │   ├── activity  /// BasicTools 基础组件单独运行时的页面
    │   ├── basic_tools_config.dart  /// BasicTools 基础组件暴露给外部的配置文件
    │   ├── config  /// BasicTools 基础组件配置
    │   ├── default  /// 通用类,比如: 默认路由错误页面, 默认 Listview 空白页面
    │   ├── extensions  /// 扩展类文件夹
    │   ├── global_store  /// 全局状态
    │   ├── http  /// 网络请求工具
    │   ├── main.dart  /// 程序主入口
    │   ├── plugin  /// 程序插件
    │   ├── routes.dart  /// 程序路由
    │   ├── views  /// 通用组件
    │   └── vistor.dart  /// fish_redux vistor
    ├── pubspec.lock /// 项目依赖锁
    ├── pubspec.yaml  /// 项目依赖
    └── test  /// TODO: 完成基础组件的单元测试

## 基础组件规范
    - 创建项目时候请设置 iOS 语言为 swift 的方式:  
        flutter create -i swift --org com.xakj.flutter.project your_project_name
    - 文件命名方式: 采用小写与下划线的方式 `just_like_this`
    - 基础组件所有类名使用大驼峰命名法 `HomeActivity`, `ListItemComponent`
    - widget 作为单个简单视图,可以直接用 StatefulWidget 或者 StatelessWidget
    - 页面统一采用 fish_redux 方式
    - 各个项目路由映射不能重复, 请注意

## 

## How to use
1. 创建新程序,此处以 project_one 为例
2. 在新程序的 pubspec.yaml 文件中添加 依赖
    ```shell
    basic_tools
        git: http://192.168.188.30:8099/xiaoan_flutter_app/basic_tools.git
    ```
3. 新项目主程序入口为 BasicToolApp, 类似的 main.dart 代码如下:
    ```dart
    import 'package:basic_tools/basic_tools_config.dart';
    import 'package:basic_tools/main.dart';
    import 'package:flutter/material.dart';
    import 'package:project_one/route.dart';

    /// 当前项目需要初始化的东西
    void projectOneInit() {

      /// 依赖于其他项目的初始化的时候调用
      otherProjectInitInOtherProjects();

      /// 本项目初始化调用
      print('BasicToolApp 初始化的时候会执行这个方法');
    }

    /// 其他项目初始化
    void otherProjectInitInOtherProjects() {

    }

    /// 程序入口
    void main() => runApp(
      BasicToolApp(
        config: BasicToolsConfig(
          /// pages 类型为: List<Map<String, Page<Object, dynamic>>> 
          /// 多个路由,用于集成其他项目时候路由调用[projectOnePage, projectTwoPage]
          pages: [projectOnePage],
          /// 程序根路由
          root: r_project_one_login_root,
          /// 初始化方法
          initState: projectOneInit,
          /// 网络请求地址
          baseUrl: 'https://www.google.com/'
        ),
      )
    );
    ```
4. 新项目的路由页面 routes.dart 代码如下:
    ```dart
    import 'package:fish_redux/fish_redux.dart';
    import 'package:project_one/login_page/page.dart';

    const r_project_one_login_root = 'route_project_one_login_root';

    final Map<String, Page<Object, dynamic>> projectOnePage = {
      r_project_one_login_root: LoginPage()
    };
    ```