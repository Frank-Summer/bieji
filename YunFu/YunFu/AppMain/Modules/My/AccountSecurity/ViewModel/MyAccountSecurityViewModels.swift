//
//  MySettingViewModel.swift
//  YunFu
//
//  MVVM: 存储数据 + 提供动作回调
//

import UIKit

final class MyAccountSecurityViewModels {
    
    // MARK: - Output
    var sections: [AccountSecuritySection] = []
    
    // 数据更新回调
    var onReload: (() -> Void)?
    
    init() {
        loadData()
    }
    
    private func loadData() {
        sections = [
            AccountSecuritySection(
                header: "手机",
                items: [
                    AccountSecurityItem(title: "手机",value:"18611922766",state: "", icon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
            AccountSecuritySection(
                header: "Apple",
                items: [
                    AccountSecurityItem(title: "Apple",value:"huoshangfenghou@gm...",state: "已绑定", icon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
            AccountSecuritySection(
                header: "注销账号",
                items: [
                    AccountSecurityItem(title: "注销账号", value:"",state: "",icon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
        ]
        
        onReload?()
    }
}

// MARK: - Model
struct AccountSecuritySection {
    let header: String
    let items: [AccountSecurityItem]
}

struct AccountSecurityItem {
    let title: String
    let value: String
    let state: String
    let icon: String
    let action: (() -> Void)?
}
