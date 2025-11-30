import UIKit

final class SettingsRouter {

    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func openAbout() {
        let vc = AboutViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openAccount() {
        let vc = AccountSecurityViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSystemNotifications() {
        let vc = SystemNotificationsViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openLanguage() {
        let vc = LanguageViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openFeedbackController() {
        let vc = FeedbackController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
