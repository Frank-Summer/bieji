import UIKit

final class AccountSecurityCell: UITableViewCell {

    // MARK: - Public
    var onTap: (() -> Void)?

    // MARK: - UI Elements
    private let tapView = UIView()
    private let container = UIView()

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let stateLabel = UILabel()
    private let rightIcon = UIImageView()

    // ⭐ 动态约束（隐藏 value / state 时不占位）
    private var valueToStateConstraint: NSLayoutConstraint!
    private var stateToArrowConstraint: NSLayoutConstraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        setupUI()
        addTapGesture()

        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 56).isActive = true
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - UI Setup
    private func setupUI() {

        // 🍎 点击区域
        tapView.translatesAutoresizingMaskIntoConstraints = false
        tapView.backgroundColor = .clear
        contentView.addSubview(tapView)

        NSLayoutConstraint.activate([
            tapView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        // 🍎 内容容器
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .clear
        container.isUserInteractionEnabled = false
        tapView.addSubview(container)

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: tapView.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: tapView.trailingAnchor, constant: -20),
            container.topAnchor.constraint(equalTo: tapView.topAnchor, constant: 8),
            container.bottomAnchor.constraint(equalTo: tapView.bottomAnchor, constant: -8)
        ])

        // 🍎 左侧标题
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 15)
        container.addSubview(titleLabel)

        // 🍎 value（中间）
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        valueLabel.font = .systemFont(ofSize: 15)
        valueLabel.lineBreakMode = .byTruncatingTail
        container.addSubview(valueLabel)

        // 🍎 state（靠右箭头左侧）
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        stateLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        stateLabel.font = .systemFont(ofSize: 15)
        container.addSubview(stateLabel)

        // 🍎 右箭头
        rightIcon.translatesAutoresizingMaskIntoConstraints = false
        rightIcon.contentMode = .scaleAspectFit
        container.addSubview(rightIcon)

        NSLayoutConstraint.activate([
            rightIcon.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            rightIcon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            rightIcon.widthAnchor.constraint(equalToConstant: 24),
            rightIcon.heightAnchor.constraint(equalToConstant: 24)
        ])

        // ⭐ 动态约束（state → arrow）
        stateToArrowConstraint = stateLabel.trailingAnchor.constraint(
            equalTo: rightIcon.leadingAnchor,
            constant: -12
        )

        NSLayoutConstraint.activate([
            stateToArrowConstraint,
            stateLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        // ⭐ 动态约束（value → state）
        valueToStateConstraint = valueLabel.trailingAnchor.constraint(
            equalTo: stateLabel.leadingAnchor,
            constant: -12
        )

        NSLayoutConstraint.activate([
            valueToStateConstraint,
            valueLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            valueLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 159)
        ])

        // title 最左侧
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: valueLabel.leadingAnchor)
        ])
    }

    // MARK: - Tap Gesture
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapView.addGestureRecognizer(tap)
    }

    @objc private func handleTap() {
        onTap?()
    }

    // MARK: - Configure
    func configure(with item: AccountSecurityItem) {

        titleLabel.text = item.title
        rightIcon.image = UIImage(named: item.icon)

        // ---- state ----
        let state = item.state?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if state.isEmpty {
            stateLabel.isHidden = true
            stateToArrowConstraint.constant = 0  // 不占位
        } else {
            stateLabel.isHidden = false
            stateLabel.text = state
            stateToArrowConstraint.constant = -12
        }

        // ---- value ----
        let value = item.value?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if value.isEmpty {
            valueLabel.isHidden = true
            valueToStateConstraint.constant = 0 // 不占位
        } else {
            valueLabel.isHidden = false
            valueLabel.text = value
            valueToStateConstraint.constant = -12
        }
    }
}
