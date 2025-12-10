import UIKit

final class AlertTipView: UIView {

    // MARK: - 初始化
    init(text: String) {
        super.init(frame: .zero)
        setupUI(text: text)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(text: String) {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.masksToBounds = true

        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    // MARK: - 显示方法
    static func show(on view: UIView, text: String) {
        let tip = AlertTipView(text: text)
        tip.alpha = 0
        tip.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tip)

        NSLayoutConstraint.activate([
            tip.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tip.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])

        // 动画出现
        UIView.animate(withDuration: 0.25) {
            tip.alpha = 1
        }

        // 自动消失
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.25, animations: {
                tip.alpha = 0
            }, completion: { _ in
                tip.removeFromSuperview()
            })
        }
    }
}
