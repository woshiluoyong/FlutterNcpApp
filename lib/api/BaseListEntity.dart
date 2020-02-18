import 'package:flutter_application/api/EntityFactory.dart';

class BaseListEntity<T> {
  int code;
  String message;
  List<T> data;

  BaseListEntity({this.code, this.message, this.data});

  factory BaseListEntity.fromJson(json) {
    //print("===response===list===>$json");
    List<T> mData = new List<T>();
    if (json['data'] != null) {
      (json['data'] as List).forEach((v) {//遍历data并转换为我们传进来的类型
        mData.add(EntityFactory.generateOBJ<T>(v));
      });
    } // end of if
    return BaseListEntity(code: json["ret"], message: json["msg"], data: mData,);
  }
}