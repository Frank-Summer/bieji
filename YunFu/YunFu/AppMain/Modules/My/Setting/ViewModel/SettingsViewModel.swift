import UIKit

final class SettingsViewModel {

    let router: SettingsRouter
    private(set) var sections: [SettingSection] = []

    init(router: SettingsRouter) {
        self.router = router
        load()
    }

    func load() {
        sections = [
        // MARK: - 第 1 组：关于别急
        SettingSection(
            header: "关于别急",
            items: [
                SettingItem(
                    icon: "setting_about",
                    title: "\(LocalizedText.text("settings.about"))",
                    rightIcon: "chevron_right",
                    action: { [weak self] in
                    self?.router.openAbout()
                    }
                )
            ]
        ),

        // MARK: - 第 2 组：账号与安全
        SettingSection(
            header: "账号与安全",
            items: [
                SettingItem(
                    icon: "setting_account_security",
                    title: "\(LocalizedText.text("settings.accountSecurity"))",
                    rightIcon: "chevron_right",
                    action: { [weak self] in
                        self?.router.openAccount()
                    }
                )
            ]
        ),

        // MARK: - 第 3 组：会员开通
//        SettingSection(
//            header: "会员开通",
//            items: [
//                SettingItem(
//                    icon: "setting_vip",
//                    title: "会员开通",
//                    rightIcon: "chevron_right",
//                    action: {
//                        print("打开会员开通")
//                    }
//                )
//            ]
//        ),

        // MARK: - 第 4 组：通知
//        SettingSection(
//            header: "通知",
//            items: [
//                SettingItem(
//                    icon: "setting_notification",
//                    title: "\(LocalizedText.text("settings.notifications"))",
//                    rightIcon: "chevron_right",
//                    action: { [weak self] in
//                        self?.router.openSystemNotifications()
//                    }
//                )
//            ]
//        ),

    
        // MARK: - 第 5 组：App Store 评分
        SettingSection(
            header: "去 App Store 评分",
            items: [
                SettingItem(
                    icon: "setting_appstore",
                    title: "\(LocalizedText.text("settings.rate"))",
                    rightIcon: "chevron_right",
                    action: {
                        let appID = "6752887942"   // ← 替换成你真实的 App ID，例如：1234567890
                        let urlStr = "itms-apps://itunes.apple.com/app/id\(appID)?action=write-review"
                        
                        if let url = URL(string: urlStr) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                )
            ]
        ),

        // MARK: - 第 6 组：意见反馈
        SettingSection(
            header: "意见反馈",
            items: [
                SettingItem(
                    icon: "setting_feedback",
                    title: "\(LocalizedText.text("settings.feedback"))",
                    rightIcon: "chevron_right",
                    action: { [weak self] in
                        self?.router.openFeedbackController()
                    }
                )
            ]
        )
        ]
    }
}
