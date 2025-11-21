
import UIKit
import Foundation

class TUOKOUXIUSwiftBaNavC: TUOKOUXIUSwiftNavC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delaysTouchesBegan = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUHidTabb"), object: nil)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }

    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}
