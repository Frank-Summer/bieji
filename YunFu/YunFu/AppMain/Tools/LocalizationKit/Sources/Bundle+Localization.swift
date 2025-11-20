//
//  Bundle+Localization.swift
//  LocalizationKit
//
//  Created by Frank on 2025/02/21.
//
//  -------------------------------------------------------------
//  文件用途（File Purpose）
//  -------------------------------------------------------------
//  本文件通过「Bundle Hook」的方式实现 **强制语言切换**：
//    ✔ 不重启 App 即可切换语言
//    ✔ 支持所有 .lproj 文本（Localizable.strings / 多 table）
//    ✔ 对标抖音 / 微信的 “自定义多语言系统”
//    ✔ 支持动态 Bundle 切换（例如：手动切换语言）
//
//  注意：
//     - iOS 默认语言机制使用 `Bundle.main.localizedString`
//     - 我们通过 Hook 的方式让它使用「用户选择语言」
//
//  -------------------------------------------------------------
//  使用示例（How to Use）
//  -------------------------------------------------------------
//
//      // 获取文案
//      let title = L("home_title")
//
//      // 切换语言
//      LocalizationManager.shared.setLanguage("zh-Hans")
//
//      // 自动生效！
//
//  -------------------------------------------------------------
//

import Foundation
import UIKit   // ⬅️ 监听通知需要 UIKit

// MARK: - 私有语言 Bundle 缓存
private var languageBundle: Bundle?


// MARK: - Bundle 强制语言 Hook
public extension Bundle {

    /// 当前生效语言（由 LocalizationManager 控制）
    static var appLanguage: String {
        LocalizationManager.shared.currentLanguage
    }

    /// 当前语言的 lproj Bundle
    private static var current: Bundle {

        // 如果已经缓存，直接返回
        if let b = languageBundle { return b }

        // 找到对应 lproj 路径
        guard let path = Bundle.main.path(forResource: appLanguage, ofType: "lproj"),
              let b = Bundle(path: path) else {

            // 否则 fallback 主 Bundle
            return Bundle.main
        }

        languageBundle = b
        return b
    }

    
    static var localization: Bundle {
            Bundle(for: LocalizationManager.self)
        }
    
    

    // MARK: - Hook to fetch localized string
    /// 获取当前语言的本地化文案
    static func localizedString(key: String, table: String? = nil) -> String {
        return current.localizedString(forKey: key, value: nil, table: table)
    }
}


// MARK: - 为 NSLocalizedString 提供简写方法
public func L(_ key: String, table: String? = nil) -> String {
    return Bundle.localizedString(key: key, table: table)
}


// MARK: - 监听语言切换通知（自动清理 Bundle Cache）
private var _localizationBundleResetObserver: NSObjectProtocol? = {

    // 监听 LocalizationBundleShouldReset 通知
    NotificationCenter.default.addObserver(
        forName: .LocalizationBundleShouldReset,
        object: nil,
        queue: .main
    ) { _ in

        // 清理 Bundle 缓存（让强制语言立即生效）
        languageBundle = nil

        print("🗑 Localization: bundle cache cleared")
    }

    return nil
}()
