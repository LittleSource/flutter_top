import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页'), actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.crop_free,
              size: 26.0,
            ),
            onPressed: () {}),
      ]),
      body: new SwipeView(),
    );
  }
}

class SwipeView extends StatefulWidget {
  @override
  _SwipeViewState createState() => new _SwipeViewState();
}

class _SwipeViewState extends State<SwipeView> {
  final List<String> _imgList = [
    "https://img.alicdn.com/tfs/TB1wlmPqKL2gK0jSZFmXXc7iXXa-520-280.jpg_q90_.webp",
    "https://img.alicdn.com/tfs/TB1e.Z4qKH2gK0jSZJnXXaT1FXa-520-280.jpg_q90_.webp",
    "https://img.alicdn.com/simba/img/TB1Sp6iiVT7gK0jSZFpSuuTkpXa.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 210,
        child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return (Image.network(
                _imgList[index],
                fit: BoxFit.fill,
              ));
            },
            itemCount: 3,
            pagination: SwiperPagination(builder: DotSwiperPaginationBuilder(size: 7, activeSize:8)),
            scrollDirection: Axis.horizontal,
            autoplay: true,
            onTap: (index) {
              print('点击了第$index个');
            })
    );
  }
}
