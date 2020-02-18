import 'package:flutter/material.dart';

class Utils{
  Utils._internal();

  //flutter中不能直接使用十六进制的颜色值，所以必须要转换为flutter颜色对象。
  static Color hexToColor(String s) {// 如果传入的十六进制颜色值不符合要求，返回默认值
    if (s == null || s.length != 7 || int.tryParse(s.substring(1, 7), radix: 16) == null) {
      s = '#999999';
    } // end of if
    return new Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static String checkPlusOrMinus(int numVal){
    return "${(numVal < 0) ? '' : '+'}$numVal";
  }
}