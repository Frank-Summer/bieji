import UIKit

final class DeleteAccountViewController: UIViewController {
    
    private let tipLabel = UILabel()
    
    private let tableView = UITableView()
    private var viewModel: DeleteAccountViewModels!
    
    private let bottomLine = UIView()
    
    private let confirmView = ConfirmCheckView()
    
    private let countdownVM = CountdownButtonViewModel()
    private var nextButton: CountdownButton!


    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupTopBar()
        
        setTipLabel()
        
        setupTable()
        
        setupBottomLine()
        
        setConfirmView()
        
        setupCountdownButton()

        countdownVM.start(seconds: 5)
        
        viewModel = DeleteAccountViewModels(router: DeleteAccountRouter(viewController: self))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - 顶部栏
    private func setupTopBar() {
        
        let topBar = TopBarView()
        topBar.title = ""
        
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
    
    private func setTipLabel() {

        let text = "账号注销重要提示"

        // 富文本（自定义行高）
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center

        let attr = NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .medium), // 字号
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraph
            ]
        )

        tipLabel.attributedText = attr
        tipLabel.numberOfLines = 0
        tipLabel.textAlignment = .center
        tipLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tipLabel)

        NSLayoutConstraint.activate([
            tipLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44), // 上内边距
            tipLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),   // 左内边距
            tipLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20) // 右内边距
        ])
    }
    
    private func setupTable() {

            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none

            view.addSubview(tableView)

            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            tableView.register(AccountDeleteTipCell.self, forCellReuseIdentifier: "AccountDeleteTipCell")

            tableView.dataSource = self
            tableView.delegate = self
        }
    
    private func setupBottomLine() {

        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.backgroundColor = UIColor.white.withAlphaComponent(0.2) // 淡色横线

        view.addSubview(bottomLine)

        NSLayoutConstraint.activate([
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
            bottomLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomLine.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 460)
        ])
    }
    
    private func setConfirmView() {
        view.addSubview(confirmView)

        NSLayoutConstraint.activate([
            confirmView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            confirmView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            confirmView.topAnchor.constraint(equalTo: bottomLine.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    private func setupCountdownButton() {

            nextButton = CountdownButton(viewModel: countdownVM)
            nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)

            view.addSubview(nextButton)

            NSLayoutConstraint.activate([
                nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                nextButton.topAnchor.constraint(equalTo: confirmView.safeAreaLayoutGuide.topAnchor, constant: 80)
            ])
        }

        @objc private func nextTapped() {
            print("用户点击下一步，进入下一页面")
        }
}


extension DeleteAccountViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tips.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let item = viewModel.tips[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountDeleteTipCell", for: indexPath) as! AccountDeleteTipCell
        cell.configure(item: item)
        return cell
    }
}
