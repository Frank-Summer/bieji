import Foundation

enum LanguageProvider {

    /// 当前系统语言（用于 HTTP Header）
    static var current: String {
        guard let lang = Locale.preferredLanguages.first else {
            return "en-US"
        }

        if lang.hasPrefix("zh") {
            return "zh-CN"
        } else if lang.hasPrefix("en") {
            return "en-US"
        } else {
            return Locale.current.languageCode ?? "en-US"
        }
    }
}
