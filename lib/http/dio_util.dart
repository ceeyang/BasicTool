import 'dart:convert';
import 'dart:io';

import 'package:basic_tools/http/http_error_hanlder.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


import '../http/base_resp.dart';

/**
 * @Author: thl
 * @GitHub: https://github.com/Sky24n
 * @JianShu: https://www.jianshu.com/u/cbf2ad25d33a
 * @Email: 863764940@qq.com
 * @Description: Dio Util.
 * @Date: 2018/12/19
 */

/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

///Http配置.
class HttpConfig {
  HttpConfig({
    this.data,
    this.options,
    this.pem,
    this.pKCSPath,
    this.pKCSPwd,
  });

  /// BaseResp [T data]字段 key, 默认：data.
  String data;

  /// Options.
  BaseOptions options;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PEM证书内容.
  String pem;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书路径.
  String pKCSPath;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书密码.
  String pKCSPwd;
}

/// 单例 DioUtil.
/// debug模式下可以打印请求日志. DioUtil.openDebug().
/// dio详细使用请查看dio官网(https://github.com/flutterchina/dio).
class DioUtil {
  static final DioUtil _singleton = DioUtil._init();
  static Dio _dio;
  
  /// Options.
  BaseOptions _options = getDefOptions();

  /// PEM证书内容.
  String _pem;

  /// PKCS12 证书路径.
  String _pKCSPath;

  /// PKCS12 证书密码.
  String _pKCSPwd;

  static DioUtil getInstance() {
    return _singleton;
  }

  factory DioUtil() {
    return _singleton;
  }

  DioUtil._init() {
    _dio =  Dio(_options);
    _dio.interceptors.add(
      /// 自定义 Dio 输出日志格式
      InterceptorsWrapper(onRequest: (RequestOptions options) {
        debugPrint("");
        debugPrint("");
        debugPrint("=============================== Request Info ==================================");
        debugPrint("DIO: URL     : ${options.uri.toString()}");
        debugPrint("DIO: METHOD  : ${options.method.toString()}");
        debugPrint("DIO: HEADER  : ${options.headers}");
        debugPrint("DIO: PARAMS  : ${options.data}");


    }, onResponse: (Response response) {
        debugPrint("DIO: CODE    : ${response.statusCode}");
        debugPrint("");
        debugPrint("DIO: DATA    : ${response.data}");
        debugPrint("");
        debugPrint("================================================================================");
        debugPrint("");
        debugPrint("");
    }, onError: (DioError e) {
        debugPrint("DIO: TYPE    : ${e.type}");
        debugPrint("");
        debugPrint("DIO: MESSAGE : ${e.message}");
        debugPrint("");
        debugPrint("================================================================================");
        debugPrint("");
        debugPrint("");

        /// token 失效
        if ("$e".contains("[500]")) {
          HttpErrorHanlder.httpErrorHanlder(BaseResp(status: 500));
        }
    }));


  }

  /// 配置 DioUtil
  void configBaseUrlAndToken(String baseUrl,String token) {
    BaseOptions options = DioUtil.getDefOptions();
    options.baseUrl = baseUrl;
    Map<String, dynamic> headers = new Map();
    headers["X-Access-Token"] = token;
    options.headers = headers;
    HttpConfig config = new HttpConfig(options: options);
    DioUtil().setConfig(config);
  }

/// 更新用户 token
  void setToken(String token) {
    Map<String, dynamic> _headers =  Map();
    _headers["X-Access-Token"] = token;
    _dio.options.headers.addAll(_headers);
  }

  /// set Config.
  void setConfig(HttpConfig config) {
    _mergeOption(config.options);
    _pem = config.pem ?? _pem;
    if (_dio != null) {
      _dio.options = _options;
      if (_pem != null) {
        (_dio.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
            if (cert.pem == _pem) {
              // 证书一致，则放行
              return true;
            }
            return false;
          };
        };
      }
      if (_pKCSPath != null) {
        (_dio.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (client) {
          SecurityContext sc =  SecurityContext();
          //file为证书路径
          sc.setTrustedCertificates(_pKCSPath, password: _pKCSPwd);
          HttpClient httpClient =  HttpClient(context: sc);
          return httpClient;
        };
      }
    }
  }

  Future<BaseResp> get <T>(String url, {data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken}) async { 
    return request(Method.get, url, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
  }

  Future<BaseResp> post <T>(String url, {data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken}) async { 
    return request(Method.post, url, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
  }

  Future<BaseResp> put <T>(String url, {data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken}) async { 
    return request(Method.put, url, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
  }

  Future<BaseResp> delete <T>(String url, {data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken}) async { 
    return request(Method.delete, url, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
  }


  /// Make http request with options.
  /// [method] type: METHOD, The request method.
  /// [path] type: String, The url path.
  /// [data] type: Map<String, dynamic>, The request data, 
  /// [queryParameters] type: Map<String, dynamic>, path params
  /// [options] type: Options, The request options.
  /// <BaseRespR<T> 返回 status code msg data  Response.
  Future<BaseResp> request<T>(String method, String path, {data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken}) async {

    Response response = await _dio.request(path, data: data, queryParameters: queryParameters, options: _checkOptions(method, options), cancelToken: cancelToken).catchError((e){
      print('Catch Error');
      print(e);
    });
    
    if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
      /// 回调模型
      BaseResp resp = BaseResp.fromJson(response.data);

      /// 全局处理返回不正确的情况, 有些情况不用处理,根据业务需求
      if (!resp.success || resp.code != 200) {
        HttpErrorHanlder.httpErrorHanlder(resp);
      }

      return resp;
    }
    
    return Future.error(DioError(
      response: response,
      error: "$response",
      type: DioErrorType.RESPONSE,
    ));
  }

  /// Download the file and save it in local. The default http method is "GET",you can custom it by [Options.method].
  /// [urlPath]: The file url.
  /// [savePath]: The path to save the downloading file later.
  /// [onProgress]: The callback to listen downloading progress.please refer to [OnDownloadProgress].
  Future<Response> download(String urlPath, savePath, {ProgressCallback onProgress, CancelToken cancelToken, data, Options options}) {
    return _dio.download(urlPath, savePath, onReceiveProgress: onProgress, cancelToken: cancelToken, data: data,options: options);
  }

  /// Upload file to the servers.
  /// [method]: [Options.metho], default is Options.PUT
  /// [path]: Upload url;
  Future<BaseResp> upload<T>(String method, String path,{data,Options options,CancelToken cancelToken,Map<String, dynamic> queryParameters}) async {

    /// reponse
    Response response = await _dio.post(path, data: data, options: _checkOptions(method, options), cancelToken: cancelToken, queryParameters: queryParameters);

    if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
      return BaseResp.fromJson(response.data);
    }

    return Future.error(DioError(
      response: response,
      error: "$response",
      type: DioErrorType.RESPONSE,
    ));
  }

  /// decode response data.
  Map<String, dynamic> _decodeData(Response response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return Map();
    }
    return json.decode(response.data.toString());
  }

  /// check Options.
  Options _checkOptions(method, options) {
    Options op;
    if (options == null) {
      op = Options(method: method, responseType: ResponseType.json, contentType: "application/json; charset=utf-8");
    } else {
      op = options;
    }
    return op;
  }

  /// merge Option.
  void _mergeOption(BaseOptions opt) {
    _options.method = opt.method ?? _options.method;
    _options.headers = ( Map.from(_options.headers))..addAll(opt.headers);
    _options.baseUrl = opt.baseUrl ?? _options.baseUrl;
    _options.connectTimeout = opt.connectTimeout ?? _options.connectTimeout;
    _options.receiveTimeout = opt.receiveTimeout ?? _options.receiveTimeout;
    _options.responseType = opt.responseType ?? _options.responseType;
    //_options.data = opt.data ?? _options.data;
    _options.extra = ( Map.from(_options.extra))..addAll(opt.extra);
    _options.contentType = opt.contentType ?? _options.contentType;
    _options.validateStatus = opt.validateStatus ?? _options.validateStatus;
    _options.followRedirects = opt.followRedirects ?? _options.followRedirects;
  }

  /// get dio.
  Dio getDio() => _dio;

  /// create  dio.
  static Dio createDio([BaseOptions options]) {
    options = options ?? getDefOptions();
    Dio dio =  Dio(options);
    return dio;
  }

  /// get Def Options.
  static BaseOptions getDefOptions() {
    BaseOptions options =  BaseOptions();
    options.contentType = "application/json; charset=utf-8";
    options.connectTimeout = 1000 * 30;
    options.receiveTimeout = 1000 * 30;
    return options;
  }

  static String getPath({String path, int page, int pagesize}) {
    StringBuffer sb =  StringBuffer(path);
    if (page != null) {
      sb.write('/$page');
    }
    if (pagesize != null) {
      sb.write('/$pagesize');
    }
    return sb.toString();
  }
}
