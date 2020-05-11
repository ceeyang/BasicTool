 /// @Author: yangxichuan
 /// @Date: 2020-04-02 18:17:44
 /// @LastEditTime: 2020-04-07 16:59:09
 /// @LastEditors: yangxichuan
 /// @Description: HTTP 请求回调外层

/// HTTP 请求回调外层, 适用于此项目
/// 所有请求外层主体都是如此, 不同内容在 result 里面
class BaseResp {

  /// 成功后返回的字段
  bool success;
  int code;
  Map<String, dynamic> result;
  
  /// 失败后返回的字段
  int status;
  String error;

  /// 公共字段
  String message;
  int timestamp;

  BaseResp({this.success, this.message, this.code, this.result, this.timestamp, this.status, this.error});

  BaseResp.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    result = json['result'];
    timestamp = json['timestamp'];

    status = json['status'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['code'] = this.code;
    data['result'] = this.result;
    data['timestamp'] = this.timestamp;

    data['status'] = this.status;
    data['error'] = this.error;

    return data;
  }
}