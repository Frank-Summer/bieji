import UIKit

final class AccountSecurityViewController: UIViewController {
    
    private let tableView = UITableView()
    private var viewModel: AccountSecurityViewModels!

    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupTopBar()
        setupTableView()
        
        viewModel = AccountSecurityViewModels(router: AccountSecurityRouter(viewController: self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - 顶部栏
    private func setupTopBar() {
        
        let topBar = TopBarView()
        topBar.title = "\(LocalizedText.text("account.title"))"
        
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
    
    // MARK: - 表格
    private func setupTableView() {

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.register(AccountSecurityCell.self, forCellReuseIdentifier: "AccountSecurityCell")

        tableView.dataSource = self
        tableView.delegate = self
    }
}


// MARK: - UITableView 数据源
extension AccountSecurityViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let section = viewModel.sections[indexPath.section]
        let item = section.items[indexPath.row]

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "AccountSecurityCell",
            for: indexPath
        ) as! AccountSecurityCell

        cell.configure(with: item)

        // 点击事件
        cell.onTap = { item.action() }

        return cell
    }
}
