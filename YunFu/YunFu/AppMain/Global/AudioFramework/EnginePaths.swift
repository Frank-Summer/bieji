import Foundation

enum EnginePaths {
    /// 初始化专用路径：
    /// - dataDir 指向 BCI_assets_0921 根目录（不是 presets）
    /// - configFile 优先 DynamicRule_v3.json，不存在则回退 DynamicSet_v2.json
    /// - playbackQueueFile 若存在则返回路径，否则为 nil
    static func bundleInitPaths() throws -> (dataDir: String, configFile: String, playbackQueueFile: String?) {
        guard let rootURL = Bundle.main.resourceURL?.appendingPathComponent("BCI_assets_0921", isDirectory: true) else {
            throw NSError(domain: "NoHurry", code: 1, userInfo: [NSLocalizedDescriptionKey: "BCI_assets_0921 not found in bundle"])
        }

        var isDir: ObjCBool = false
        guard FileManager.default.fileExists(atPath: rootURL.path, isDirectory: &isDir), isDir.boolValue else {
            throw NSError(domain: "NoHurry", code: 2, userInfo: [NSLocalizedDescriptionKey: "BCI_assets_0921 missing or not a directory"])
        }

        // Prefer DynamicRule_v3.json, fallback to DynamicSet_v2.json
        let preferredConfig = rootURL.appendingPathComponent("DynamicRule_v3.json", isDirectory: false)
        let fallbackConfig  = rootURL.appendingPathComponent("DynamicSet_v2.json", isDirectory: false)
        let configPath: String
        if FileManager.default.fileExists(atPath: preferredConfig.path) {
            configPath = preferredConfig.path
        } else if FileManager.default.fileExists(atPath: fallbackConfig.path) {
            configPath = fallbackConfig.path
        } else {
            throw NSError(domain: "NoHurry", code: 3, userInfo: [NSLocalizedDescriptionKey: "No config file found (DynamicRule_v3.json or DynamicSet_v2.json)"])
        }

        // Optional playback_queue.json: copy to writable Library directory if exists in bundle
        let playbackQueuePath = ensureWritablePlaybackQueue(fromBundleRoot: rootURL)

        return (dataDir: rootURL.path, configFile: configPath, playbackQueueFile: playbackQueuePath)
    }

    /// 将 bundle 中的 playback_queue.json 复制到可写的 Library/BCI_assets_0921 下。
    /// 若 bundle 中不存在，则返回 nil。
    private static func ensureWritablePlaybackQueue(fromBundleRoot rootURL: URL) -> String? {
        let fm = FileManager.default
        let src = rootURL.appendingPathComponent("playback_queue.json")
        guard fm.fileExists(atPath: src.path) else { return nil }

        guard let lib = fm.urls(for: .libraryDirectory, in: .userDomainMask).first else { return src.path }
        let dstDir = lib.appendingPathComponent("BCI_assets_0921", isDirectory: true)
        let dst = dstDir.appendingPathComponent("playback_queue.json")

        // 确保目标目录存在
        if !fm.fileExists(atPath: dstDir.path) {
            try? fm.createDirectory(at: dstDir, withIntermediateDirectories: true)
        }

        // 若目标文件不存在或需要覆盖，则复制
        if !fm.fileExists(atPath: dst.path) {
            do {
                try fm.copyItem(at: src, to: dst)
            } catch {
                // 如果复制失败，退回使用 bundle 路径（至少可读）
                return src.path
            }
        }
        return dst.path
    }
}

