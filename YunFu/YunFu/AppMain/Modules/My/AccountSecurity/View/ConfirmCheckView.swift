import UIKit

final class ConfirmCheckView: UIView {

    private let circleButton = UIButton(type: .custom)
    private let label = UILabel()

    private var isChecked = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        // 圆圈按钮
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        circleButton.layer.cornerRadius = 8
        circleButton.layer.borderWidth = 1
        circleButton.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        circleButton.backgroundColor = .clear
        circleButton.addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)

        addSubview(circleButton)

        NSLayoutConstraint.activate([
            circleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            circleButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleButton.widthAnchor.constraint(equalToConstant: 16),
            circleButton.heightAnchor.constraint(equalToConstant: 16)
        ])

        // 文字
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "已阅读并知晓重要提示"
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        label.font = .systemFont(ofSize: 15)

        addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: circleButton.trailingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        // 自动撑高
        heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
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

            // 加一个黑色对号
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
