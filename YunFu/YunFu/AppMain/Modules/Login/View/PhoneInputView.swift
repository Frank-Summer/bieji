import UIKit

final class PhoneInputView: UIView {

    // MARK: - Public
    var onAreaCodeChanged: ((_ item: CountryCodeItem) -> Void)?
    var onTextChanged: ((_ text: String) -> Void)?

    // MARK: - UI
    private let areaButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        btn.layer.cornerRadius = 9
        btn.tintColor = .white
        btn.setTitle("+1", for: .normal) // 🇺🇸 默认美国区号
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 32)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.minimumScaleFactor = 0.6
        return btn
    }()

    private let arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "chevron-down")
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let phoneContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        v.layer.cornerRadius = 9
        return v
    }()

    let phoneField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .white
        tf.tintColor = .white
        tf.keyboardType = .numberPad
        tf.attributedPlaceholder = NSAttributedString(
            string: LocalizedText.text("login_placeholder"),
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.4)]
        )
        return tf
    }()

    // MARK: - 限制
    private var currentMax: Int = 10
    private var currentFormat: String? = "(###) ###-####" // 🇺🇸 默认格式

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupObservers()
        applyDefaultUSFormat()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupObservers()
        applyDefaultUSFormat()
    }

    // MARK: - UI
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(areaButton)
        areaButton.addSubview(arrowImageView)
        addSubview(phoneContainer)
        phoneContainer.addSubview(phoneField)

        areaButton.addTarget(self, action: #selector(showAreaPicker), for: .touchUpInside)

        NSLayoutConstraint.activate([
            areaButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            areaButton.topAnchor.constraint(equalTo: topAnchor),
            areaButton.widthAnchor.constraint(equalToConstant: 79),
            areaButton.heightAnchor.constraint(equalToConstant: 48),

            arrowImageView.centerYAnchor.constraint(equalTo: areaButton.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: areaButton.trailingAnchor, constant: -12),
            arrowImageView.widthAnchor.constraint(equalToConstant: 12),
            arrowImageView.heightAnchor.constraint(equalToConstant: 12),

            phoneContainer.leadingAnchor.constraint(equalTo: areaButton.trailingAnchor, constant: 12),
            phoneContainer.topAnchor.constraint(equalTo: topAnchor),
            phoneContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            phoneContainer.heightAnchor.constraint(equalToConstant: 48),

            phoneField.leadingAnchor.constraint(equalTo: phoneContainer.leadingAnchor, constant: 12),
            phoneField.trailingAnchor.constraint(equalTo: phoneContainer.trailingAnchor, constant: -12),
            phoneField.topAnchor.constraint(equalTo: phoneContainer.topAnchor),
            phoneField.bottomAnchor.constraint(equalTo: phoneContainer.bottomAnchor)
        ])
    }

    // MARK: - 默认美国格式
    private func applyDefaultUSFormat() {
        areaButton.setTitle("+1", for: .normal)
        currentMax = 10
        currentFormat = "(###) ###-####"
        phoneField.text = ""
    }

    // MARK: - 输入监听
    private func setupObservers() {
        phoneField.delegate = self
        phoneField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }

    @objc private func textDidChange(_ sender: UITextField) {
        onTextChanged?(sender.text ?? "")
    }

    // MARK: - 动态调整 Padding
    private func adjustAreaButtonInsets() {
        guard let text = areaButton.title(for: .normal),
              let font = areaButton.titleLabel?.font else { return }

        let textWidth = (text as NSString).size(withAttributes: [.font: font]).width
        let buttonWidth: CGFloat = 79
        let arrowWidth: CGFloat = 12
        let minPadding: CGFloat = 4
        let available = buttonWidth - arrowWidth - 4
        let requiredPadding = max(minPadding, (available - textWidth) / 2)

        areaButton.contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: requiredPadding,
            bottom: 0,
            right: requiredPadding + 12
        )
    }
}

// MARK: - 输入格式化
extension PhoneInputView: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        if string.isEmpty { return true } // 删除
        if Int(string) == nil { return false } // 非数字拒绝

        let old = textField.text ?? ""
        let new = (old as NSString).replacingCharacters(in: range, with: string)
        let digits = new.filter { $0.isNumber }

        if digits.count > currentMax { return false }

        if let fmt = currentFormat {
            textField.text = applyFormat(digits: digits, format: fmt)
            onTextChanged?(textField.text ?? "")
            return false
        }

        return true
    }

    private func applyFormat(digits: String, format: String) -> String {
        var result = ""
        var idx = digits.startIndex

        for c in format {
            if c == "#" {
                if idx < digits.endIndex {
                    result.append(digits[idx])
                    idx = digits.index(after: idx)
                } else { break }
            } else {
                result.append(c)
            }
        }
        return result
    }
}

// MARK: - 区号选择
extension PhoneInputView {

    @objc private func showAreaPicker() {
        let listVC = AreaCodeSheetController()
        let sheet = PhoneBottomSheetController(height: 750, contentViewController: listVC)

        listVC.onSelect = { [weak self] item in
            guard let self else { return }

            self.areaButton.setTitle(item.code, for: .normal)
            self.adjustAreaButtonInsets()

            // 区号对应格式规则
            switch item.code {
            case "+1":  // 🇺🇸 美国
                self.currentMax = 10
                self.currentFormat = "(###) ###-####"
            case "+86": // 🇨🇳 中国大陆
                self.currentMax = 11
                self.currentFormat = "### #### ####"
            case "+81": // 🇯🇵 日本
                self.currentMax = 10
                self.currentFormat = "##-####-####"
            default:
                self.currentMax = item.maxLength
                self.currentFormat = nil
            }

            self.phoneField.text = ""
            self.onAreaCodeChanged?(item)
            sheet.dismiss(animated: true)
        }

        parentViewController?.present(sheet, animated: true)
    }
}

// MARK: - 对外访问属性
extension PhoneInputView {
    var text: String? {
        return phoneField.text
    }
}


// MARK: - 对外访问属性
extension PhoneInputView {
    /// 返回去除格式符号的手机号（只保留数字）
    var phone: String {
        let raw = phoneField.text ?? ""
        return raw.filter { $0.isNumber }
    }

    /// 返回当前选中的国家区号（默认 +1）
    var countryCode: String {
        return areaButton.title(for: .normal) ?? "+1"
    }
}

// MARK: - 找控制器
extension UIView {
    var parentViewController: UIViewController? {
        var r: UIResponder? = self
        while let next = r?.next {
            if let vc = next as? UIViewController { return vc }
            r = next
        }
        return nil
    }
}
