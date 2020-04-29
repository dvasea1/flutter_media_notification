import 'dart:async';

import 'package:flutter/services.dart';

class Medianotification {
  static const MethodChannel _channel =
      const MethodChannel('medianotification');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void get showDialog async {
    await _channel.invokeMethod('showAlertDialogshowAlertDialog');
  }
}
