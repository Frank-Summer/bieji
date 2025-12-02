import UIKit
import SafariServices

final class AboutViewController: UIViewController {

    private let backgroundImageView = UIImageView()
    private let versionLabel = UILabel()
    private let subtitle = UILabel()
    private var viewModel: AboutsViewModel!
    private let tableView = UITableView()
    private let agreementView = UITextView()




    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        setupBackground()
        setupTopBar()
        setupVersionLabel()
        setsubtitle()
        setupTableView()
        setagreementText()
        
        viewModel = AboutsViewModel(router: AboutsRouter(viewController: self))
    }

    // MARK: - 全屏背景图
    private func setupBackground() {

        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = UIImage(named: "about_background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true

        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - 顶部栏
    private func setupTopBar() {
        let top = TopBarView()
        top.title = ""
        top.leftIcon = UIImage(named: "back")

        top.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(top)

        NSLayoutConstraint.activate([
            top.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            top.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            top.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            top.heightAnchor.constraint(equalToConstant: 44)
        ])

        top.onLeftTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    // MARK: - 版本号标签
    private func setupVersionLabel() {

        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"

        // ⭐ 动态获取当前年份（兼容 iOS 12）
        let year = Calendar.current.component(.year, from: Date())

        // 显示：1.0 (2025)
        versionLabel.text = "\(version)(\(year))"
        versionLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        versionLabel.font = .systemFont(ofSize: 12)
        versionLabel.textAlignment = .center
        versionLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(versionLabel)

        NSLayoutConstraint.activate([
            versionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 223),
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setsubtitle() {

        subtitle.text = "关注我们"
        subtitle.textColor = UIColor.white.withAlphaComponent(0.6)
        subtitle.font = .systemFont(ofSize: 16)
        subtitle.textAlignment = .center
        subtitle.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(subtitle)

        NSLayoutConstraint.activate([
            subtitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 290),
            subtitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20)
        ])
    }
    
    private func setupTableView() {

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 312),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.register(AboutCell.self, forCellReuseIdentifier: "AboutCell")

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setagreementText() {

        let text =
            "隐私协议 | 用户协议 | 会员协议\n" +
            "copyright©️ 2025 北京期音科技有限\n公司. 保留所有权利."

        let attr = NSMutableAttributedString(string: text)

        let fullRange = NSMakeRange(0, (text as NSString).length)
        attr.addAttribute(.foregroundColor, value: UIColor.white.withAlphaComponent(0.4), range: fullRange)
        attr.addAttribute(.font, value: UIFont.systemFont(ofSize: 12), range: fullRange)

        addLinkStyle(to: attr, text: "隐私协议", link: "app://privacy")
        addLinkStyle(to: attr, text: "用户协议", link: "app://user")
        addLinkStyle(to: attr, text: "会员协议", link: "app://vip")

        agreementView.attributedText = attr
        agreementView.backgroundColor = .clear
        agreementView.isEditable = false
        agreementView.isSelectable = true        // ← 必须！
        agreementView.isScrollEnabled = false
        agreementView.textAlignment = .center
        agreementView.dataDetectorTypes = []     // 不识别自动链接
        agreementView.delegate = self
        agreementView.linkTextAttributes = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.8),
            .underlineStyle: 0
        ]
        agreementView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(agreementView)

        NSLayoutConstraint.activate([
            agreementView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            agreementView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            agreementView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }

    private func addLinkStyle(to attr: NSMutableAttributedString, text: String, link: String) {
        let range = (attr.string as NSString).range(of: text)
        attr.addAttribute(.link, value: link, range: range)
    }
    
    
    private func openWeb(_ urlStr: String) {
        let url = URL(string: urlStr)!
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredBarTintColor = .black
        safariVC.preferredControlTintColor = .white
        present(safariVC, animated: true)
    }
}
// MARK: - UITableView 数据源
extension AboutViewController: UITableViewDataSource, UITableViewDelegate {

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
            withIdentifier: "AboutCell",
            for: indexPath
        ) as! AboutCell

        cell.configure(with: item)

        // 点击事件
        cell.onTap = { item.action() }

        return cell
    }
}

extension AboutViewController: UITextViewDelegate {

    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {

        switch URL.absoluteString {
        case "app://privacy":
            openWeb("https://developer.apple.com/documentation/TechnologyOverviews/adopting-liquid-glass")

        case "app://user":
            openWeb("https://developer.apple.com/documentation/TechnologyOverviews/adopting-liquid-glass")

        case "app://vip":
            openWeb("https://blog.csdn.net/weixin_38261823/article/details/139010117")

        default:
            break
        }

        return false
    }
}
