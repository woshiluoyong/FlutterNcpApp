import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/api/BaseEntity.dart';
import 'package:flutter_application/api/BaseListEntity.dart';
import 'package:flutter_application/api/ErrorEntity.dart';
import 'package:flutter_application/api/NWApi.dart';
import 'package:flutter_application/api/NWMethod.dart';
import 'package:flutter_application/components/loading_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DioManager {
  static final DioManager _shared = DioManager._internal();
  factory DioManager() => _shared;
  Dio dio;
  DioManager._internal() {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: NWApi.baseApi,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: false,
        connectTimeout: 30000,
        receiveTimeout: 3000,
      );
      dio = Dio(options);
    }
  }

  DioManager initBindHttpDio(BuildContext context, bool isLoading){
    if(null == dio)return this;
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions requestOptions){
          print("=======$isLoading========接口请求开始==>${requestOptions.uri}");
          if(isLoading)showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
            return new LoadingDialog(content: "加载中...", backgroundColor: Colors.transparent, loadingView: SpinKitFadingCube(color: Colors.lightBlue),);
          });
        },
        onResponse: (Response response){
          if(isLoading)Navigator.pop(context); //关闭loading
          print("=======$isLoading========接口请求完成==$response==>");
        },
        onError: (DioError err){
          if(isLoading)Navigator.pop(context); //关闭loading
          print("=======$isLoading========接口请求报错==$err==>");
        }
    ));
    return this;
  }

  // 请求，返回参数为 T
  // method：请求方法，NWMethod.POST等
  // path：请求地址
  // params：请求参数
  // success：请求成功回调
  // error：请求失败回调
  Future request<T>(NWMethod method, String path, {Map<String, dynamic> params, Function(T) success, Function(ErrorEntity) error}) async {
    try {
      Response response = await dio.request(path, queryParameters: params, options: Options(method: NWMethodValues[method]));
      if (response != null) {
        BaseEntity entity = BaseEntity<T>.fromJson(response.data);
        if (entity.code == 0) {
          success(entity.data);
        } else {
          error(ErrorEntity(code: entity.code, message: entity.message));
        }
      } else {
        error(ErrorEntity(code: -1, message: "未知错误"));
      }
    } on DioError catch(e) {
      error(createErrorEntity(e));
    }
  }

  // 请求，返回参数为 List<T>
  // method：请求方法，NWMethod.POST等
  // path：请求地址
  // params：请求参数
  // success：请求成功回调
  // error：请求失败回调
  Future requestList<T>(NWMethod method, String path, {Map<String, dynamic> params, Function(List<T>) success, Function(ErrorEntity) error}) async {
    try {
      Response response = await dio.request(path, queryParameters: params, options: Options(method: NWMethodValues[method]));
      if (response != null) {
        BaseListEntity entity = BaseListEntity<T>.fromJson(response.data);
        if (entity.code == 0) {
          success(entity.data);
        } else {
          error(ErrorEntity(code: entity.code, message: entity.message));
        }
      } else {
        error(ErrorEntity(code: -1, message: "未知错误"));
      }
    } on DioError catch(e) {
      error(createErrorEntity(e));
    }
  }

  // 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:{
        return ErrorEntity(code: -1, message: "请求取消");
      }
      break;
      case DioErrorType.CONNECT_TIMEOUT:{
        return ErrorEntity(code: -1, message: "连接超时");
      }
      break;
      case DioErrorType.SEND_TIMEOUT:{
        return ErrorEntity(code: -1, message: "请求超时");
      }
      break;
      case DioErrorType.RECEIVE_TIMEOUT:{
        return ErrorEntity(code: -1, message: "响应超时");
      }
      break;
      case DioErrorType.RESPONSE:{
        try {
          int errCode = error.response.statusCode;
          String errMsg = error.response.statusMessage;
          return ErrorEntity(code: errCode, message: errMsg);
//          switch (errCode) {
//            case 400: {
//              return ErrorEntity(code: errCode, message: "请求语法错误");
//            }
//            break;
//            case 403: {
//              return ErrorEntity(code: errCode, message: "服务器拒绝执行");
//            }
//            break;
//            case 404: {
//              return ErrorEntity(code: errCode, message: "无法连接服务器");
//            }
//            break;
//            case 405: {
//              return ErrorEntity(code: errCode, message: "请求方法被禁止");
//            }
//            break;
//            case 500: {
//              return ErrorEntity(code: errCode, message: "服务器内部错误");
//            }
//            break;
//            case 502: {
//              return ErrorEntity(code: errCode, message: "无效的请求");
//            }
//            break;
//            case 503: {
//              return ErrorEntity(code: errCode, message: "服务器挂了");
//            }
//            break;
//            case 505: {
//              return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
//            }
//            break;
//            default: {
//              return ErrorEntity(code: errCode, message: "未知错误");
//            }
//          }
        } on Exception catch(_) {
          return ErrorEntity(code: -1, message: "未知错误");
        }
      }
      break;
      default: {
        return ErrorEntity(code: -1, message: error.message);
      }
    }
  }
}