

import Foundation
import UserNotifications
import AVFoundation

final class AudioPlayerManager {

    static let shared = AudioPlayerManager()
    private init() {}

    private var queuePlayer: AVQueuePlayer?
    private var urls: [URL] = []
    private var lastURL: URL?

    private var didAddObserver = false
    
    func playAudios(with urls: [URL]) {
        guard !urls.isEmpty else { return }
        
        stopAudio()
        
        self.urls = urls
        self.lastURL = urls.last

        let items = urls.map { urlAddToken(url: $0) }

        queuePlayer = AVQueuePlayer(items: items)
        queuePlayer?.play()

        addObserverIfNeeded()
    }
    
    func reloadAndReplay() {
        guard let queuePlayer else { return }
        guard !urls.isEmpty else { return }

        queuePlayer.pause()
        queuePlayer.removeAllItems()

        let items = urls.map { urlAddToken(url: $0) }
        items.forEach { queuePlayer.insert($0, after: nil) }

        queuePlayer.play()
    }
    
    private func addObserverIfNeeded() {
        guard !didAddObserver else { return }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(itemDidPlayToEnd),
            name: .AVPlayerItemDidPlayToEndTime,
            object: nil
        )

        didAddObserver = true
    }
    
    private func removeObserverIfNeeded() {
        guard didAddObserver else { return }

        NotificationCenter.default.removeObserver(
            self,
            name: .AVPlayerItemDidPlayToEndTime,
            object: nil
        )

        didAddObserver = false
    }

    @objc private func itemDidPlayToEnd(_ notification: Notification) {
        guard
            let queuePlayer = queuePlayer,
            queuePlayer.items().isEmpty,
            let lastURL = lastURL
        else { return }

        let item = urlAddToken(url: lastURL)
        queuePlayer.insert(item, after: nil)
        queuePlayer.play()
    }
    
    func audioPause() {
        queuePlayer?.pause()
    }
    
    func audioPlay() {
        queuePlayer?.play()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func prepareAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            // 1️⃣ 播放类 App（支持后台）
            try session.setCategory(
                .playback,
                mode: .default,
                options: [
                    .mixWithOthers,    // 不打断其他 App（如音乐）
                    .allowAirPlay,     // 支持 AirPlay
                    .allowBluetooth    // 支持蓝牙耳机
                ]
            )

            // 2️⃣ 激活 session
            try session.setActive(true)
        } catch {
            print("❌ AudioSession 配置失败:", error)
        }
    }
}

extension AudioPlayerManager {

    private func urlAddToken(url: URL) -> AVPlayerItem {
        var headers: [String: String] = [:]

        if let token = TokenStorage.shared.accessToken {
            headers["Authorization"] = "Bearer \(token)"
        }

        let asset = AVURLAsset(
            url: url,
            options: [
                "AVURLAssetHTTPHeaderFieldsKey": headers
            ]
        )

        return AVPlayerItem(asset: asset)
    }
}

extension AudioPlayerManager {

    func stopAudio() {
        removeObserverIfNeeded()
        queuePlayer?.pause()
        queuePlayer?.removeAllItems()
        queuePlayer = nil
        urls.removeAll()
        lastURL = nil
    }
    
}
