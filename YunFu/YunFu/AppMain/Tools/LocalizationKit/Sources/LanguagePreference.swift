import Foundation

/// 管理当前 App 的语言优先级
enum LanguagePreference {
    /// 当前优先语言列表，例如 ["zh-Hans", "en"]
    static var preferredLanguages: [String] {
        // 系统首选语言，例如 "zh-Hans-CN" / "en-US"
        let system = Locale.preferredLanguages.first ?? "en"
        
        let normalized: String
        if system.hasPrefix("zh") {
            normalized = "zh-Hans"      // 你可以改成自己的中文标识
        } else {
            normalized = "en"
        }
        
        if normalized == "en" {
            return ["en"]
        } else {
            // 先尝试当前语言，再尝试英文
            return [normalized, "en"]
        }
    }
}

extension Bundle {
    /// 某个语言对应的 .lproj Bundle
    static func bundle(forLanguage lang: String) -> Bundle? {
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj") else {
            return nil
        }
        return Bundle(path: path)
    }
}
