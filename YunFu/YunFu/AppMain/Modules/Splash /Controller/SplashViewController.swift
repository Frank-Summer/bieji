import UIKit
import AVKit

final class SplashViewController: UIViewController {

    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?

    var onFinished: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        debugPrint("🚀 LaunchAnimationVC loaded")

        playAnimation()
    }

    // MARK: - 播放国际化启动动画（使用组件）
    private func playAnimation() {

        guard let item = LocalizedVideo.playerItem(named: "launch_animation") else {
            debugPrint("⚠️ 未找到国际化启动动画 → finish()")
            finish()
            return
        }

        player = AVPlayer(playerItem: item)

        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = view.bounds
        playerLayer?.videoGravity = .resizeAspectFill

        if let layer = playerLayer {
            view.layer.addSublayer(layer)
            debugPrint("🎬 视频图层已加入视图层级")
        }

        debugPrint("▶️ 开始播放启动动画")
        player?.play()

        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: item,
            queue: .main
        ) { [weak self] _ in
            debugPrint("🏁 播放结束")
            self?.finish()
        }
    }

    // MARK: - 完成
    private func finish() {
        debugPrint("✨ LaunchAnimation 完成 → 回调上层")
        onFinished?()
        onFinished = nil
    }
}
