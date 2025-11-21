import UIKit
import ObjectiveC

private var tuksNavVCAssociationKey: UInt8 = 0

extension UIViewController {
    weak var tuks_navVC: TUOKOUXIUSwiftNavC? {
        get {
            return objc_getAssociatedObject(self, &tuksNavVCAssociationKey) as? TUOKOUXIUSwiftNavC
        }
        set {
            objc_setAssociatedObject(self,
                                     &tuksNavVCAssociationKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

class TUOKOUXIUWrapVC: UIViewController {
    
    let contentViewController: UIViewController
    
    init(contentVC: UIViewController) {
        self.contentViewController = contentVC
        super.init(nibName: nil, bundle: nil)
        
        addChild(contentVC)
        view.addSubview(contentVC.view)
        contentVC.view.frame = view.bounds
        contentVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentVC.didMove(toParent: self)
        
        contentVC.tuks_navVC = nil
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override var title: String? {
        get { contentViewController.title }
        set { contentViewController.title = newValue }
    }
    
    override var hidesBottomBarWhenPushed: Bool {
        get { contentViewController.hidesBottomBarWhenPushed }
        set { contentViewController.hidesBottomBarWhenPushed = newValue }
    }
    
    override var childForStatusBarStyle: UIViewController? { contentViewController }
    override var childForStatusBarHidden: UIViewController? { contentViewController }
}

class TUOKOUXIUSwiftNavC: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden(true, animated: false)
        delegate = self
        interactivePopGestureRecognizer?.delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        let wrapVC = TUOKOUXIUWrapVC(contentVC: viewController)
        viewController.tuks_navVC = self
        
        if viewControllers.count > 0 {
            wrapVC.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(wrapVC, animated: animated)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let popped = super.popViewController(animated: animated) as? TUOKOUXIUWrapVC
        return popped?.contentViewController
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let poppedWraps = super.popToRootViewController(animated: animated) as? [TUOKOUXIUWrapVC]
        return poppedWraps?.map { $0.contentViewController }
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        guard let wrapVC = viewControllers.compactMap({ $0 as? TUOKOUXIUWrapVC })
                .first(where: { $0.contentViewController == viewController }) else {
            return nil
        }
        let poppedWraps = super.popToViewController(wrapVC, animated: animated) as? [TUOKOUXIUWrapVC]
        return poppedWraps?.map { $0.contentViewController }
    }
    
    var tuks_navVCArr: [UIViewController] {
        return viewControllers.compactMap { ($0 as? TUOKOUXIUWrapVC)?.contentViewController }
    }

}
