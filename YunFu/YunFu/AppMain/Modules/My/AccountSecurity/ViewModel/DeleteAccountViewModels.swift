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
                "\(LocalizedText.text("account.delete.noticeDescription01"))",
                "\(LocalizedText.text("account.delete.noticeDescription02"))",
                "\(LocalizedText.text("account.delete.noticeDescription03"))",
                "\(LocalizedText.text("account.delete.noticeDescription04"))",
            ]

            tips = rawTexts.enumerated().map { index, text in
                AccountDeleteTipItem(index: index + 1, text: text)
            }
    }
}

