import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  MinePageState createState() => new MinePageState();
}

class MinePageState extends State<MinePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        children: <Widget>[
          Container(
            height:80,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg/mine_bg1.png'),
                      fit: BoxFit.fitWidth))),
          AppBar(
            title: new Text("我的"),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          Positioned(
            top: 80.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0,
            //here the body
            child: new Column(
              children: <Widget>[
                Container(
                    height: 131,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/bg/mine_bg2.png'),
                            fit: BoxFit.fitWidth))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(MinePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
