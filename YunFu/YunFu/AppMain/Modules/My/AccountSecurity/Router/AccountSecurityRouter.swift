import UIKit

final class AccountSecurityRouter {

    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func openDeleteAccount() {
        let vc = DeleteAccountViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
