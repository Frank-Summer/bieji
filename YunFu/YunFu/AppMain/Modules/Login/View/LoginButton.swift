import UIKit

public final class LoginButton: UIControl {

    // MARK: - Subviews
    private let iconImageView = UIImageView()
    private let titleLabelView = UILabel()
    private let stackView = UIStackView()

    // MARK: - Public properties
    public var icon: UIImage? {
        didSet {
            iconImageView.image = icon
            iconImageView.isHidden = (icon == nil)
        }
    }

    public var titleKey: String? {
        didSet {
            if let key = titleKey {
                titleLabelView.text = LocalizedText.text(key)
            }
        }
    }

    public var onTap: (() -> Void)?

    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        backgroundColor = .clear

        // icon
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        // title
        titleLabelView.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabelView.textColor = .white
        titleLabelView.textAlignment = .center

        // stackView：水平居中排列 icon + label
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabelView)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),
            widthAnchor.constraint(equalToConstant: 295),

            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }

    // MARK: - 点击动画
    @objc private func tapped() {
        onTap?()
        animatePress()
    }

    private func animatePress() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.6
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.alpha = 1.0
            }
        }
    }
}
