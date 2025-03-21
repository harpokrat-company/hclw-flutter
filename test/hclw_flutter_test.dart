import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hclw_flutter/hclw_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('hclw_flutter');

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
    expect(await HclwFlutter.platformVersion, '42');
  });
}
