import Foundation
import AVFoundation

/// 视频本地化工具
enum LocalizedVideo {
    
    /// 获取本地化视频文件 URL
    static func url(named name: String, ext: String = "mp4") -> URL? {
        
        let langs = LanguagePreference.preferredLanguages
        let bundle = Bundle.localization
        
        print("\n========== 🎬 LocalizedVideo ==========")
        print("🌐 Preferred languages =", langs)
        print("🔍 Searching video =", name + "." + ext)
        print("========================================\n")
        
        for lang in langs {
            let folder = "\(lang).lproj"
            print("🔍 Checking:", folder)
            
            if let path = bundle.path(forResource: name, ofType: ext, inDirectory: folder) {
                print("🎯 Found video:", path)
                return URL(fileURLWithPath: path)
            } else {
                print("❌ Not found:", folder + "/" + name + "." + ext)
            }
        }
        
        print("🚫 No localized video found →", name + "." + ext)
        return nil
    }
    
    /// 返回 AVPlayerItem
    static func playerItem(named name: String, ext: String = "mp4") -> AVPlayerItem? {
        guard let url = url(named: name, ext: ext) else { return nil }
        return AVPlayerItem(url: url)
    }
}
