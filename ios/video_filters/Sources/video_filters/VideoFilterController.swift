import Foundation
import AVFoundation
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftCube

class VideoFilterController {
  static let shared = VideoFilterController()

  private var player: AVPlayer?
  private var playerItem: AVPlayerItem?
  private var asset: AVAsset?
  private var cubeFilter: CIFilter?
  private var haldImage: CIImage?

  private var exposure: Float = 0.0
  private var contrast: Float = 1.0
  private var saturation: Float = 1.0
  private var temperature: Float = 6500.0
  private var tint: Float = 0.0

  private var hasValidLUT: Bool {
    return cubeFilter != nil && haldImage != nil
  }

//   func loadVideo(path: String) {
//     let url = URL(fileURLWithPath: path)
//     asset = AVAsset(url: url)
//     playerItem = AVPlayerItem(asset: asset!)
//     player = AVPlayer(playerItem: playerItem)
//     applyFilters()
//   }
//
//   func play() {
//     player?.play()
//   }
//
//   func pause() {
//     player?.pause()
//   }

func loadVideo(path: String) {
    print("video filter loading in siwft")
    NSLog("[Controller] Loading video at path:", path)
    let url = URL(fileURLWithPath: path)
    asset = AVAsset(url: url)
    playerItem = AVPlayerItem(asset: asset!)
    player = AVPlayer(playerItem: playerItem)
    applyFilters()
    NSLog("[Controller] Video loaded and filters applied.")
}

func play() {
    NSLog("[Controller] Playing video")
    player?.play()
}

func pause() {
    NSLog("[Controller] Pausing video")
    player?.pause()
}

func getPlayerLayer() -> AVPlayerLayer? {
    NSLog("called player view from swift")
    if let avPlayer = player {
        NSLog("[Controller] Returning AVPlayerLayer with player")
        return AVPlayerLayer(player: avPlayer)
    } else {
        NSLog("[Controller] Player is nil, returning nil layer")
        return nil
    }
}



  func getDuration() -> Double {
    return playerItem?.duration.seconds ?? 0.0
  }

  func getPosition() -> Double {
    return player?.currentTime().seconds ?? 0.0
  }

  func updateFilters(
    exposure: Float,
    contrast: Float,
    saturation: Float,
    temperature: Float,
    tint: Float
  ) {
    self.exposure = exposure
    self.contrast = contrast
    self.saturation = saturation
    self.temperature = temperature
    self.tint = tint
    applyFilters()
  }

  func setCubeLUT(path: String) {
    guard !path.isEmpty else {
      self.cubeFilter = nil
      return
    }

    do {
      let lut = try SC3DLut(contentsOf: URL(fileURLWithPath: path))
      self.cubeFilter = try lut.ciFilter()
    } catch {
      print("Failed to load cube LUT: \(error)")
      self.cubeFilter = nil
    }
  }

  func setHaldLUT(path: String) {
    guard !path.isEmpty else {
      self.haldImage = nil
      return
    }

    let haldURL = URL(fileURLWithPath: path)
    if let image = CIImage(contentsOf: haldURL) {
      self.haldImage = image
    } else {
      NSLog("Failed to load HALD image")
      self.haldImage = nil
    }
  }

  private func applyFilters() {
    guard let asset = asset, let playerItem = playerItem else { return }

    let composition = AVVideoComposition(asset: asset) { request in
      var image = request.sourceImage.clampedToExtent()

      let exposureFilter = CIFilter.exposureAdjust()
      exposureFilter.inputImage = image
      exposureFilter.ev = self.exposure
      image = exposureFilter.outputImage ?? image

      let colorFilter = CIFilter.colorControls()
      colorFilter.inputImage = image
      colorFilter.contrast = self.contrast
      colorFilter.saturation = self.saturation
      image = colorFilter.outputImage ?? image

      let wbFilter = CIFilter.temperatureAndTint()
      wbFilter.inputImage = image
      wbFilter.neutral = CIVector(x: CGFloat(self.temperature), y: CGFloat(self.tint))
      wbFilter.targetNeutral = CIVector(x: CGFloat(6500), y: CGFloat(0))
      image = wbFilter.outputImage ?? image

      if self.hasValidLUT, let lut = self.cubeFilter {
        lut.setValue(image, forKey: kCIInputImageKey)
        image = lut.outputImage ?? image
      }

      request.finish(with: image, context: nil)
    }

    playerItem.videoComposition = composition
  }

//   func getPlayerLayer() -> AVPlayerLayer? {
//     return player.map { AVPlayerLayer(player: $0) }
//   }
}

