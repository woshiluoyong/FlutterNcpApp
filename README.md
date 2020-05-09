# FlutterNcpApp
***
本应用采用Dart语言编写查看NCP(新型冠状肺炎)疫情数据，采用Flutter跨平台技术，应用到封装网络请求，自定义组件(loading)，自定义绘制组件(时间轴)，两种跳转路由方式
---
>ui界面参考页面：`https://news.qq.com/zt2020/page/feiyan.htm?from=timeline&isappinstalled=0`

>接口地址Get获取：`https://view.inews.qq.com/g2/getOnsInfo?name=disease_h5`

>app查看[地址](https://www.pgyer.com/l90t) 查看密码：`1234`

>![首页](https://www.pgyer.com/image/view/app_screenshots/79cbd2a8ba2805958d5366b6588b9274-528)
![新闻](https://www.pgyer.com/image/view/app_screenshots/f41632ec12528cec0611d3156c39605f-528)


>配置Flutter的开发环境

1、 在Android Studio中先下载安装好Flutter和Dart的插件，然后下载Flutter的SDK。大小差不多1个G, 推荐去官网下载，速度并不慢，网址：https://flutter.io/setup-macos/
2、解压zip，放在你需要放的路径下就行，配置环境变量时需要该路径。同时在AS中打开Preferences，搜索Dart和Flutter，配置好Flutter SDK的路径:"解压路径/flutter"。配置好Dart SDK的路径:"解压路径/flutter/bin/cache/dart-sdk"
3、在终端打开open -e .bash_profile ，配置环境变量：
```
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PATH=${PATH}:解压后的flutter的路径/flutter/bin:$PATH
```
```
source ~/.bash_profile 可执行: echo $PATH 查看
```
4、安装: 运行 flutter doctor --android-licenses ，一路选择yes即可
5、对应项目的依赖安装命令为: flutter pub get
