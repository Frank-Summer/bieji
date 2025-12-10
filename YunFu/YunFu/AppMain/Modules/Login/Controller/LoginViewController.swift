import UIKit
import GoogleSignIn

public final class LoginViewController: UIViewController {

    private let viewModel = LoginViewModel()
    public var onLoginSuccess: (() -> Void)?

    private let phoneInput = PhoneInputView()
    private let getCodeButton = UIButton(type: .system)
    private let autoRegisterLabel = UILabel()
    private var agreeCheckBox: CheckBoxLabelView!
    private let appleButton = LoginButton()
    private let googleButton = LoginButton()

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = LocalizedImage.image(named: "login_background")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - 生命周期
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    // MARK: - ViewModel 绑定
    private func bindViewModel() {
        
    }

    // MARK: - UI 构建
    private func setupUI() {
        view.backgroundColor = .black

        // 背景图
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // 手机号输入框
        view.addSubview(phoneInput)
        phoneInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            phoneInput.widthAnchor.constraint(equalToConstant: 298),
            phoneInput.heightAnchor.constraint(equalToConstant: 48)
        ])

        // 勾选框
        agreeCheckBox = CheckBoxLabelView(
            textKey: "login_agreement",
            onPrivacyTapped: {
                SafariWebViewController.present(
                    from: self,
                    url: "https://bieji.qiyin.art/privacy-policy",
                    title: "隐私协议"
                )
            },
            onTermsTapped: {
                SafariWebViewController.present(
                    from: self,
                    url: "https://bieji.qiyin.art/terms-of-service",
                    title: "用户协议"
                )
            }
        )
        agreeCheckBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(agreeCheckBox)
        NSLayoutConstraint.activate([
            agreeCheckBox.topAnchor.constraint(equalTo: phoneInput.bottomAnchor, constant: 20),
            agreeCheckBox.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            agreeCheckBox.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        agreeCheckBox.addTarget(self, action: #selector(agreeChanged(_:)), for: .valueChanged)

        // 获取验证码按钮
        getCodeButton.setTitle(LocalizedText.text("login_code"), for: .normal)
        getCodeButton.layer.cornerRadius = 12
        getCodeButton.layer.masksToBounds = true
        getCodeButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        getCodeButton.translatesAutoresizingMaskIntoConstraints = false
        getCodeButton.addTarget(self, action: #selector(onGetCodeTapped), for: .touchUpInside)
        view.addSubview(getCodeButton)
        NSLayoutConstraint.activate([
            getCodeButton.topAnchor.constraint(equalTo: agreeCheckBox.bottomAnchor, constant: 24),
            getCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getCodeButton.widthAnchor.constraint(equalToConstant: 295),
            getCodeButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        // 自动注册提示
        autoRegisterLabel.text = LocalizedText.text("login_hint")
        autoRegisterLabel.font = .systemFont(ofSize: 12)
        autoRegisterLabel.textColor = UIColor(white: 1, alpha: 0.4)
        autoRegisterLabel.textAlignment = .center
        autoRegisterLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(autoRegisterLabel)
        NSLayoutConstraint.activate([
            autoRegisterLabel.topAnchor.constraint(equalTo: getCodeButton.bottomAnchor, constant: 12),
            autoRegisterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // Apple 登录按钮
        appleButton.icon = UIImage(named: "login_apple")
        appleButton.titleKey = LocalizedText.text("login_Apple")
        appleButton.onTap = { [weak self] in
            guard let self else { return }
            self.handleThirdPartyLogin {
                self.viewModel.startAppleLogin(from: self.view)
            }
        }
        view.addSubview(appleButton)

        // Google 登录按钮
        googleButton.icon = UIImage(named: "login_google")
        googleButton.titleKey = LocalizedText.text("login_Google")
        googleButton.onTap = { [weak self] in
            guard let self else { return }
            self.handleThirdPartyLogin {
                if let rootVC = UIApplication.shared.connectedScenes
                    .compactMap({ ($0 as? UIWindowScene)?.keyWindow })
                    .first?.rootViewController {
                    self.viewModel.startGoogleLogin(from: rootVC)
                }
            }
        }
        view.addSubview(googleButton)

        NSLayoutConstraint.activate([
            appleButton.topAnchor.constraint(equalTo: autoRegisterLabel.bottomAnchor, constant: 190),
            appleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            googleButton.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 24),
            googleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // 初始化按钮状态
        applyButtonStyle(enabled: false)
        phoneInput.onTextChanged = { [weak self] _ in self?.updateButtonState() }
    }

    // MARK: - 检查勾选逻辑并弹窗
    private func handleThirdPartyLogin(_ action: @escaping () -> Void) {
        if !agreeCheckBox.isSelected {
            let sheet = CustomBottomSheetController()
            sheet.modalPresentationStyle = .overFullScreen

            // ✅ 弹窗回调逻辑
            sheet.onAgree = { [weak self] in
                guard let self else { return }
                self.agreeCheckBox.isSelected = true
                self.updateButtonState()
                action()
            }

            sheet.onDisagree = { [weak self] in
                guard let self else { return }
                print("🚪 用户拒绝协议，直接关闭")
            }

            present(sheet, animated: true)
            return
        }

        // 已勾选，直接执行
        action()
    }

    // MARK: - 按钮状态管理
    private func updateButtonState() {
        let hasPhone = !(phoneInput.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let enabled = hasPhone && agreeCheckBox.isSelected
        applyButtonStyle(enabled: enabled)
    }

    private func applyButtonStyle(enabled: Bool) {
        if enabled {
            getCodeButton.backgroundColor = .white
            getCodeButton.setTitleColor(.black, for: .normal)
        } else {
            getCodeButton.backgroundColor = UIColor(white: 1, alpha: 0.4)
            getCodeButton.setTitleColor(UIColor(white: 0, alpha: 0.3), for: .normal)
        }
    }

    @objc private func agreeChanged(_ sender: CheckBoxLabelView) {
        updateButtonState()
    }

    @objc private func onGetCodeTapped() {
        let phone = phoneInput.phone
        let countryCode = phoneInput.countryCode

        guard !phone.isEmpty else {
            AlertTipView.show(on: self.view, text: "请输入手机号")
            return
        }

        guard agreeCheckBox.isSelected else {
            AlertTipView.show(on: self.view, text: "请先阅读并同意《隐私协议》和《用户协议》")
            return
        }

        Task {
            let result = await AuthService.code(phone: phone, countryCode: countryCode, purpose: "LOGIN")
            print("📩 获取验证码结果: \(String(describing: result))")

            if result?.code == 0 {
                // ✅ 创建验证码页并传递参数
                let codeVC = LoginCodeViewController()
                codeVC.phone = phone
                codeVC.countryCode = countryCode
                codeVC.purpose = "LOGIN"

                // ✅ 登录成功后回调 → 返回主界面
                codeVC.onLoginSuccess = { [weak self] in
                    self?.onLoginSuccess?()  // 通知外层 window 切换 TabBar
                }

                codeVC.modalPresentationStyle = .fullScreen
                self.present(codeVC, animated: true)
            } else {
                AlertTipView.show(on: self.view, text: result?.msg ?? "验证码发送失败")
            }
        }
    }
}
