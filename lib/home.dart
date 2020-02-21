import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/news.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_application/api/DioManager.dart';
import 'package:flutter_application/api/NWApi.dart';
import 'package:flutter_application/api/NWMethod.dart';
import 'package:flutter_application/bean/MainData.dart';
import 'package:flutter_application/utils/utils.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  final GlobalKey<ScaffoldState> globalMainKey = GlobalKey<ScaffoldState>();
  final GlobalKey easyRefreshKey = new GlobalKey();

  MainData mainData;
  List<Container> interList = List();
  List<Container> dayAddList = List();

  Animation<double> animation;
  AnimationController animationController;
  Tween<double> sizeTween;
  Tween<Color> colorTween;

  @override
  void initState() {
    super.initState();
    initLoadMainData(true);
  }

  Future initLoadMainData(bool isLoading){
    animationController = AnimationController(vsync: this, lowerBound: 0, upperBound: 1, duration: Duration(milliseconds: 3000));
    animation = CurvedAnimation(parent: animationController, curve: Curves.bounceInOut);
    animation.addListener((){
      setState(() {});
    });
    sizeTween = Tween(begin: 0, end: 200);
    colorTween = Tween(begin: Colors.transparent, end: Colors.deepOrange);
    animationController.forward();

    DioManager dioManager = DioManager().initBindHttpDio(context, isLoading);
    return dioManager.request<MainData>(NWMethod.GET, NWApi.dataInfoPath, params: {'name': "disease_h5"}, success: (data) {
        mainData = data;
        setState(() {});
      }, error: (error) {
        print("========>error: code = ${error.code}, massage = ${error.message}");
      }
    );
  }

  void showInfoDataDialog(bool isInter) {
    showDialog(context: context, barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(title: Text(isInter ? '国际疫情数据' : '确诊新增数据'), content: SingleChildScrollView(
            child: ListBody(
              children: isInter ? interList : dayAddList,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('确认'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Expanded> buildTopData(bool isTop){
    List<Expanded> mainList = List();
    mainList.add(Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
            color: Utils.hexToColor(isTop ? "#fff8ed" : "#fef0f1"),
            borderRadius: new BorderRadius.all(new Radius.circular(5)),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 1)
            ]
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("较上日", style: TextStyle(color: Colors.grey, fontSize: 10,),),
                Text("${(null != mainData && null != mainData.chinaAdd) ? Utils.checkPlusOrMinus(isTop ? mainData.chinaAdd.nowConfirm : mainData.chinaAdd.nowSevere) : '+0000'}", style: TextStyle(color: Utils.hexToColor(isTop ? "#ff3753" : "#d50080"), fontSize: 10,),),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Text("${(null != mainData && null != mainData.chinaTotal) ? (isTop ? mainData.chinaTotal.nowConfirm : mainData.chinaTotal.nowSevere) : '00000'}", style: TextStyle(color: Utils.hexToColor(isTop ? "#ff3753" : "#d50080"), fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Text(isTop ? "现有确诊" : "现有重症", style: TextStyle(color: Colors.black, fontSize: 14,),),
          ],
        ),
      ),
    ));
    mainList.add(Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.only(bottom: 6, left: 6, right: 6),
        decoration: BoxDecoration(
            color: Utils.hexToColor(isTop ? "#fef0f1" : "#f0f9f4"),
            borderRadius: new BorderRadius.all(new Radius.circular(5)),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 1)
            ]
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("较上日", style: TextStyle(color: Colors.grey, fontSize: 10,),),
                Text("${(null != mainData && null != mainData.chinaAdd) ? Utils.checkPlusOrMinus(isTop ? mainData.chinaAdd.confirm : mainData.chinaAdd.heal) : '+0000'}", style: TextStyle(color: Utils.hexToColor(isTop ? "#d6001d" : "#009352"), fontSize: 10,),),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Text("${(null != mainData && null != mainData.chinaTotal) ? (isTop ? mainData.chinaTotal.confirm : mainData.chinaTotal.heal) : '00000'}", style: TextStyle(color: Utils.hexToColor(isTop ? "#d6001d" : "#009352"), fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Text(isTop ? "累计确诊" : "治愈人数", style: TextStyle(color: Colors.black, fontSize: 14,),),
          ],
        ),
      ),
    ));
    mainList.add(Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
            color: Utils.hexToColor(isTop ? "#fff8ed" : "#f8f8f8"),
            borderRadius: new BorderRadius.all(new Radius.circular(5)),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 1)
            ]
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("较上日", style: TextStyle(color: Colors.grey, fontSize: 10,),),
                Text("${(null != mainData && null != mainData.chinaAdd) ? Utils.checkPlusOrMinus(isTop ? mainData.chinaAdd.suspect : mainData.chinaAdd.dead) : '+0000'}", style: TextStyle(color: Utils.hexToColor(isTop ? "#ff9525" : "#6a686f"), fontSize: 10,),),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Text("${(null != mainData && null != mainData.chinaTotal) ? (isTop ? mainData.chinaTotal.suspect : mainData.chinaTotal.dead) : '00000'}", style: TextStyle(color: Utils.hexToColor(isTop ? "#ff9525" : "#6a686f"), fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Text(isTop ? "现有疑似" : "死亡人数", style: TextStyle(color: Colors.black, fontSize: 14,),),
          ],
        ),
      ),
    ));
    return mainList;
  }

  List<ExpansionTile> buildMainList(){
    List<ExpansionTile> mainList = List();
    interList.clear();
    if(null != mainData && null != mainData.areaTree && mainData.areaTree.isNotEmpty){
      for(Children area in mainData.areaTree){
        if(null != area){
          if("中国" == area.name){
            if(null != area.children){
              for(Children item in area.children){
                if(null != item){
                  List<Container> dataList = List();
                  for(Children children in item.children){
                    if(null != children){
                      dataList.add(Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        margin: EdgeInsets.only(left: 15, right: 10),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(child: Text(children.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.blue),), flex: 3,),
                            Expanded(child: Text("${null != children.today ? children.today.confirm : '--'}", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.blue),), flex: 4,),
                            Expanded(child: Text("${null != children.total ? children.total.confirm : '--'}", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black),), flex: 4,),
                            Expanded(child: Text("${null != children.total ? children.total.heal : '--'}", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black),), flex: 3,),
                            Expanded(child: Text("${null != children.total ? children.total.dead : '--'}", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black),), flex: 3,),
                            Expanded(child: Text("${null != children.total ? children.total.deadRate : '--'}%", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black),), flex: 3,),
                          ],
                        ),
                      ));
                    } // end of if
                  } // end of for
                  mainList.add(ExpansionTile(
                      title: Text(item.name),
                      subtitle: Container(
                        padding: EdgeInsets.only(top: 1, bottom: 1),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(child: Text("${null != item.today ? item.today.confirm : '-'}", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.blue),), flex: 1,),
                            Expanded(child: Text("${null != item.total ? item.total.confirm : '-'}", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black),), flex: 1,),
                            Expanded(child: Text("${null != item.total ? item.total.heal : '-'}", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black),), flex: 1,),
                            Expanded(child: Text("${null != item.total ? item.total.dead : '-'}", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black),), flex: 1,),
                            Expanded(child: Text("${null != item.total ? item.total.deadRate : '-'}%", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black),), flex: 1,),
                          ],
                        ),
                      ),
                      children: dataList
                  ));
                } // end of if
              } // end of for
            } // end of if
          }else{
            interList.add(Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Text("(${area.name})确诊:${null != area.total ? area.total.confirm : 0}人"
                  "/疑似:${null != area.total ? area.total.suspect : 0}人/治愈:${null != area.total ? area.total.heal : 0}人"
                  "/死亡:${null != area.total ? area.total.dead : 0}人"),
            ));
          }
        } // end of if
      } // end of for
    } // end of if
    if(null != mainData && null != mainData.chinaDayAddList && mainData.chinaDayAddList.isNotEmpty){
      for(ChinaDayAddList item in mainData.chinaDayAddList){
        if(null != item){
          dayAddList.add(Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Text("(日期:${item.date}) 确诊:${item.confirm}人/疑似:${item.suspect}人/治愈:${item.heal}"
                "/治愈比例:${item.healRate}/死亡:${item.dead}%/死亡比例:${item.deadRate}%\n"),
          ));
        } // end of if
      } // end of for
    } // end of if
    return mainList;
  }

  launchPgyWebSit() async{
    String url = "https://www.pgyer.com/l90t";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "无法加载地址!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalMainKey,
      appBar: AppBar(
        leading: InkWell(
          child: Container(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/normal_user_icon.png"),
            ),
          ),
          onTap: (){
            globalMainKey.currentState.openDrawer();
          },
        ),
        title: Text(widget.title, style: TextStyle(fontSize: 16),),
        centerTitle: false,
        actions: <Widget>[
          FloatingActionButton(child: Image.asset("assets/images/flutter.png", width: 28, height: 28,), heroTag: "NewsBtn", onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyNewsPage(title: "疫情新闻", articleList: null != mainData ? mainData.articleList : null,)));
          }),
          PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                this.popupMenuItem('A', Icons.update, '更新'),
                this.popupMenuItem('B', Icons.merge_type, '关于')
              ],
            onSelected: (String action){
                switch(action){
                  case "A":
                    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
                      String version = packageInfo.version;
                      String buildNumber = packageInfo.buildNumber;
                      showDialog<void>(context: context, barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("版本更新"),
                              content: new Text('当前版本：$version，当前Build号：$buildNumber\n'
                                  '是否马上跳转到蒲公英平台查看是否有新的版本?\n(注：下载密码1234)',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.orangeAccent
                              )),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text('放弃', style: TextStyle(color: Colors.grey, fontSize: 14)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                new FlatButton(
                                  child: new Text('跳转', style: TextStyle(color: Colors.red, fontSize: 14)),
                                  onPressed: () {
                                    launchPgyWebSit();
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    });
                    break;
                  case "B":
                    Navigator.pushNamed(context, "/about").then((result) {
                      Fluttertoast.showToast(msg: "返回数据：$result");
                    });
                    break;
                } // end of switch
            },
          ),
        ],
      ),
      body: Center(
        child: RefreshIndicator(
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index){
                  switch(index){
                    case 0:
                      return Container(
                        margin: EdgeInsets.only(top: 5, left: 30, right: 30),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(border: Border.all(color: Colors.green, width: 1, style: BorderStyle.solid)),
                        alignment: Alignment.center,
                        /*color: colorTween.evaluate(animation),*/
                        child: Text("数据来源：国家及各地卫健委每日信息发布", style: TextStyle(color: Colors.black, fontSize: 14,),),
                      );
                    case 1:
                      return Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 10, left: 5, bottom: 5),
                        child: Text("${null != animationController ? animationController.value : 0}统计截止${null != mainData ? mainData.lastUpdateTime : "0000-00-00 00:00:00"}", style: TextStyle(color: Colors.grey, fontSize: 15,),),
                      );
                    case 3:
                      return Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: FadeTransition(opacity: animationController, child: Column(
                            children: <Widget>[
                              Row(
                                children: buildTopData(true),
                              ),
                              Row(
                                children: buildTopData(false),
                              ),
                            ],
                          ),)
                      );
                    case 4:
                      return Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 10, left: 5, bottom: 5),
                        child: Text("中国疫情(包括港澳台)", style: TextStyle(color: Colors.black, fontSize: 15,),),
                      );
                    case 5:
                      return Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 5, left: 5, bottom: 5),
                        child: Text("7:00-10:00为更新高峰，数据如有滞后请谅解。", style: TextStyle(color: Colors.grey, fontSize: 12,),),
                      );
                    case 6:
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 8),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(child: Text("地区", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.blue),), flex: 3,),
                            Expanded(child: Text("新增确诊", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.blue),), flex: 4,),
                            Expanded(child: Text("累计确诊", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black),), flex: 4,),
                            Expanded(child: Text("治愈", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black),), flex: 3,),
                            Expanded(child: Text("死亡", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black),), flex: 3,),
                            Expanded(child: Text("病死率", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black),), flex: 3,),
                          ],
                        ),
                      );
                    case 7:
                      return Column(
                        children: buildMainList(),
                      );
                  } // end of switch
                  return Text("");
                },
                itemCount: 8),
            onRefresh: () async {
              await initLoadMainData(false);
            }
        ),
      ),
      drawer: Drawer(
        child: Container(
          alignment: Alignment.center,
          color: Colors.deepOrangeAccent,
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Text("希望疫情赶快过去，春乱花开-By逆水寒\n\n本应用采用Dart语言编写，"
              "采用Flutter跨平台技术，应用到封装网络请求，自定义组件(loading)，自定义绘制组件(时间轴)，"
              "两种跳转路由方式",
            style: TextStyle(color: Colors.white, fontSize: 15,),),
        ),
      ),
      drawerEdgeDragWidth: 200,
      floatingActionButton: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: (){
              initLoadMainData(true);
            },
            heroTag: 'refreshBtn',
            backgroundColor: Colors.cyan,
            child: Icon(Icons.refresh),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: FloatingActionButton(
              onPressed: (){
                showInfoDataDialog(false);
              },
              heroTag: 'info0Btn',
              backgroundColor: Colors.teal,
              child: Icon(Icons.info),
            ),
          ),
          FloatingActionButton(
            onPressed: (){
              showInfoDataDialog(true);
            },
            heroTag: 'info1Btn',
            child: Icon(Icons.info_outline),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> popupMenuItem(String id, IconData icon, String text){
    return PopupMenuItem<String>(
      value: id,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Icon(icon, color: Colors.blue,),
          new Text(text, style: TextStyle(color: Colors.teal),),
        ],
      ),
    );
  }
}