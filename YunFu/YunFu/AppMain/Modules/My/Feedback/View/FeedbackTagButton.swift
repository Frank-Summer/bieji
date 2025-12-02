import UIKit

final class FeedbackTagButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupUI() {
        titleLabel?.font = .systemFont(ofSize: 14)
        layer.cornerRadius = 16
        layer.masksToBounds = true

        contentEdgeInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)

        // 默认未选中
        backgroundColor = UIColor.white.withAlphaComponent(0.1)
        setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
    }

    func update(selected: Bool) {
        if selected {
            backgroundColor = .white
            setTitleColor(.black, for: .normal)
        } else {
            backgroundColor = UIColor.white.withAlphaComponent(0.1)
            setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
        }
    }
}
