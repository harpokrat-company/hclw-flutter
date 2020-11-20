import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:hclw_flutter/hclw_flutter.dart';
import 'package:hclw_flutter/rsakeypair.dart';
import 'package:hclw_flutter/password.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

    final lib = new HclwFlutter();
    print("Libraries loaded");

    print("PLOP");
    Stopwatch watch = new Stopwatch();
    watch.start();
    final keyPair = new RSAKeyPair(lib, 2048);
    print("KeyPair creation ${watch.elapsedMilliseconds / 1000}");
    watch.stop();


    final private = keyPair.createPrivateKey();
    final public = keyPair.createPublicKey();
    var sec = new Password(lib);
    sec.password = "plpop";

    sec.initializeAsymmetric();
    final ser = sec.serializeAsymmetric(public);

    final result = lib.deserializeSecretAsymmetric(private, ser);
    print(result.password);

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await HclwFlutter.platformVersion;
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
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
