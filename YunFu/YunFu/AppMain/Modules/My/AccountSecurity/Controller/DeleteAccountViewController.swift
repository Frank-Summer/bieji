import UIKit

final class DeleteAccountViewController: UIViewController {

    // MARK: - UI 组件
    private let topBar = TopBarView()

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    private let tipLabel = UILabel()
    private let tableView = UITableView()

    private let bottomLine = UIView()
    private let confirmView = ConfirmCheckView()

    private let countdownVM = CountdownButtonViewModel()
    private var nextButton: CountdownButton!

    private var viewModel: DeleteAccountViewModels!

    private var tableHeightConstraint: NSLayoutConstraint!

    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        // 🔥 必须提前初始化（否则 tableView 没高度）
        viewModel = DeleteAccountViewModels(router: DeleteAccountRouter(viewController: self))

        setupTopBar()          // 不滚动
        setupScrollView()      // 可滚动容器
        setupTipLabel()
        setupTable()
        setupBottomLine()
        setupConfirmView()
        setupCountdownButton()

        countdownVM.start(seconds: 5)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // 自动根据内容更新 tableView 高度
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.layoutIfNeeded()
        tableHeightConstraint.constant = tableView.contentSize.height
    }
}


// MARK: - TopBar（固定顶部）
private extension DeleteAccountViewController {
    func setupTopBar() {

        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.title = ""

        view.addSubview(topBar)

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



// MARK: - ScrollView + StackView（整体滚动）
private extension DeleteAccountViewController {
    func setupScrollView() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // StackView（自动布局垂直容器）
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
}



// MARK: - TipLabel
private extension DeleteAccountViewController {
    func setupTipLabel() {

        let text = LocalizedText.text("account.title")

        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center

        tipLabel.attributedText = NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .medium),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraph
            ]
        )

        tipLabel.numberOfLines = 0
        tipLabel.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(tipLabel)
    }
}



// MARK: - TableView（不滚动 + 自动高度）
private extension DeleteAccountViewController {
    func setupTable() {

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear

        tableView.register(AccountDeleteTipCell.self, forCellReuseIdentifier: "AccountDeleteTipCell")
        tableView.dataSource = self
        tableView.delegate = self

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80

        stackView.addArrangedSubview(tableView)

        // 高度自动更新的约束
        tableHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 1)
        tableHeightConstraint.isActive = true
    }
}



// MARK: - Bottom Line
private extension DeleteAccountViewController {
    func setupBottomLine() {

        bottomLine.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true

        stackView.addArrangedSubview(bottomLine)
    }
}



// MARK: - ConfirmView
private extension DeleteAccountViewController {
    func setupConfirmView() {
        stackView.addArrangedSubview(confirmView)
    }
}



// MARK: - Next Button
private extension DeleteAccountViewController {
    func setupCountdownButton() {

        nextButton = CountdownButton(viewModel: countdownVM)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)

        stackView.addArrangedSubview(nextButton)

        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20)
        ])
    }

    @objc func nextTapped() {
        print("点击下一步")
    }
}



// MARK: - TableView DataSource
extension DeleteAccountViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tips.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountDeleteTipCell", for: indexPath) as! AccountDeleteTipCell
        cell.configure(item: viewModel.tips[indexPath.row])
        return cell
    }
}
