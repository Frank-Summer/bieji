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
                header: "账号",
                items: [
                    SettingItem(title: "账号信息", icon: "my_setting", action: {
                        print("打开账号信息")
                    })
                ]
            ),
            SettingSection(
                header: "通用",
                items: [
                    SettingItem(title: "隐私协议", icon: "my_privacy", action: {
                        print("打开隐私协议")
                    }),
                    SettingItem(title: "服务条款", icon: "my_terms", action: {
                        print("打开服务条款")
                    })
                ]
            ),
            SettingSection(
                header: "操作",
                items: [
                    SettingItem(title: "退出登录", icon: "my_logout", action: {
                        print("执行退出登录逻辑")
                    })
                ]
            )
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
    let title: String
    let icon: String
    let action: (() -> Void)?
}
