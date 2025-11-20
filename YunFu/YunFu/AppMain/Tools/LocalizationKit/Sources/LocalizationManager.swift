//
//  LocalizationManager.swift
//  LocalizationKit
//
//  Created by Frank on 2025/02/21.
//

import Foundation
import UIKit

/// 🌐 国际化核心管理器（单例）
public final class LocalizationManager {

    /// 全局唯一实例（大厂统一单例）
    public static let shared = LocalizationManager()

    /// 当前语言（默认跟随系统语言）
    public private(set) var currentLanguage: String = Locale.preferredLanguages.first ?? "en"

    /// 私有初始化（禁止外部实例化）
    private init() {}

    // MARK: - 🏁 启动阶段初始化
    /// 在 AppDelegate 中调用，用于初始化语言环境
    public func bootstrap() {

        // 从本地读取用户选择语言（如果有）
        if let saved = UserDefaults.standard.string(forKey: "user_language") {
            currentLanguage = saved
        }

        print("🌐 LocalizationManager bootstrap — active language = \(currentLanguage)")

        // 根据语言设置 RTL / LTR
        applyRTLSupport()
    }

    // MARK: - 🔄 语言切换
    /// 用户切换语言（中文、英文、阿语等）
    public func setLanguage(_ lang: String) {

        // 1) 保存
        UserDefaults.standard.set(lang, forKey: "user_language")

        // 2) 更新语言
        currentLanguage = lang

        // 3) RTL 更新
        applyRTLSupport()

        // 4) 重置 Bundle 缓存（强制语言读取）
        NotificationCenter.default.post(
            name: .LocalizationBundleShouldReset,
            object: nil
        )

        // 5) 通知 UI 刷新
        NotificationCenter.default.post(
            name: .LocalizationDidChange,
            object: nil
        )

        print("🌐 Language switched to: \(lang)")
    }

    // MARK: - ↔️ RTL 支持
    private func applyRTLSupport() {

        let isRTL = Locale.characterDirection(forLanguage: currentLanguage) == .rightToLeft

        if isRTL {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            print("↔️ RTL Enabled")
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
}


// MARK: - 🔔 自定义通知
public extension Notification.Name {

    /// UI 语言刷新
    static let LocalizationDidChange = Notification.Name("LocalizationDidChange")

    /// Bundle 语言缓存需要重置
    static let LocalizationBundleShouldReset = Notification.Name("LocalizationBundleShouldReset")
}
