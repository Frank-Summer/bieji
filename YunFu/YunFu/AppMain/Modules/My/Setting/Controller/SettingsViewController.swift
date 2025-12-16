import UIKit

final class SettingsViewController: UIViewController, UIGestureRecognizerDelegate {

    private let tableView = UITableView()
    private var viewModel: SettingsViewModel!
    var onClose: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTopBar()
        setupTableView()

        viewModel = SettingsViewModel(router: SettingsRouter(viewController: self))


        // ✅ 自定义左右滑动关闭手势（无论 window 模式或 push 模式）
        setupSwipeGestures()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - 顶部栏
    private func setupTopBar() {
        let topBar = TopBarView()
        topBar.title = "\(LocalizedText.text("settings.title"))"
        topBar.onLeftTap = { [weak self] in
            self?.closeWindow()
        }

        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    // MARK: - 表格
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.register(SettingCell.self, forCellReuseIdentifier: "SettingCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - 自定义左右滑动关闭
    private func setupSwipeGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }

    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            // ✅ 无论左滑或右滑都关闭
            closeWindow()
        }
    }

    // MARK: - 滑动返回启用条件（push 模式时）
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        (navigationController?.viewControllers.count ?? 0) > 1
    }

    // MARK: - 关闭独立 window
    @objc private func closeWindow() {
        onClose?()
    }
}

// MARK: - UITableView 数据源
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        let item = section.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        cell.configure(with: item)
        cell.onTap = { item.action() }
        return cell
    }
}
