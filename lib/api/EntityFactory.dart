import 'dart:convert';
import 'package:flutter_application/bean/MainData.dart';

class EntityFactory {
  static T generateOBJ<T>(jsonStr) {
    if (jsonStr == null) {
      return null;
    } else if (T.toString() == "MainData") {//可以在这里加入任何需要并且可以转换的类型，例如下面
      Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
     return MainData.fromJson(jsonMap) as T;
    } else {
      return jsonStr as T;
    }
  }
}