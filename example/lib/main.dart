import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_native_widgets/flutter_native_widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _restText = '返回结果：';

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
      platformVersion = await FlutterNativeWidgets.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Column(
          children: <Widget>[
            RaisedButton(
              child: Text('alertDialog'),
                onPressed: () async {
                  bool result = await FlutterNativeWidgets.showConfirmDialog(
                    title : '我的标题',
                    message : '确认要退出吗？？？',
                    positiveButtonText : '确定',
                    negativeButtonText : '取消',
                    positiveButtonTextColor : Color.fromARGB(-1, -1, -1, 0).value,
                    negativeButtonTextColor : Color.fromARGB(-1, -1, -1, 0).value);
                  print(result.toString());
                  setState(() {
                    Color a = Color.fromARGB(-1, -1, -1, 0);

                    //_restText = a.value.toUnsigned(32).toString();

                    _restText = result.toString();
                  });
                }
            ),
            Text(_restText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
