import 'dart:ui';

import 'package:flutter/services.dart';

class Medianotification {
  static const MethodChannel _channel =
      const MethodChannel('medianotification');

  static List<Function> _onCallbacks = [];


  static void listen_notification_events(Function callback) {
    _onCallbacks.add(callback);
    _channel.setMethodCallHandler(_handleMethod);
  }


  static Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'onPlay':
        for (var callback in _onCallbacks) callback("play");
        break;
      case 'onPause':
        for (var callback in _onCallbacks) callback("pause");
        break;
      default:
        throw ('method not defined');
    }
  }

  static void show_notification(
      String title, String subtitle, int currentProgress, int totalDuration) {
    _channel.invokeMethod('show_media_notification', <String, dynamic>{
      'title': title,
      'subtitle': subtitle,
      'currentProgress': currentProgress,
      'totalDuration': totalDuration,
    });
  }

  static void hide_notification() {
    _channel.invokeMethod('hide_media_notification');
  }

  static void change_notification_progress(int currentProgress) {
    _channel.invokeMethod('change_notification_progress', <String, dynamic>{
      'currentProgress': currentProgress,
    });
  }
  static void play() {
    _channel.invokeMethod('play');
  }
  static void pause() {
    _channel.invokeMethod('pause');
  }


}
