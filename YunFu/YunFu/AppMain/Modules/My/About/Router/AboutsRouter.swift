import UIKit

final class AboutsRouter {

    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func openAbout() {
        let vc = AboutViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
