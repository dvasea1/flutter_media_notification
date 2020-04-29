import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medianotification/medianotification.dart';

void main() {
  const MethodChannel channel = MethodChannel('medianotification');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Medianotification.platformVersion, '42');
  });
}
