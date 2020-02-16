import 'package:flutter/material.dart';
class MessagePage extends StatefulWidget {
  @override
  MessagePageState createState() => new MessagePageState();
}

class MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息'),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.people_outline),
            onPressed: (){},
          )
        ],
      ),
      body: Center(
        child: Text('message'),
      ),
    );
  }
}