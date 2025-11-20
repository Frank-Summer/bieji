
import UIKit
import Foundation

//我的页面
class TUOKOUXIUSwiftMy: TUOKOUXIUSwiftBaseVC {
    
    private var tufuh_setV: UIView?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = TUOKOUXIUSwiftheiseC
    }
}
