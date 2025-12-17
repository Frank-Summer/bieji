import UIKit

final class FeedbackTextView: UITextView {

    private let placeholderLabel = UILabel()

    init() {
        super.init(frame: .zero, textContainer: nil)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupUI() {

        backgroundColor = UIColor.white.withAlphaComponent(0.05)
        layer.cornerRadius = 8
        textColor = .white
        font = .systemFont(ofSize: 14)
        tintColor = .white

        // 内边距 12
        textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)

        // placeholder
        placeholderLabel.text = LocalizedText.text("feedback.placeholder.description")
        placeholderLabel.textColor = UIColor.white.withAlphaComponent(0.2)
        placeholderLabel.font = .systemFont(ofSize: 14)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        ])

        delegate = self
    }
}

extension FeedbackTextView: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
