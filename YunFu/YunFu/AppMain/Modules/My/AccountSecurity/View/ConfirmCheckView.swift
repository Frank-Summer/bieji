import UIKit

final class ConfirmCheckView: UIView {

    private let circleButton = UIButton(type: .custom)
    private let label = UILabel()
    private let hStack = UIStackView()

    private var isChecked = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        // MARK: - HStack（圆圈 + 文本放一起）
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.spacing = 8
        hStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(hStack)

        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            hStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])

        // MARK: - 圆圈
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        circleButton.layer.cornerRadius = 8
        circleButton.layer.borderWidth = 1
        circleButton.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        circleButton.backgroundColor = .clear
        circleButton.addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)

        NSLayoutConstraint.activate([
            circleButton.widthAnchor.constraint(equalToConstant: 16),
            circleButton.heightAnchor.constraint(equalToConstant: 16)
        ])

        hStack.addArrangedSubview(circleButton)

        // MARK: - 文本
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(LocalizedText.text("account.delete.read"))"
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0  // ← 多行支持
        label.textAlignment = .center  // ← 多行居中

        hStack.addArrangedSubview(label)

        // 为了让 label 在换行时不会挤压圆圈
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    // MARK: - 切换选中状态
    @objc private func toggleCheck() {
        isChecked.toggle()
        updateAppearance()
    }

    private func updateAppearance() {
        if isChecked {
            circleButton.backgroundColor = .white
            circleButton.layer.borderColor = UIColor.white.cgColor

            let checkmark = UIImage(systemName: "checkmark",
                                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .bold))
            circleButton.setImage(checkmark, for: .normal)
            circleButton.tintColor = .black

        } else {
            circleButton.backgroundColor = .clear
            circleButton.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            circleButton.setImage(nil, for: .normal)
        }
    }

    /// 外部获取状态
    public func isConfirmed() -> Bool {
        return isChecked
    }
}
