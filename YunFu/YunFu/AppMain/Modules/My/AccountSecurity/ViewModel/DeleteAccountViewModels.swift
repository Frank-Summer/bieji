//
//  MySettingViewModel.swift
//  YunFu
//
//  MVVM: 存储数据 + 提供动作回调
//

import UIKit

final class DeleteAccountViewModels {
    
    let router: DeleteAccountRouter
    private(set) var  tips: [AccountDeleteTipItem] = []

    init(router: DeleteAccountRouter) {
        self.router = router
        loadTips()
    }

    
    func loadTips() {

            let rawTexts = [
                "账号注销后将无法再次使用该账号。账号内的所有记录和数据（包括但不限于个人信息和使用记录）都将一并清空且无法恢复。",
                "账号注销即表示自愿放弃该账号所有权益（包括但不限于购买的声音和会员服务），已支付的费用无法退款。",
                "如有需要，请在操作之前自行备份相关信息和数据。因账号注销对用户造成的不利影响，“别急”将不承担任何责任。",
                "账号注销不会自动取消正在订阅中的会员服务。请到相应的应用商城取消自动订阅，避免注销后被继续扣费。"
            ]

            tips = rawTexts.enumerated().map { index, text in
                AccountDeleteTipItem(index: index + 1, text: text)
            }
    }
}

