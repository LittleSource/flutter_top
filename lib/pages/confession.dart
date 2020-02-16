import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_top/utils/dio_request.dart';

class ConfessionList extends StatefulWidget {
  @override
  _ConfessionListState createState() => new _ConfessionListState();
}

class _ConfessionListState extends State<ConfessionList>
    with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  List<String> _tabText = ['推荐','附近','关注'];
  List<Widget> _tabs = [];
  TabController _tabController;//tab需要定义一个Controller
  int _currentIndex = 0;

  @override bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    // 初始化tabs
    _tabText.forEach((t) => _tabs.add(Tab(child: Text(t,style: TextStyle(fontSize:16.0)))));
    // 创建tab的Controller
    _tabController = TabController(length: _tabText.length, vsync: this);
    //添加监听tab切换
    _tabController.addListener(_onTabChanged);
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
                TabPage(TabType: 1),
                TabPage(TabType: 2),
                TabPage(TabType: 3),
              ],
        )
    );
  }
  //tab改变事件
  _onTabChanged() {
    if (_tabController.indexIsChanging) {
      if (this.mounted) {
          setState(() {
            _currentIndex = _tabController.index;
          });
      }
    }
  }
}

class TabPage extends StatefulWidget {
  int TabType;
  TabPage({this.TabType});
  @override
  _TabPageState createState() => new _TabPageState(TabType: this.TabType);
}

class _TabPageState extends State<TabPage> with AutomaticKeepAliveClientMixin{
  int TabType;//页面类型 推荐or附近or关注
  List<String> list = [];//列表数据
  EasyRefreshController _refreshController = EasyRefreshController();

  _TabPageState({this.TabType});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return EasyRefresh(
      controller: _refreshController,
      header: ClassicalHeader(refreshReadyText:"该松手啦!",bgColor: Colors.yellow,infoColor: Colors.black45),
      footer: BallPulseFooter(color: Colors.yellow),
      child: _buildCardList(),
      onRefresh: () async{
        await _onRefresh();
      },
      onLoad: () async {
        await _onLoadMore;
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showRefreshLoading();
    print(this.TabType);
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  //构建cardList
  Widget _buildCardList() {
    List<Widget> cardList = [];
    list.forEach((text) => cardList.add(ConfessionCard(text: text,)));
    return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: cardList
    );
  }

  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      _refreshController.callRefresh();
      return true;
    });
  }
  //下拉刷新函数
  void _onRefresh() async {
    await DioRequest.request(
      "http://ic.snssdk.com/2/article/v25/stream/?count=20&min_behot_time=1504621638&bd_latitude=4.9E-324&bd_longitude=4.9E-324&bd_loc_time=1504622133&loc_mode=5&loc_time=1504564532&latitude=35.00125&longitude=113.56358166666665&city=%E7%84%A6%E4%BD%9C&lac=34197&cid=23201&iid=14534335953&device_id=38818211465&ac=wifi&channel=baidu&aid=13&app_name=news_article&version_code=460&device_platform=android&device_type=SM-E7000&os_api=19&os_version=4.4.2&uuid=357698010742401&openudid=74f06d2f9d8c9664%20",
      onSuccess: (data){
        print(data);
      }
    );
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        list = List.generate(10, (i) => '哈喽$i,我是新刷新的该方法只有两个参数，含义见注释该方法返回一个'+DateTime.now().toString());
      });
      print("桑沙溪你");
    });
  }
  void _onLoadMore() async {
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        setState(() {
          list.addAll(List.generate(10, (i) => '含义见注释该方法返回一个'));
        });
      });
      print("桑沙溪你");
    });
  }
}

/**
 * 表白卡片
 */
class ConfessionCard extends StatelessWidget {
  String _text;

  ConfessionCard({String text}) : _text = text;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: GestureDetector(
        child: Card(
          margin: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: new Column(
            children: [
              new CardHead(),
              new CardText(_text),
              new CardImg(),
              new CardFoot()
            ],
          ),
        ),
        onTap: () async {
          await showDialog1(context,this._text);
        },
      )
    );
  }
  // 弹出对话框
  Future<bool> showDialog1(BuildContext context,String text) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text(text),
          actions: <Widget>[
            FlatButton(
              child: Text("确定"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
          ],
        );
      },
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
              child: PopupMenuButton<String>(
                  initialValue: "",
                  child: IconButton(icon: Icon(Icons.keyboard_arrow_down),onPressed: null,),
                  onSelected: (String string){
                    print(string.toString());
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    PopupMenuItem(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(Icons.favorite_border),
                            Text("关注")
                          ]),
                      value: "关注",
                    ),PopupMenuItem(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(Icons.share),
                            Text("分享")
                          ]),
                      value: "分享",
                    ),PopupMenuItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.notifications_none),
                          Text("举报")
                      ]),
                      value: "举报",
                    )
                  ]
              ),
              alignment: Alignment.centerRight,
            ))
      ],
    );
  }
}

class CardText extends StatelessWidget {
  String _text;

  CardText(String text){
    this._text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(this._text),
      padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 0.0),
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

