
import Foundation
import UIKit
import Alamofire
import Combine

typealias TUOKOUXIU_SuccessBlk = (_ isSuccess: Bool) -> Void

class TUOKOUXIUSwiftBaseVC: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    var tufuh_block: TUOKOUXIU_SuccessBlk?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let navBar = UINavigationBarAppearance()
        navBar.backgroundColor = TUOKOUXIUSwiftbaiseC
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBar
        self.navigationController?.navigationBar.standardAppearance = navBar
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
