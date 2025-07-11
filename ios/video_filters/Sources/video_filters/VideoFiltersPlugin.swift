
import Flutter
import UIKit

public class VideoFiltersPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        VideoFiltersApiSetup.setUp(binaryMessenger: registrar.messenger(), api: VideoFiltersApiImpl())

        let factory = VideoFilterPlatformViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "video_filter_view")
    }
}
