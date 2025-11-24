//
//  MySettingViewModel.swift
//  YunFu
//
//  MVVM: 存储数据 + 提供动作回调
//

import UIKit

final class MySettingViewModel {
    
    // MARK: - Output
    var sections: [SettingSection] = []
    
    // 数据更新回调
    var onReload: (() -> Void)?
    
    init() {
        loadData()
    }
    
    private func loadData() {
        sections = [
            SettingSection(
                header: "关于别急",
                items: [
                    SettingItem(licon:"setting_about", title: "关于别急",ricon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
            SettingSection(
                header: "账号与安全",
                items: [
                    SettingItem(licon:"setting_account_security", title: "账号与安全",ricon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
            SettingSection(
                header: "会员开通",
                items: [
                    SettingItem(licon:"setting_vip", title: "会员开通",ricon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
            SettingSection(
                header: "通知",
                items: [
                    SettingItem(licon:"setting_notification", title: "通知",ricon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
            SettingSection(
                header: "语言",
                items: [
                    SettingItem(licon:"setting_language", title: "语言",ricon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
            SettingSection(
                header: "去 App Store 评分",
                items: [
                    SettingItem(licon:"setting_appstore", title: "去 App Store 评分",ricon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
            SettingSection(
                header: "意见反馈",
                items: [
                    SettingItem(licon:"setting_feedback", title: "意见反馈",ricon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
        ]
        
        onReload?()
    }
}

// MARK: - Model
struct SettingSection {
    let header: String
    let items: [SettingItem]
}

struct SettingItem {
    let licon: String
    let title: String
    let ricon: String
    let action: (() -> Void)?
}
