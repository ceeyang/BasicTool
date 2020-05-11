/// Mr. Yang
/// 2020年05月11日15:18:34
/// 配置文件

class Config {

  /// 请求默认地址
  static String _baseUrl = "http://192.168.188.116:8080";

  static String get baseUrl => _baseUrl;
  void setBaseUrl(String url) => _baseUrl = url;
}

