// import 'package:flutter_test/flutter_test.dart';
// import 'package:video_filters/video_filters.dart';
// import 'package:video_filters/video_filters_platform_interface.dart';
// import 'package:video_filters/video_filters_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockVideoFiltersPlatform
//     with MockPlatformInterfaceMixin
//     implements VideoFiltersPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final VideoFiltersPlatform initialPlatform = VideoFiltersPlatform.instance;
//
//   test('$MethodChannelVideoFilters is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelVideoFilters>());
//   });
//
//   test('getPlatformVersion', () async {
//     VideoFilters videoFiltersPlugin = VideoFilters();
//     MockVideoFiltersPlatform fakePlatform = MockVideoFiltersPlatform();
//     VideoFiltersPlatform.instance = fakePlatform;
//
//     expect(await videoFiltersPlugin.getPlatformVersion(), '42');
//   });
// }
