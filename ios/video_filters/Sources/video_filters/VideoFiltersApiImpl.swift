import Foundation

class VideoFiltersApiImpl: NSObject, VideoFiltersApi {

  func loadVideo(path: String) {
  NSLog("[PlatformView] Player load video")
    VideoFilterController.shared.loadVideo(path: path)
  }

  func play() {
  NSLog("[PlatformView] Player play")
    VideoFilterController.shared.play()
  }

  func pause() {
    VideoFilterController.shared.pause()
  }

  func getVideoDuration() -> Double {
    return VideoFilterController.shared.getDuration()
  }

  func getVideoPosition() -> Double {
    return VideoFilterController.shared.getPosition()
  }

  func updateFilters(config: VideoFilterConfig) {
    VideoFilterController.shared.updateFilters(
      exposure: Float(config.exposure),
      contrast: Float(config.contrast),
      saturation: Float(config.saturation),
      temperature: Float(config.temperature),
      tint: Float(config.tint)
    )
  }

  func setLutCubePath(path: String) {
    VideoFilterController.shared.setCubeLUT(path: path)
  }

  func setHaldPngPath(path: String) {
    VideoFilterController.shared.setHaldLUT(path: path)
  }
}