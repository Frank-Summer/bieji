import UIKit

final class LanguageViewController: UIViewController {
    
    private let tableView = UITableView()
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupTopBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - 顶部栏
    private func setupTopBar() {
        
        let topBar = TopBarView()
        topBar.title = "语言"
        
        topBar.onLeftTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        topBar.onLeftTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
