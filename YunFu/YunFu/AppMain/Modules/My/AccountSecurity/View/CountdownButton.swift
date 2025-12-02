import UIKit


final class CountdownButton: UIButton {

    private var viewModel: CountdownButtonViewModel!

    init(viewModel: CountdownButtonViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        setupUI()
        bindViewModel()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupUI() {

        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)

        heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] seconds, isEnabled in
            guard let self = self else { return }

            if isEnabled {
                // 倒计时结束 → 白色可点击
                self.isEnabled = true
                self.backgroundColor = .white
                self.setTitle("下一步", for: .normal)
                self.setTitleColor(.black, for: .normal)

            } else {
                // 倒计时中 → 灰色不可点击
                self.isEnabled = false
                self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
                self.setTitle("下一步（\(seconds)）", for: .disabled)
                self.setTitleColor(.white, for: .disabled)
            }
        }
    }
}
