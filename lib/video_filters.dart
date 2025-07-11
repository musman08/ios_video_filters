import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'video_filters_api.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class VideoFilters {
  static final _api = VideoFiltersApi();

  static Future<void> loadVideo(String path) async{
    log('jjjjj video filters');
    _api.loadVideo(path);
  }
  static Future<void> play() => _api.play();
  static Future<void> pause() => _api.pause();

  static Future<double> getDuration() => _api.getVideoDuration();
  static Future<double> getPosition() => _api.getVideoPosition();

  static Future<void> updateFilters({
    required double exposure,
    required double contrast,
    required double saturation,
    required double temperature,
    required double tint,
  }) {
    return _api.updateFilters(
      VideoFilterConfig(
        exposure: exposure,
        contrast: contrast,
        saturation: saturation,
        temperature: temperature,
        tint: tint,
      ),
    );
  }

  static Future<void> setCubeLutPath(String path) => _api.setLutCubePath(path);
  static Future<void> setHaldLutPath(String path) => _api.setHaldPngPath(path);

  /// Flutter widget to show the iOS video player (AVPlayerLayer)
  static Widget iosVideoView({Key? key}) {
    return UiKitView(
      key: key,
      viewType: 'video_filter_view',
      layoutDirection: TextDirection.ltr,
      creationParams: const {},
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
