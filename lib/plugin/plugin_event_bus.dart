//事件class ,event-bus

import 'package:basic_tools/http/base_resp.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

///创建事件(异步)
EventBus eventBus = EventBus();

/// 1. 系统主题切换
class SystemThemeSwitch {
  /// 当前系统的 ui 颜色值(测试使用)
  int currentThemeIndex;

  SystemThemeSwitch({
    @required this.currentThemeIndex,
  }) : assert(currentThemeIndex != null);
}

/// 用户信息过期回调, 用于集成其他项目后,发送通知
class UserInfoExpired {
  
  /// 请求回调
  BaseResp resp;

  UserInfoExpired({
    @required this.resp,
  }) : assert(resp != null);
}