
import Foundation
import CommonCrypto

// ------------------------
// 辅助：String.md5
// ------------------------
extension String {
    var md5: String {
        guard let data = self.data(using: .utf8) else { return self }
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            _ = CC_MD5(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}

// ------------------------
// 顶层 CacheItem（必须为顶层类，支持 NSSecureCoding）
// ------------------------
final class TUOKOUXIUCacheItem: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    
    let data: Data
    let expireTime: TimeInterval
    
    init(data: Data, expireTime: TimeInterval) {
        self.data = data
        self.expireTime = expireTime
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(data, forKey: "data")
        coder.encode(expireTime, forKey: "expireTime")
    }
    
    required init?(coder: NSCoder) {
        guard let d = coder.decodeObject(of: NSData.self, forKey: "data") as Data? else { return nil }
        self.data = d
        self.expireTime = coder.decodeDouble(forKey: "expireTime")
    }
}

// ------------------------
// 主 Cache 单例（使用 TUOKOUXIUCacheItem）
// ------------------------
class TUOKOUXIUCache {
    static let shared = TUOKOUXIUCache()
    
    private let memoryCache = NSCache<NSString, TUOKOUXIUCacheItem>()
    private let diskPath: String = {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        let dir = path + "/tukou_cache/"
        try? FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true)
        return dir
    }()
    
    private init() {}
    
    private func filePath(for key: String) -> String {
        return diskPath + key.md5
    }
    
    /// 保存任意可序列化对象（会尝试转换为 JSON Data 或保留原 Data / String）
    func save(key: String, data: Any, expireSeconds: TimeInterval) {
        let expire = Date().timeIntervalSince1970 + expireSeconds
        // 转成 Data 优先级： Data -> JSONSerialization -> String -> fail
        var rawData: Data?
        if let d = data as? Data {
            rawData = d
        } else if JSONSerialization.isValidJSONObject(data) {
            rawData = try? JSONSerialization.data(withJSONObject: data, options: [])
        } else if let s = data as? String {
            rawData = s.data(using: .utf8)
        } else {
            // 尝试用 Mirror 转 JSON（失败则不保存）
            rawData = nil
        }
        
        guard let finalData = rawData else { return }
        let item = TUOKOUXIUCacheItem(data: finalData, expireTime: expire)
        memoryCache.setObject(item, forKey: key as NSString)
        
        let path = filePath(for: key)
        if let archived = try? NSKeyedArchiver.archivedData(withRootObject: item, requiringSecureCoding: true) {
            try? archived.write(to: URL(fileURLWithPath: path))
        }
    }
    
    /// 读取并尽可能还原为原始 Object（如果是 JSON 会还原为 JSON 对象）
    func load(key: String) -> Any? {
        if let mem = memoryCache.object(forKey: key as NSString) {
            if mem.expireTime > Date().timeIntervalSince1970 {
                return tryDeserialize(mem.data)
            } else {
                memoryCache.removeObject(forKey: key as NSString)
            }
        }
        
        let path = filePath(for: key)
        if let fileData = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let item = try? NSKeyedUnarchiver.unarchivedObject(ofClass: TUOKOUXIUCacheItem.self, from: fileData) {
            
            if item.expireTime > Date().timeIntervalSince1970 {
                memoryCache.setObject(item, forKey: key as NSString)
                return tryDeserialize(item.data)
            } else {
                try? FileManager.default.removeItem(atPath: path)
            }
        }
        
        return nil
    }
    
    func clearAll() {
        memoryCache.removeAllObjects()
        try? FileManager.default.removeItem(atPath: diskPath)
    }
    
    private func tryDeserialize(_ data: Data) -> Any {
        // 先尝试 JSON 解码
        if let obj = try? JSONSerialization.jsonObject(with: data, options: []) {
            return obj
        }
        // 再尝试字符串
        if let s = String(data: data, encoding: .utf8) {
            return s
        }
        // 最后返回 Data 本体
        return data
    }
}
