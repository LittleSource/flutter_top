//构建底部bar和切换bar的页面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_top/pages/confession.dart';
import 'package:flutter_top/pages/home.dart';
import 'package:flutter_top/pages/message.dart';
import 'package:flutter_top/pages/mine.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _IndexState();
}

// 要让主页面 Index 支持动效，要在它的定义中附加mixin类型的对象TickerProviderStateMixin
class _IndexState extends State<IndexPage> with TickerProviderStateMixin {
  int _currentIndex = 0; // 当前界面的索引值
  List<StatefulWidget> _pageList; // 用来存放我们的图标对应的页面
  StatefulWidget _currentPage; // 当前的显示页面
  var _tabNavList = [
    //bar的图标相关参数
    {
      "title": "首页",
      "selectImage": "assets/images/icon/tab_homepage_selected.png",
      "normalImage": "assets/images/icon/tab_homepage_normal.png",
    },
    {
      "title": "墙墙",
      "selectImage": "assets/images/icon/tab_wall_selected.png",
      "normalImage": "assets/images/icon/tab_wall_normal.png",
    },
    {
      "title": "消息",
      "selectImage": "assets/images/icon/tab_message_selected.png",
      "normalImage": "assets/images/icon/tab_message_normal.png",
    },
    {
      "title": "我的",
      "selectImage": "assets/images/icon/tab_mine_selected.png",
      "normalImage": "assets/images/icon/tab_mine_normal.png",
    }
  ];
  @override
  void initState() {
    super.initState();
    // 将bottomBar上面的按钮图标对应的页面存放起来
    _pageList = <StatefulWidget>[
      HomePage(),
      ConfessionList(),
      MessagePage(),
      MinePage(),
    ];
    _currentPage = _pageList[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    var _index = 0;
    //定义一个底部导航的工具栏
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: _tabNavList.map((item) {
        var bavItem = BottomNavigationBarItem(
            icon:
                _barItemIcon(_index, item["selectImage"], item["normalImage"]),
            title: Text(item["title"],style: TextStyle(fontSize: 10.0),));
        _index++;
        return bavItem;
      }).toList(),
      selectedFontSize: 12.0,
      selectedItemColor: Color.fromARGB(180, 0, 0, 0),
      currentIndex: _currentIndex, // 当前点击的索引值
      type: BottomNavigationBarType.fixed, // 设置底部导航工具栏的类型：fixed 固定
      onTap: (int index) {
        setState(() {
          // 点击之后，需要触发的逻辑事件
          _currentIndex = index;
          _currentPage = _pageList[_currentIndex];
        });
      },
    );
    return MaterialApp(
      home: Scaffold(
        body: Center(child: _currentPage), // 动态的展示我们当前的页面
        bottomNavigationBar: bottomNavigationBar, // 底部工具栏
      ),
      theme: ThemeData(
        indicatorColor: Colors.black54,
        primaryColor: Colors.yellow, // 设置主题颜色
      ),
    );
  }

  //根据索引判断icon图片返回Image Widget
  Widget _barItemIcon(index, selectedImage, normalImage) {
    return Image.asset(
      "${index == _currentIndex ? selectedImage : normalImage}",
      width: 30,
      height: 30,
    );
  }
}
