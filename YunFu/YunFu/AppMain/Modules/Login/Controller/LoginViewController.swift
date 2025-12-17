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

    // MARK: - 是否中文
    private var isChinese: Bool {
        guard let lang = Locale.preferredLanguages.first else { return false }
        return lang.hasPrefix("zh")
    }

    // MARK: - 生命周期
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    // MARK: - ViewModel 绑定
    private func bindViewModel() {

        viewModel.onLoginSuccess = { [weak self] user in
            print("✅ 第三方登录成功：\(user.email)")
            self?.onLoginSuccess?()
        }

        viewModel.onLoginError = { [weak self] msg in
            guard let self = self else { return }
            AlertTipView.show(on: self.view, text: msg)
        }
    }
}


// MARK: - UI 构建
private extension LoginViewController {

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

        // ----------------------------------------------------
        // 🇨🇳 中文模式
        // ----------------------------------------------------
        if isChinese {

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
                textKey: "login.agreement.text",
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

            // 获取验证码
            getCodeButton.setTitle(LocalizedText.text("login.button.sendCode"), for: .normal)
            getCodeButton.layer.cornerRadius = 12
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
            autoRegisterLabel.text = LocalizedText.text("login.hint.autoRegister")
            autoRegisterLabel.font = .systemFont(ofSize: 12)
            autoRegisterLabel.textColor = UIColor(white: 1, alpha: 0.4)
            autoRegisterLabel.textAlignment = .center
            autoRegisterLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(autoRegisterLabel)
            NSLayoutConstraint.activate([
                autoRegisterLabel.topAnchor.constraint(equalTo: getCodeButton.bottomAnchor, constant: 12),
                autoRegisterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])

            // Apple 登录
            appleButton.icon = UIImage(named: "login_apple")
            appleButton.titleKey = LocalizedText.text("login.button.apple")
            appleButton.translatesAutoresizingMaskIntoConstraints = false
            appleButton.addTarget(self, action: #selector(onAppleLoginTapped), for: .touchUpInside)
            view.addSubview(appleButton)

            NSLayoutConstraint.activate([
                appleButton.topAnchor.constraint(equalTo: autoRegisterLabel.bottomAnchor, constant: 190),
                appleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])

            applyButtonStyle(enabled: false)
            phoneInput.onTextChanged = { [weak self] _ in
                self?.updateButtonState()
            }
            return
        }

        // ----------------------------------------------------
        // 🇺🇸 英文模式
        // ----------------------------------------------------

        appleButton.icon = UIImage(named: "login_apple")
        appleButton.titleKey = "Sign in with Apple"
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.addTarget(self, action: #selector(onAppleLoginTapped), for: .touchUpInside)
        view.addSubview(appleButton)

        googleButton.icon = UIImage(named: "login_google")
        googleButton.titleKey = "Sign in with Google"
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.addTarget(self, action: #selector(onGoogleLoginTapped), for: .touchUpInside)
        view.addSubview(googleButton)

        agreeCheckBox = CheckBoxLabelView(
            textKey: "login.agreement.text",
            onPrivacyTapped: {
                SafariWebViewController.present(
                    from: self,
                    url: "https://bieji.qiyin.art/privacy-policy",
                    title: "Privacy Policy"
                )
            },
            onTermsTapped: {
                SafariWebViewController.present(
                    from: self,
                    url: "https://bieji.qiyin.art/terms-of-service",
                    title: "Terms of Use"
                )
            }
        )
        agreeCheckBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(agreeCheckBox)

        NSLayoutConstraint.activate([
            appleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),

            googleButton.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 20),
            googleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            agreeCheckBox.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 26),
            agreeCheckBox.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            agreeCheckBox.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


// MARK: - 第三方登录点击（已改为 BottomSheet）
private extension LoginViewController {

    @objc func onAppleLoginTapped() {
        guard agreeCheckBox.isSelected else {
            showPrivacyBottomSheet()
            return
        }
        viewModel.startAppleLogin(from: view)
    }

    @objc func onGoogleLoginTapped() {
        guard agreeCheckBox.isSelected else {
            showPrivacyBottomSheet()
            return
        }
        viewModel.startGoogleLogin(from: self)
    }

    func showPrivacyBottomSheet() {
        let sheet = CustomBottomSheetController()
        sheet.modalPresentationStyle = .overFullScreen
        sheet.modalTransitionStyle = .crossDissolve

        sheet.onAgree = { [weak self] in
            self?.agreeCheckBox.isSelected = true
        }

        sheet.onDisagree = {
            // 不同意：什么都不做，留在当前页
        }

        present(sheet, animated: false)
    }
}


// MARK: - 短信登录逻辑
private extension LoginViewController {

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

    @objc private func onGetCodeTapped() {
        let phone = phoneInput.phone
        let countryCode = phoneInput.countryCode

        guard !phone.isEmpty else {
            AlertTipView.show(on: self.view, text: "请输入手机号")
            return
        }

        guard agreeCheckBox.isSelected else {
            showPrivacyBottomSheet()
            return
        }

        Task {
            let result = await AuthService.code(
                phone: phone,
                countryCode: countryCode,
                purpose: "LOGIN"
            )

            if result?.code == 0 {
                let codeVC = LoginCodeViewController()
                codeVC.phone = phone
                codeVC.countryCode = countryCode
                codeVC.purpose = "LOGIN"
                codeVC.onLoginSuccess = { [weak self] in
                    self?.onLoginSuccess?()
                }
                codeVC.modalPresentationStyle = .fullScreen
                self.present(codeVC, animated: true)
            } else {
                AlertTipView.show(on: self.view, text: result?.msg ?? "验证码发送失败")
            }
        }
    }
}
