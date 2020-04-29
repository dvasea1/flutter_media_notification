import 'package:flutter/services.dart';

class Medianotification {
  static const MethodChannel _channel =
      const MethodChannel('medianotification');

  /*static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }*/

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

  static void listen_notification_events(Function onPlayClick) {}
}
