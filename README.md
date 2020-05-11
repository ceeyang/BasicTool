# Basic Tools
    
    消安科技 Flutter 基础组件

# 创建项目时候请设置 iOS 语言为 swift 的方式
    
    flutter create -i swift -a kotlin your_project_name

# 基础组件规范
    
    - 文件命名方式: 采用小写与下划线的方式 `just_like_this`
    - 基础组件所有类名使用大驼峰命名法 `HomeActivity`, `ListItemComponent`
    - widget 作为单个简单视图,可以直接用 StatefulWidget 或者 StatelessWidget
    - 页面统一采用  fish_redux 方式

# How to use

    在 pubspec.yaml 文件中添加 
        basic_tools
            git: https://git.com
    新项目主程序入口为 BasicToolApp
        BasicToolApp(
            page: routes, /// 当前项目路由
            root: r_po_login_root, /// 默认路由
        )