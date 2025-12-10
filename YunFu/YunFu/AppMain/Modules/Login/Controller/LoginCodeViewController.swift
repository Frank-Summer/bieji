import UIKit

public final class LoginCodeViewController: UIViewController {
    
    var onLoginSuccess: (() -> Void)?
    // MARK: - 接收外部参数
        var phone: String = ""
        var countryCode: String = ""
        var purpose: String = ""
    

    // MARK: - UI 元素
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logincode_background")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedText.text("login_enter_code")
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let hintLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let pinView = SVPinView()
    private let resendButton = UIButton(type: .system)

    private var countdownTimer: Timer?
    private var remainingSeconds: Int = 60

    // MARK: - 生命周期
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTopBar()
        setupPinView()
        setupResendButton()
        startCountdown()
    }

    // MARK: - 构建 UI
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        view.addSubview(titleLabel)
        view.addSubview(hintLabel)
        

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),

            hintLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            hintLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
        
        hintLabel.text = "\(LocalizedText.text("login_enter_hint")) \(countryCode) \(phone)"

    }

    // MARK: - 顶部返回栏
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
            self?.dismiss(animated: true)
        }
    }

    // MARK: - 验证码输入框（SVPinView）
    private func setupPinView() {
        pinView.pinLength = 6
        pinView.shouldSecureText = false
        pinView.allowsWhitespaces = false
        pinView.interSpace = 12
        pinView.textColor = .white
        pinView.keyboardType = .numberPad
        pinView.style = .box

        // ✅ 默认样式（无边框）
        pinView.fieldBackgroundColor = UIColor(white: 1, alpha: 0.1)
        pinView.borderLineColor = .clear
        pinView.borderLineThickness = 0

        // ✅ 高亮样式（白色边框 + 圆角）
        pinView.activeFieldBackgroundColor = UIColor(white: 1, alpha: 0.15)
        pinView.activeBorderLineColor = .white
        pinView.activeBorderLineThickness = 2.0
        pinView.fieldCornerRadius = 10

        pinView.didFinishCallback = { [weak self] code in
            print("✅ 用户输入验证码：\(code)")
            self?.verifyCode(code)
        }

        view.addSubview(pinView)
        pinView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pinView.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 16),
            pinView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pinView.widthAnchor.constraint(equalToConstant: 300),
            pinView.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    // MARK: - 重新获取按钮
    private func setupResendButton() {
        resendButton.setTitle("\(LocalizedText.text("login_resend"))  (60s)", for: .normal)
        resendButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        resendButton.titleLabel?.font = .systemFont(ofSize: 14)
        resendButton.isEnabled = false
        resendButton.translatesAutoresizingMaskIntoConstraints = false
        resendButton.addTarget(self, action: #selector(onResendTapped), for: .touchUpInside)
        view.addSubview(resendButton)

        NSLayoutConstraint.activate([
            resendButton.topAnchor.constraint(equalTo: pinView.bottomAnchor, constant: 24),
            resendButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }

    // MARK: - 点击重新获取验证码
    @objc private func onResendTapped() {
        print("📨 重新获取验证码")
        startCountdown()
        Task {
            let result = await AuthService.code(phone: phone, countryCode: countryCode, purpose: purpose)
            print("📩 获取验证码结果: \(String(describing: result))")
        }
        // TODO: 调用后端重发验证码接口
    }
    
    

    // MARK: - 倒计时逻辑（无闪烁）
    private func startCountdown() {
        countdownTimer?.invalidate()
        remainingSeconds = 60

        resendButton.isEnabled = false
        resendButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        resendButton.setTitle("\(LocalizedText.text("login_resend")) (60s)", for: .normal)

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            self.remainingSeconds -= 1

            if self.remainingSeconds > 0 {
                UIView.performWithoutAnimation {
                    self.resendButton.setTitle("\(LocalizedText.text("login_resend"))  (\(self.remainingSeconds)s)", for: .normal)
                    self.resendButton.layoutIfNeeded()
                }
            } else {
                timer.invalidate()
                UIView.performWithoutAnimation {
                    self.resendButton.setTitle("\(LocalizedText.text("login_resend")) ", for: .normal)
                    self.resendButton.setTitleColor(.white, for: .normal)
                    self.resendButton.layoutIfNeeded()
                }
                self.resendButton.isEnabled = true
            }
        }

        RunLoop.current.add(countdownTimer!, forMode: .common)
    }

    // MARK: - 验证逻辑
    private func verifyCode(_ code: String) {
        guard code.count == 6 else { return }
        print("🚀 验证码验证中：\(code)")

        Task {
            let result = await AuthService.login_phone_code(
                phone: phone,
                countryCode: countryCode,
                verificationCode: code
            )

            print("📩 登录结果: \(String(describing: result))")

            if result?.code == 0 {
                DispatchQueue.main.async {
                    // ✅ 登录成功回调
                    self.dismiss(animated: true) {
                        self.onLoginSuccess?()
                    }
                }
            } else {
                AlertTipView.show(on: self.view, text: result?.msg ?? "登录失败")
            }
        }
    }
}
