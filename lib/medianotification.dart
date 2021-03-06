import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';


class Medianotification {
  static const MethodChannel _channel =
      const MethodChannel('medianotification');

  static List<Function> _onCallbacks = [];

  static void listen_notification_events(Function callback) {
    _onCallbacks.add(callback);
    debugPrint("callbacks count is "+_onCallbacks.length.toString());
    _channel.setMethodCallHandler(_mediaNotificationStateHandler);
  }

  static Future<dynamic> _mediaNotificationStateHandler(MethodCall call) async {
    switch (call.method) {
      case "play":
        for (var callback in _onCallbacks) callback("play");
        break;
      case "pause":
        for (var callback in _onCallbacks) callback("pause");
        break;
      case 'onPlay':
        for (var callback in _onCallbacks) callback("play");
        break;
      case 'onPause':
        for (var callback in _onCallbacks) callback("pause");
        break;
      default:
        throw new ArgumentError('Unknown method ${call.method} ');
    }
  }

  static void show_notification(
      String title, String subtitle, int currentProgress, int totalDuration) {
    _channel.invokeMethod('show_media_notification', <String, dynamic>{
      'title': title,
      'subtitle': subtitle,
      'currentProgress': currentProgress,
      'totalDuration': totalDuration,
      'play': true,
    });
  }

  static void hide_notification(Function callback) {
    _onCallbacks.remove(callback);
    _channel.invokeMethod('hide_media_notification');
  }

  static void play() {
    _channel.invokeMethod('play');
  }

  static void pause() {
    _channel.invokeMethod('pause');
  }

  static void change_notification_progress(int currentProgress) {
    if (Platform.isIOS) {
      _channel.invokeMethod('change_notification_progress', <String, dynamic>{
        'currentProgress': currentProgress,
      });
    }
  }
}
