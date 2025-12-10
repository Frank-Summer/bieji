import UIKit

/// 图片本地化工具（针对 Asset Catalog，多语言自动匹配）
enum LocalizedImage {
    
    /// 直接让 UIImage 自动按语言从 .lproj 里的 Assets.car 取图
    static func image(named name: String) -> UIImage? {
        
        for lang in LanguagePreference.preferredLanguages {
            print("🔍 trying language = \(lang)")
        }
        
        // 这里不用任何 bundle，用系统自动国际化机制
        if let img = UIImage(named: name) {
            print("🎉 [LocalizedImage] Asset hit → \(name)")
            return img
        } else {
            print("🚫 [LocalizedImage] Asset miss → \(name)")
            return nil
        }
    }
}
