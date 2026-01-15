import UIKit
import Foundation
import SwiftUI

/// 我的页面
class TUOKOUXIUSwiftMy: TUOKOUXIUSwiftBaseVC {

    // MARK: - UI 属性
    private var settingsWindow: UIWindow?   // ✅ 强引用 Window

    private let headerContainer = UIView()

    // 🔴 临时按钮
    private let debugButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("调 getlist（调试）", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    public let profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 33
        imageView.layer.masksToBounds = true
        return imageView
    }()

    public let userName: UILabel = {
        let label = UILabel()
        label.text = "快乐不快乐..."
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public let vipDate: UILabel = {
        let label = UILabel()
        label.text = "2025.06.08"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public let vipLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    public let setting: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        setupHeaderUI()
        setupSwiftUIButtons()
        setupDebugButton()
    }

    // MARK: - Header
    private func setupHeaderUI() {
        headerContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerContainer)

        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            headerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerContainer.heightAnchor.constraint(equalToConstant: 76)
        ])

        headerContainer.addSubview(profilePicture)
        headerContainer.addSubview(userName)
        headerContainer.addSubview(vipDate)
        headerContainer.addSubview(vipLogo)
        headerContainer.addSubview(setting)

        NSLayoutConstraint.activate([
            profilePicture.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor),
            profilePicture.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
            profilePicture.widthAnchor.constraint(equalToConstant: 66),
            profilePicture.heightAnchor.constraint(equalToConstant: 66),

            userName.leadingAnchor.constraint(equalTo: profilePicture.trailingAnchor, constant: 7),
            userName.topAnchor.constraint(equalTo: profilePicture.topAnchor, constant: 5),

            vipDate.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            vipDate.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 4),

            vipLogo.leadingAnchor.constraint(equalTo: vipDate.trailingAnchor, constant: 5),
            vipLogo.centerYAnchor.constraint(equalTo: vipDate.centerYAnchor),
            vipLogo.widthAnchor.constraint(equalToConstant: 16),
            vipLogo.heightAnchor.constraint(equalToConstant: 16),

            setting.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
            setting.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor),
            setting.widthAnchor.constraint(equalToConstant: 24),
            setting.heightAnchor.constraint(equalToConstant: 24)
        ])

        profilePicture.image = UIImage(named: "logo")
        vipLogo.image = UIImage(named: "my_vip")
        setting.image = UIImage(named: "my_setting")

        let tap = UITapGestureRecognizer(target: self, action: #selector(openSettings))
        setting.addGestureRecognizer(tap)
    }

    // MARK: - SwiftUI 按钮
    private func setupSwiftUIButtons() {
        let buttonRow = MyButtonRowView(actions: .init(
            onMyCollection: { [weak self] in
                let vc = MyHistoryViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            },
            onMyRecent: { [weak self] in
                let vc = MyHistoryViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        ))

        let hostingVC = UIHostingController(rootView: buttonRow)
        hostingVC.view.backgroundColor = .clear

        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)

        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingVC.view.topAnchor.constraint(equalTo: headerContainer.bottomAnchor),
            hostingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - 🔴 临时调试按钮
    private func setupDebugButton() {
        view.addSubview(debugButton)

        NSLayoutConstraint.activate([
            debugButton.topAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: 120),
            debugButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            debugButton.widthAnchor.constraint(equalToConstant: 160),
            debugButton.heightAnchor.constraint(equalToConstant: 36)
        ])

        debugButton.addTarget(self, action: #selector(callGetList), for: .touchUpInside)
    }

    // MARK: - 调用 getlist
    @objc private func callGetList() {
        print("🟢 点击调试按钮，调用 getlist")

        Task {
            let _ = await AuthService.getScenesList()
        }
    }

    // MARK: - 打开设置页
    @objc private func openSettings() {
        let settingsVC = SettingsViewController()
        settingsVC.onClose = { [weak self] in
            self?.settingsWindow?.isHidden = true
            self?.settingsWindow = nil
        }

        let nav = UINavigationController(rootViewController: settingsVC)
        let win = UIWindow(frame: UIScreen.main.bounds)
        win.rootViewController = nav
        win.windowLevel = .alert + 1
        win.makeKeyAndVisible()

        self.settingsWindow = win
    }
}
