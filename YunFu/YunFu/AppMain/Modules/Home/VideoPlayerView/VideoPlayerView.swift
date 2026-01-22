//
//  VideoPlayerView.swift
//  YunFu
//
//  Created by wanglong on 2025/12/3.
//  Copyright © 2025 DCloud. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - 可复用的播放器视图
class VideoPlayerView: UIView {
    // 外部只读 player 与 playerLayer（安全暴露）
    public private(set) var player: AVPlayer?
    public var playerLayer: AVPlayerLayer? { return layer as? AVPlayerLayer }

    override class var layerClass: AnyClass { AVPlayerLayer.self }

    /// 不再在这里创建 AVPlayer，只做 layer 配置和播放控制
    func configure() {
        // 保留此方法以便需要时设置 videoGravity 等
        playerLayer?.videoGravity = .resizeAspectFill
    }

    func setPlayer(_ p: AVPlayer?) {
        self.player = p
        self.playerLayer?.player = p
    }

    func play() {
        guard let p = player, p.currentItem?.status == .readyToPlay else { return }
        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isEnterApp { return }
        p.play()
    }

    func pause() {
        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isEnterApp { return }
        player?.pause()
    }

    func refreshLayer() {
        playerLayer?.setNeedsLayout()
        playerLayer?.setNeedsDisplay()
    }

    func cleanup() {
        player?.pause()
        player?.replaceCurrentItem(with: nil)
        playerLayer?.player = nil
        player = nil
    }
}
