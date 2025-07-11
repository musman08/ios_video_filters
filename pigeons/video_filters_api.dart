import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/video_filters_api.g.dart',
    swiftOut: 'ios/video_filters/Sources/video_filters/VideoFiltersApi.swift',
  ),
)
@HostApi()
abstract class VideoFiltersApi {
  void loadVideo(String path);
  void play();
  void pause();
  double getVideoDuration();
  double getVideoPosition();

  void updateFilters(VideoFilterConfig config);
  void setLutCubePath(String path);
  void setHaldPngPath(String path);
}

class VideoFilterConfig {
  double exposure;
  double contrast;
  double saturation;
  double temperature;
  double tint;
  // double whiteBalance;

  VideoFilterConfig({
    required this.exposure,
    required this.contrast,
    required this.saturation,
    required this.temperature,
    required this.tint,
    // required this.whiteBalance,
  });
}

// dart run pigeon --input pigeons/video_filters_api.dart

// flutter pub run pigeon \
// --input pigeons/video_filters_api.dart \
// --dart_out lib/video_filters_api.g.dart \
// --swift_out ios/Classes/VideoFiltersApi.swift

// flutter pub run pigeon --input pigeons/video_filters_api.dart --dart_out lib/video_filters_api.g.dart --swift_out ios/Classes/VideoFiltersApi.swift
