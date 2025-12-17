import UIKit

final class CustomBottomSheetController: UIViewController {

    // MARK: - Public 回调
    var onAgree: (() -> Void)?
    var onDisagree: (() -> Void)?

    // MARK: - UI 元素
    private let dimmingView = UIView()
    private let containerView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
    private let sheetHeight: CGFloat = 234
    private let textView = UITextView()
    private let primaryButton = UIButton(type: .system)
    private let secondaryButton = UIButton(type: .system)

    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextView()
        setupButtons()
        showSheet()
    }

    // MARK: - UI 布局
    private func setupUI() {
        // ✅ 背景遮罩
        dimmingView.backgroundColor = UIColor.clear
        dimmingView.frame = view.bounds
        dimmingView.alpha = 0
        view.addSubview(dimmingView)

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSheet))
        dimmingView.addGestureRecognizer(tap)

        // ✅ 毛玻璃容器
        containerView.layer.cornerRadius = 32
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.clipsToBounds = true

        // 半透明叠加层
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        containerView.contentView.addSubview(overlay)
        NSLayoutConstraint.activate([
            overlay.topAnchor.constraint(equalTo: containerView.contentView.topAnchor),
            overlay.leadingAnchor.constraint(equalTo: containerView.contentView.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: containerView.contentView.trailingAnchor),
            overlay.bottomAnchor.constraint(equalTo: containerView.contentView.bottomAnchor)
        ])

        // 初始位置在屏幕底部
        containerView.frame = CGRect(
            x: 0,
            y: view.bounds.height,
            width: view.bounds.width,
            height: sheetHeight
        )
        view.addSubview(containerView)
    }

    // MARK: - 文本部分（可点击）
    private func setupTextView() {
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.textAlignment = .center
        textView.delegate = self
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.white
        ]
        textView.translatesAutoresizingMaskIntoConstraints = false
        containerView.contentView.addSubview(textView)

        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: containerView.contentView.centerXAnchor),
            textView.topAnchor.constraint(equalTo: containerView.contentView.topAnchor,constant: 24),
            textView.leadingAnchor.constraint(equalTo: containerView.contentView.leadingAnchor, constant: 24),
            textView.trailingAnchor.constraint(equalTo: containerView.contentView.trailingAnchor, constant: -24)
        ])

        applyLocalizedText()
    }

    private func applyLocalizedText() {
        let fullText = LocalizedText.text("login.agreement.text")

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping

        // 基础文本属性
        let attr = NSMutableAttributedString(
            string: fullText,
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 15, weight: .medium),
                .paragraphStyle: paragraphStyle
            ]
        )

        // 定义可点击的关键字及链接
        let ns = fullText as NSString
        let ranges: [(String, String)] = [
            ("《隐私协议》", "internal://privacy"),
            ("《用户协议》", "internal://terms"),
            ("Privacy Policy", "internal://privacy"),
            ("User Agreement", "internal://terms")
        ]

        // ✅ 下划线和颜色样式
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.white
        ]

        // 添加链接属性
        for (keyword, link) in ranges {
            let range = ns.range(of: keyword)
            if range.location != NSNotFound {
                attr.addAttributes(linkAttributes, range: range)
                attr.addAttribute(.link, value: link, range: range)
            }
        }

        // ✅ 关闭自动链接检测，防止冲突
        textView.dataDetectorTypes = []
        textView.isEditable = false
        textView.isSelectable = true
        textView.delegate = self
        textView.linkTextAttributes = linkAttributes

        textView.attributedText = attr
        textView.textAlignment = .center
    }

    // MARK: - 按钮部分
    private func setupButtons() {
        // 白底黑字按钮（同意）
        primaryButton.setTitle(LocalizedText.text("login.popup.agree"), for: .normal)
        primaryButton.backgroundColor = .white
        primaryButton.setTitleColor(.black, for: .normal)
        primaryButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        primaryButton.layer.cornerRadius = 12
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        primaryButton.addTarget(self, action: #selector(onPrimaryTapped), for: .touchUpInside)
        containerView.contentView.addSubview(primaryButton)

        // 透明白字按钮（不同意）
        secondaryButton.setTitle(LocalizedText.text("login.popup.disagree"), for: .normal)
        secondaryButton.backgroundColor = .clear
        secondaryButton.setTitleColor(.white, for: .normal)
        secondaryButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        secondaryButton.layer.cornerRadius = 12
        secondaryButton.translatesAutoresizingMaskIntoConstraints = false
        secondaryButton.addTarget(self, action: #selector(onDisagreeTapped), for: .touchUpInside)
        containerView.contentView.addSubview(secondaryButton)

        NSLayoutConstraint.activate([
            primaryButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            primaryButton.centerXAnchor.constraint(equalTo: containerView.contentView.centerXAnchor),
            primaryButton.widthAnchor.constraint(equalToConstant: 295),
            primaryButton.heightAnchor.constraint(equalToConstant: 48),

            secondaryButton.topAnchor.constraint(equalTo: primaryButton.bottomAnchor, constant: 12),
            secondaryButton.centerXAnchor.constraint(equalTo: containerView.contentView.centerXAnchor),
            secondaryButton.widthAnchor.constraint(equalToConstant: 295),
            secondaryButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    // MARK: - 动画控制
    private func showSheet() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.dimmingView.alpha = 1
            self.containerView.frame.origin.y = self.view.bounds.height - self.sheetHeight
        }
    }

    @objc private func dismissSheet() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmingView.alpha = 0
            self.containerView.frame.origin.y = self.view.bounds.height
        }) { _ in
            self.dismiss(animated: false)
        }
    }

    @objc private func onPrimaryTapped() {
        print("✅ 用户点击 同意并继续")
        onAgree?()        // 通知外部：用户同意
        dismissSheet()
    }

    @objc private func onDisagreeTapped() {
        print("❌ 用户点击 不同意并退出")
        onDisagree?()     // 通知外部：用户不同意
        dismissSheet()
    }
}

// MARK: - 链接点击
extension CustomBottomSheetController: UITextViewDelegate {
    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString.contains("privacy") {
            SafariWebViewController.present(
                from: self,
                url: "https://bieji.qiyin.art/privacy-policy",
                title: "隐私协议"
            )
            return false
        }

        if URL.absoluteString.contains("terms") {
            SafariWebViewController.present(
                from: self,
                url: "https://bieji.qiyin.art/terms-of-service",
                title: "用户协议"
            )
            return false
        }

        return false
    }
}
