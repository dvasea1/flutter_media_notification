import 'dart:async';

import 'package:flutter/services.dart';

class Medianotification {
  static const MethodChannel _channel =
      const MethodChannel('medianotification');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void show_notification(String title, String subtitle,
      int currentProgress, int totalDuration) async {
    await _channel.invokeMethod('show_media_notification', <String, dynamic>{
      'title': title,
      'subtitle': subtitle,
      'currentProgress': currentProgress,
      'totalDuration': totalDuration,
    });
  }

  static void hide_notification() async {
    await _channel.invokeMethod('hide_media_notification');
  }
}
