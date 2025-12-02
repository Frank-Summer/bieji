import UIKit

final class FeedbackTagListView: UIView {

    private let viewModel: FeedbackTypeViewModel
    private var buttons: [FeedbackTagButton] = []

    init(viewModel: FeedbackTypeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupButtons()
        bindViewModel()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupButtons() {
        viewModel.items.enumerated().forEach { (i, title) in
            let btn = FeedbackTagButton()
            btn.setTitle(title, for: .normal)
            btn.tag = i
            btn.addTarget(self, action: #selector(tagTapped(_:)), for: .touchUpInside)
            addSubview(btn)
            buttons.append(btn)
        }
    }

    private func bindViewModel() {
        viewModel.onSelectedChange = { [weak self] selected in
            guard let self = self else { return }
            for (i, btn) in self.buttons.enumerated() {
                btn.update(selected: i == selected)
            }
        }
    }

    @objc private func tagTapped(_ sender: UIButton) {
        viewModel.select(index: sender.tag)
    }

    // MARK: - 自动布局尺寸（修复死循环）
    override var intrinsicContentSize: CGSize {
        let maxWidth = UIScreen.main.bounds.width - 40
        var x: CGFloat = 0
        var y: CGFloat = 0
        let spacing: CGFloat = 12
        let height: CGFloat = 32

        for btn in buttons {
            btn.sizeToFit()
            let width = btn.bounds.width

            if x + width > maxWidth {
                x = 0
                y += height + spacing
            }

            x += width + spacing
        }
        return CGSize(width: UIView.noIntrinsicMetric, height: y + height)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let maxWidth = bounds.width
        var x: CGFloat = 0
        var y: CGFloat = 0
        let spacing: CGFloat = 12
        let height: CGFloat = 32

        for btn in buttons {
            btn.sizeToFit()
            let width = btn.bounds.width

            if x + width > maxWidth {
                x = 0
                y += height + spacing
            }

            btn.frame = CGRect(x: x, y: y, width: width, height: height)
            x += width + spacing
        }
    }
}
