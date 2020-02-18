import 'package:flutter/material.dart';
import 'package:flutter_application/bean/MainData.dart';
import 'package:flutter_application/components/circle_point.dart';

class MyNewsPage extends StatefulWidget{
  final String title;
  final List<ArticleList> articleList;

  MyNewsPage({Key key, this.title, this.articleList}): super(key: key);

  @override
  _MyNewsPageState createState() => _MyNewsPageState();
}

class _MyNewsPageState extends State<MyNewsPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: null != widget.articleList ? ListView.separated(
          itemBuilder: (BuildContext context, int index){
            return 0 == index % 2 ? Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(left: BorderSide(
                      width: 3,
                      color: Colors.deepOrangeAccent
                  ))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.articleList[index~/2].title, style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13
                  ),),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(widget.articleList[index~/2].desc, style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                    ),),
                  ),
                  Text("来源：${widget.articleList[index~/2].media}", style: TextStyle(
                      color: Colors.black,
                      fontSize: 13
                  ),)
                ],
              ),
            ) : Container(
              margin: EdgeInsets.only(left: 2.2),
              child: CustomPaint(
                size: Size(18, 18),
                painter: CirclePoint(),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index){
            return Divider(
              height: 1,
              color: Colors.grey,
            );
          },
          itemCount: widget.articleList.length * 2) : Center(
          child: Text("暂无数据,请返回刷新数据再试!", style: TextStyle(
            color: Colors.grey,
            fontSize: 15
          ),),
        ),
      ),
    );
  }
  
}