import 'package:flutter/material.dart';

class CirclePoint extends CustomPainter{
  double circleSize;
  Color lineColor;
  double paintWidth;

  CirclePoint({this.circleSize = 1, this.lineColor = Colors.orangeAccent, this.paintWidth = 8});

  Paint _paint = Paint()
    ..strokeCap = StrokeCap.square //画笔笔触类型
    ..isAntiAlias = true;//是否启动抗锯齿//画笔的宽度

  @override
  void paint(Canvas canvas, Size size) {
    _paint.style = PaintingStyle.fill; // 画线模式
    _paint.color = this.lineColor;
    canvas.drawCircle(Offset(size.height/2, size.height/2), 10, _paint);
    _paint.color = Colors.red;
    _paint.strokeWidth = this.paintWidth;
    canvas.drawLine(Offset(size.height/2, size.height/2), Offset(size.height/2, size.height/2), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}