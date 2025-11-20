//
//  RTLSupport.swift
//  LocalizationKit
//
//  Created by Frank on 2025/02/21.
//
//  -------------------------------------------------------------
//  文件用途（File Purpose）
//  -------------------------------------------------------------
//  为应用提供 RTL（Right-To-Left）布局支持。
//  对标抖音 / 微信 / TikTok 的语言/布局系统。
//
//  功能：
//    ✔ 判断当前语言是否为 RTL（阿语/希伯来语等）
//    ✔ 自动切换 UI 方向（LTR ↔ RTL）
//    ✔ 通知根界面刷新布局
//    ✔ 为 NavigationBar / TabBar / UIView 提供统一的方向控制
//
//  -------------------------------------------------------------
//  使用示例（How to Use）
//  -------------------------------------------------------------
//
//      RTLSupport.shared.applyLayoutDirection()
//
//  每次语言切换时：
//
//      LocalizationManager.shared.setLanguage("ar")
//      RTLSupport.shared.applyLayoutDirection()
//
//  -------------------------------------------------------------
//

import UIKit
import Foundation

public final class RTLSupport {

    public static let shared = RTLSupport()
    private init() {}

    /// 当前是否为 RTL 语言
    public var isRTL: Bool {
        let lang = LocalizationManager.shared.currentLanguage
        return Locale.characterDirection(forLanguage: lang) == .rightToLeft
    }

    /// 应用布局方向（必须在语言切换后调用）
    public func applyLayoutDirection() {

        if isRTL {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
            print("↩️ RTL Enabled")
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
            UITabBar.appearance().semanticContentAttribute = .forceLeftToRight
            print("➡️ RTL Disabled")
        }

        // 通知全局 UI 重新渲染
        NotificationCenter.default.post(
            name: .LocalizationDidChange,
            object: nil
        )
    }
}
