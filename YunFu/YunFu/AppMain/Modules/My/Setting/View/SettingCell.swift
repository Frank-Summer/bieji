import UIKit

final class SettingCell: UITableViewCell {

    var onTap: (() -> Void)?

    private let tapView = UIView()
    private let container = UIView()
    private let leftIcon = UIImageView()
    private let titleLabel = UILabel()
    private let rightIcon = UIImageView()

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

    private func setupUI() {

        // 点击层（整行）
        tapView.translatesAutoresizingMaskIntoConstraints = false
        tapView.backgroundColor = .clear
        contentView.addSubview(tapView)

        NSLayoutConstraint.activate([
            tapView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        // 背景容器
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(white: 1, alpha: 0.18)
        container.layer.cornerRadius = 12
        container.isUserInteractionEnabled = false
        tapView.addSubview(container)

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: tapView.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: tapView.trailingAnchor, constant: -20),
            container.topAnchor.constraint(equalTo: tapView.topAnchor, constant: 8),
            container.bottomAnchor.constraint(equalTo: tapView.bottomAnchor, constant: -8)
        ])

        // 左图标
        leftIcon.translatesAutoresizingMaskIntoConstraints = false
        leftIcon.contentMode = .scaleAspectFit
        container.addSubview(leftIcon)

        // 标题
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 15)
        container.addSubview(titleLabel)

        // 右箭头
        rightIcon.translatesAutoresizingMaskIntoConstraints = false
        rightIcon.contentMode = .scaleAspectFit
        container.addSubview(rightIcon)

        // 内边距 16
        NSLayoutConstraint.activate([

            leftIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            leftIcon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            leftIcon.widthAnchor.constraint(equalToConstant: 24),
            leftIcon.heightAnchor.constraint(equalToConstant: 24),

            rightIcon.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            rightIcon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            rightIcon.widthAnchor.constraint(equalToConstant: 24),
            rightIcon.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.leadingAnchor.constraint(equalTo: leftIcon.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: rightIcon.leadingAnchor, constant: -12),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }

    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapView.addGestureRecognizer(tap)
    }

    @objc private func handleTap() {
        onTap?()
    }

    func configure(with item: SettingItem) {
        leftIcon.image = UIImage(named: item.icon)
        titleLabel.text = item.title
        rightIcon.image = UIImage(named: item.rightIcon)
    }
}
