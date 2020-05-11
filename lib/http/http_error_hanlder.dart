import 'package:basic_tools/http/base_resp.dart';
import 'package:basic_tools/plugin/plugin_event_bus.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// @Author: yangxichuan
/// @Date: 2020-04-08 10:46:18
/// @LastEditTime: 2020-04-08 10:46:22
/// @LastEditors: yangxichuan
/// @Description: 网络请求公共处理器

/// 网络请求公共处理器
class HttpErrorHanlder { 
  
  /// 处理 http 请求错误
  static void httpErrorHanlder(BaseResp resp) {

    /// token 失效
    if (resp.status == 500) {

      /// 发送登录过期通知
      eventBus.fire(UserInfoExpired(resp: resp));

      // Global.setIsLogined(false);
      // showDialog(
      //   context: Global.context,
      //   child: CupertinoAlertDialog(
      //     title: Text("您的登录已经失效,是否重新登录"),
      //     actions: <Widget>[
      //       CupertinoDialogAction(child: Text("取消"), onPressed: (){Navigator.pop(Global.context);},),
      //       CupertinoDialogAction(child: Text("重新登录"),onPressed: (){
      //         SharedPreferences.getInstance().then((it){
      //           it.setBool(Constant.keyIsLogined, false);
      //           Global.setIsLogined(false);
      //           Navigator.of(Global.context).pushNamedAndRemoveUntil(r_login_activity, ModalRoute.withName("/"));
      //         });
      //       }),
      //     ],
      //   )
      // );
    }

    else {
      Future.delayed(Duration(milliseconds: 200)).then((it){
        Fluttertoast.showToast(
          msg: resp.message,
          gravity: ToastGravity.CENTER
        );
      });
    }
  }
}