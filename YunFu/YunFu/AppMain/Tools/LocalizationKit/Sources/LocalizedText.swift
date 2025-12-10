import Foundation

/// 文本本地化工具
enum LocalizedText {

    /// 获取国际化文案
    /// - Parameters:
    ///   - key: 文案 key
    ///   - table: 默认 Localizable.strings
    static func text(_ key: String, table: String = "InfoPlist") -> String {

        let langs = LanguagePreference.preferredLanguages
        let bundle = Bundle.localization

        for lang in langs {
            if let path = bundle.path(forResource: lang, ofType: "lproj"),
               let lb = Bundle(path: path) {

                let value = NSLocalizedString(
                    key,
                    tableName: table,
                    bundle: lb,
                    value: "",
                    comment: ""
                )

                if value != key {
                    print("🌐 InfoPlist 命中语言：\(lang) → \(key) = \(value)")
                    return value
                }
            }
        }

        print("⚠️ LocalizedText 未找到文案 → 返回 key:", key)
        return key
    }
}
