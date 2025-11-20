//
//  LocalizationManager+LanguageCode.swift
//  LocalizationKit
//
//  Created by Frank on 2025/02/21.
//

import Foundation

public extension LocalizationManager {

    /// 返回规范化语言码：如 “en”、"zh-Hans"、“ja”
    var currentLanguageCode: String {

        // 用户强制指定语言
        if let override = UserDefaults.standard.string(forKey: "user_language") {
            return normalize(override)
        }

        // 系统语言
        return normalize(currentLanguage)
    }

    /// 兜底语言（一般为英文）
    var fallbackLanguage: String {
        return "en"
    }

    /// 规范化：将 zh-Hans-CN → zh-Hans
    private func normalize(_ lang: String) -> String {

        let components = lang.split(separator: "-")

        if components.count >= 2 {
            return "\(components[0])-\(components[1])"
        }

        return lang   // en、ja 等
    }
}
