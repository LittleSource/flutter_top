import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ConfessionList extends StatefulWidget {
  @override
  _ConfessionListState createState() => new _ConfessionListState();
}

class _ConfessionListState extends State<ConfessionList>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List<Widget> _tabs;
  @override
  void initState() {
    super.initState();
    //初始化tabs
    _tabs = [
      Tab(child: Text('推荐',style: TextStyle(fontSize:16.0))),
      Tab(child: Text('附近',style: TextStyle(fontSize:16.0))),
      Tab(child: Text('关注',style: TextStyle(fontSize:16.0)))];
    // 创建tab的Controller
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(icon: new Icon(Icons.list), onPressed: () {}),
            centerTitle: true,
            title: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.fromLTRB(15, 4, 15, 1),
                tabs:_tabs
            ),
          actions: <Widget>[
            IconButton(icon: new Icon(Icons.add), onPressed: () {})
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildCardList(),
            _buildCardList(),
            _buildCardList()
          ],
        )
    );
  }

  Widget _buildCardList() {
    //循环构建card List
    return ListView(
        children: List<Widget>.generate(10, (i) {
          return ConfessionCard();
        }));
  }
}

class ConfessionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        margin: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        child: new Column(
          children: [
            new CardHead(),
            new CardText(),
            new CardImg(),
            new CardFoot()
          ],
        ),
      ),
    );
  }
}

class CardHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 50.0,
          height: 50.0,
          margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
          child: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(
                'https://c-ssl.duitang.com/uploads/item/201409/10/20140910170324_hvjiG.thumb.1500_0.jpeg'),
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text('小源源吆',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)),
          Text('十分钟前', style: TextStyle(fontSize: 13.0)),
        ]),
        Expanded(
            child: Align(
              child: IconButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  color: Colors.black54,
                  onPressed: () {},
                  alignment: Alignment.centerRight
              ),
              alignment: Alignment.centerRight,
            ))
      ],
    );
  }
}

class CardText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('图片的宽度会缩放到显示空间的宽度，高度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁'),
      padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
    );
  }
}

class CardImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        height: 176.0,
        child: GridView.count(
          physics: new NeverScrollableScrollPhysics(), //屏蔽GridView内部滚动
          crossAxisCount: 2,
          crossAxisSpacing: 2.5,
          mainAxisSpacing: 0.0,
          childAspectRatio: 1.0,
          children: <Widget>[
            FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                fit: BoxFit.cover,
                image:
                'https://i0.hdslb.com/bfs/archive/dadc476e1be7662d67083dbb2118e87f72cb20c1.png@1100w_484h_1c_100q.png'),
            FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                fit: BoxFit.cover,
                image:
                'https://i0.hdslb.com/bfs/sycp/creative_img/201912/ebd713aac2adc17e126def2a0ea9cac3.jpg@1100w_484h_1c_100q.jpg'),
          ],
        ));
  }
}

class CardFoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.favorite_border, color: Colors.black54),
          label: Text("点赞", style: TextStyle(color: Colors.black54)),
          onPressed: null,
        ),
        FlatButton.icon(
          icon: Icon(Icons.comment, color: Colors.black54),
          label: Text("评论", style: TextStyle(color: Colors.black54)),
          onPressed: null,
        ),
      ],
    );
  }
}
