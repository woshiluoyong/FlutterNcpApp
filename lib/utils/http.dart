import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_application/components/loading_dialog.dart';

class Http{
  Http._internal();

  static final Dio dio = Dio(BaseOptions(
    baseUrl: "https://view.inews.qq.com/",
    connectTimeout: 5000,
    receiveTimeout: 3000
  ));

  static void initHttpDio(BuildContext context){
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions requestOptions){
        print("===============接口请求开始==$requestOptions==>");
        showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
          return new LoadingDialog(content: "加载中...", backgroundColor: Colors.transparent, loadingView: SpinKitFadingCube(color: Colors.lightBlue),);
        });
      },
      onResponse: (Response response){
        Navigator.pop(context); //关闭loading
        print("===============接口请求完成==$response==>");
      },
      onError: (DioError err){
        Navigator.pop(context); //关闭loading
        print("===============接口请求报错==$err==>");
      }
    ));
  }

  static Future get(BuildContext context, String url, [Map<String, dynamic> params]) async{
    initHttpDio(context);
    var response;
    if(null != params){
      response = await dio.get(url, queryParameters: params);
    }else{
      response = await dio.get(url);
    }
    return response.data;
  }

  static Future post(String url, [Map<String, dynamic> params]) async {
    var response = await dio.post(url, queryParameters: params);
    return response.data;
  }

  static Future postJson(String url, [Map<String, dynamic> data]) async {
    var response = await dio.post(url, data: data);
    return response.data;
  }
}