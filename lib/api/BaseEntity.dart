import 'package:flutter_application/api/EntityFactory.dart';

class BaseEntity<T> {
  int code;
  String message;
  T data;

  BaseEntity({this.code, this.message, this.data});

  factory BaseEntity.fromJson(json) {// data值需要经过工厂转换为我们传进来的类型
    //print("===response===data===>$json");
    return BaseEntity(code: json["ret"], message: json["msg"], data: EntityFactory.generateOBJ<T>(json["data"]),);
  }
}