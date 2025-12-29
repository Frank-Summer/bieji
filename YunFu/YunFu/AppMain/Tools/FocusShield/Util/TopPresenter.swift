import UIKit

enum TopPresenter {

    static func present(_ vc: UIViewController) {
        UIApplication.shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?
            .rootViewController?
            .present(vc, animated: true)
    }

    static func dismiss(completion: (() -> Void)? = nil) {
        UIApplication.shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?
            .rootViewController?
            .dismiss(animated: true, completion: completion)
    }
}
