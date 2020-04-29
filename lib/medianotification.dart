import 'dart:io';

import 'package:flutter/services.dart';
/*enum MediaNotificationState {
  /// notification is shown, clicking on [play] icon
  /// [pause] will result in exception.
  PLAY,
  /// Currently playing notification, The user can [pause], [prev] or [next] the
  /// playback by clicking on action btns.
  PAUSE,
  /// Play previous media action
  PREV,
  /// Play next media action
  NEXT,
  /// app is in backgroud, call for select and open by click on media nofiticaion
  ///
  SELECT,
  STOPPED
}*/

class Medianotification {
  static const MethodChannel _channel =
      const MethodChannel('medianotification');

  static List<Function> _onCallbacks = [];

  static void listen_notification_events(Function callback) {
    _onCallbacks.add(callback);
    _channel.setMethodCallHandler(_handleMethod);
    _channel.setMethodCallHandler(_mediaNotificationStateHandler);
  }

  static Future<dynamic> _mediaNotificationStateHandler(MethodCall call) async {
    switch(call.method) {
      case "play":
        for (var callback in _onCallbacks) callback("play");
        break;
      case "pause":
        for (var callback in _onCallbacks) callback("pause");
        break;
      default:
        throw new ArgumentError('Unknown method ${call.method} ');
    }

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
      'play': true,
    });
  }

  static void hide_notification() {
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
