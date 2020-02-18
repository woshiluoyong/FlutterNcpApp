import 'package:flutter/material.dart';

class MyAboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(
          child: Text("Back", style: TextStyle(fontSize: 10),),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: (){
            Navigator.of(context).pop("期待疫情早日过去，春乱花开!");
          }),
        title: Text("关于本APP"),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text("本NCP疫情数据显示应用采用Flutter编写成功！主要实战哈Flutter这种技术！", style: TextStyle(
              color: Color.fromARGB(250, 100, 100, 200),
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
            ))
          ],
        ),
      ),
    );
  }
}