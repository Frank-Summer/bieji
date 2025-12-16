//
//  MySettingViewModel.swift
//  YunFu
//
//  MVVM: 存储数据 + 提供动作回调
//

import UIKit

final class AccountSecurityViewModels {
    
    let router: AccountSecurityRouter
    private(set) var sections: [AccountSecuritySection] = []

    init(router: AccountSecurityRouter) {
        self.router = router
        load()
    }

    func load() {
        sections = [
            AccountSecuritySection(
                header: "\(LocalizedText.text("account.field.phone"))",
                items: [
                    AccountSecurityItem(title: "\(LocalizedText.text("account.field.phone"))",value:"18611922766",state: "", icon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
            AccountSecuritySection(
                header: "\(LocalizedText.text("account.field.apple"))",
                items: [
                    AccountSecurityItem(title: "\(LocalizedText.text("account.field.apple"))",value:"huoshangfenghou@gmadsdasdasdasasdas",state: "已绑定", icon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
            AccountSecuritySection(
                header: "\(LocalizedText.text("account.action.deleteAccount"))",
                items: [
                    AccountSecurityItem(title: "\(LocalizedText.text("account.action.deleteAccount"))", value:"",state: "",icon: "chevron_right", action: { [weak self] in
                        self?.router.openDeleteAccount()
                        })
                ]
            ),
            
            AccountSecuritySection(
                header: "\(LocalizedText.text("account.action.logout"))",
                items: [
                    AccountSecurityItem(title: "\(LocalizedText.text("account.action.logout"))", value:"",state: "",icon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
        ]
    }
    
  
}

