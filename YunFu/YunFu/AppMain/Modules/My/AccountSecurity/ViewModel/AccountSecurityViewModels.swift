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
                    AccountSecurityItem(title: "Apple",value:"huoshangfenghou@gmadsdasdasdasasdas",state: "已绑定", icon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
            AccountSecuritySection(
                header: "注销账号",
                items: [
                    AccountSecurityItem(title: "注销账号", value:"",state: "",icon: "chevron_right", action: { [weak self] in
                        self?.router.openDeleteAccount()
                        })
                ]
            ),
            
            AccountSecuritySection(
                header: "退出登录",
                items: [
                    AccountSecurityItem(title: "退出登录", value:"",state: "",icon: "chevron_right", action: {
                        print("打开账号信息")
                    })
                ]
            ),
        ]
    }
    
  
}

