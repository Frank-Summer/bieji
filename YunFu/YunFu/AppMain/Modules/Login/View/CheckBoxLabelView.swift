import UIKit

final class CheckBoxLabelView: UIControl {

    override var isSelected: Bool {
        didSet { updateUI() }
    }

    var onPrivacyTapped: (() -> Void)?
    var onTermsTapped: (() -> Void)?

    private let textKey: String
    private let stackView = UIStackView()
    private let boxView = UIView()
    private let checkLabel = UILabel()
    private let textView = UITextView()

    init(
        textKey: String,
        onPrivacyTapped: (() -> Void)? = nil,
        onTermsTapped: (() -> Void)? = nil
    ) {
        self.textKey = textKey
        self.onPrivacyTapped = onPrivacyTapped
        self.onTermsTapped = onTermsTapped
        super.init(frame: .zero)
        setupUI()
        applyLocalizedText()
        updateUI()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupUI() {
        backgroundColor = .clear
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))

        // ✅ StackView 控制勾选框 + 文本布局
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        // ✅ 勾选框
        boxView.layer.cornerRadius = 4
        boxView.layer.borderWidth = 1
        boxView.layer.borderColor = UIColor.white.cgColor
        boxView.backgroundColor = .clear
        boxView.translatesAutoresizingMaskIntoConstraints = false
        boxView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        boxView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        stackView.addArrangedSubview(boxView)

        checkLabel.text = "✓"
        checkLabel.textColor = .black
        checkLabel.textAlignment = .center
        checkLabel.font = .boldSystemFont(ofSize: 12)
        checkLabel.isHidden = true
        checkLabel.translatesAutoresizingMaskIntoConstraints = false
        boxView.addSubview(checkLabel)

        NSLayoutConstraint.activate([
            checkLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor),
            checkLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor),
            checkLabel.topAnchor.constraint(equalTo: boxView.topAnchor),
            checkLabel.bottomAnchor.constraint(equalTo: boxView.bottomAnchor)
        ])

        // ✅ 文本视图（多行 + 段落居中）
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.textAlignment = .center
        textView.delegate = self
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.white
        ]
        textView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(textView)

        textView.setContentCompressionResistancePriority(.required, for: .vertical)
        textView.setContentHuggingPriority(.required, for: .vertical)
    }

    private func applyLocalizedText() {
        let fullText = LocalizedText.text(textKey)

        // ✅ 使用段落样式确保多行整体居中
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping

        let attr = NSMutableAttributedString(
            string: fullText,
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 14),
                .paragraphStyle: paragraphStyle
            ]
        )

        let ns = fullText as NSString
        let ranges: [(String, String)] = [
            ("《隐私协议》", "internal://privacy"),
            ("《用户协议》", "internal://terms"),
            ("Privacy Policy", "internal://privacy"),
            ("Terms of Use", "internal://terms")
        ]

        let linkAttrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.white
        ]

        for (keyword, link) in ranges {
            let range = ns.range(of: keyword)
            if range.location != NSNotFound {
                attr.addAttributes(linkAttrs, range: range)
                attr.addAttribute(.link, value: link, range: range)
            }
        }

        textView.attributedText = attr
        textView.textContainer.maximumNumberOfLines = 0
    }

    private func updateUI() {
        boxView.backgroundColor = isSelected ? .white : .clear
        checkLabel.isHidden = !isSelected
    }

    @objc private func handleTap() {
        isSelected.toggle()
        sendActions(for: .valueChanged)
    }
}

extension CheckBoxLabelView: UITextViewDelegate {
    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString.contains("privacy") {
            onPrivacyTapped?()
            return false
        }
        if URL.absoluteString.contains("terms") {
            onTermsTapped?()
            return false
        }
        return false
    }
}
