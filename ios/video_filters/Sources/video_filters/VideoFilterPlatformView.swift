import Flutter
import UIKit
import AVKit

class VideoFilterPlatformView: NSObject, FlutterPlatformView {
    private let containerView: UIView

    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) {
        NSLog("[PlatformView] Initializing VideoFilterPlatformView...")

        let videoView = UIView(frame: frame)
        videoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        videoView.backgroundColor = .black.withAlphaComponent(0.1)
        videoView.layer.borderColor = UIColor.red.cgColor
        videoView.layer.borderWidth = 1

        if let playerLayer = VideoFilterController.shared.getPlayerLayer() {
            NSLog("[PlatformView] Player layer retrieved successfully.")
            playerLayer.frame = videoView.bounds
            playerLayer.videoGravity = .resizeAspect
            playerLayer.needsDisplayOnBoundsChange = true
            videoView.layer.addSublayer(playerLayer)
            VideoFilterController.shared.play()
        } else {
            NSLog("[PlatformView] Player layer is nil!")
            print("player is nullllll")
        }

        self.containerView = videoView
        super.init()
    }

    func view() -> UIView {
        return containerView
    }
}
