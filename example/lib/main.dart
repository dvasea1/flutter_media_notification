import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:medianotification/medianotification.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
    // Medianotification.show_notification("title", "subtitle", 100, 200);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    Medianotification.listen_notification_events((value){
      debugPrint("value is "+value);
    });
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Text('Running on: '),
            ),
            InkWell(
              child: Container(width: 100, height: 100, color: Colors.red, child: Text("Show"),),
              onTap: () async {
                debugPrint('click');
                Medianotification.show_notification("title", "subtitle", 100, 100);
              },
            ),
            InkWell(
              child: Container(width: 100, height: 100, color: Colors.red, child: Text("pause"),),
              onTap: () async {
                debugPrint('click');
                Medianotification.pause();
              },
            ),
            InkWell(
              child: Container(width: 100, height: 100, color: Colors.red, child: Text("play"),),
              onTap: () async {
                debugPrint('click');
                Medianotification.play();
              },
            ),
            InkWell(
              child: Container(width: 100, height: 100, color: Colors.red, child: Text("Hide"),),
              onTap: () async {
                debugPrint('hide');
                Medianotification.hide_notification((){

                });
              },
            )
          ],
        ),
      ),
    );
  }
}
