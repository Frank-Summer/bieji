import UIKit

final class PhoneBottomSheetController: UIViewController {

    // MARK: - UI
    private let dimmingView = UIView()
    private let containerView = UIView()
    private let indicator = UIView()

    private var contentViewController: UIViewController?
    private let sheetHeight: CGFloat

    // 拖拽属性
    private var panStartY: CGFloat = 0

    // MARK: - Init：允许传入 VC
    init(height: CGFloat, contentViewController: UIViewController) {
        self.sheetHeight = height
        self.contentViewController = contentViewController
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }

    // MARK: - Init：如果有人仍然想传 UIView，也支持
    init(height: CGFloat, contentView: UIView) {
        self.sheetHeight = height
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen

        let vc = UIViewController()
        vc.view = contentView
        self.contentViewController = vc
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPanGesture()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentSheet()
    }

    // MARK: - UI
    private func setupUI() {

        // 背景遮罩
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimmingView.alpha = 0
        dimmingView.frame = view.bounds
        view.addSubview(dimmingView)

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSheet))
        dimmingView.addGestureRecognizer(tap)

        // 容器
        containerView.backgroundColor = UIColor(white: 0.12, alpha: 1)
        containerView.layer.cornerRadius = 16
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.clipsToBounds = true

        containerView.frame = CGRect(
            x: 0,
            y: view.bounds.height,
            width: view.bounds.width,
            height: sheetHeight
        )
        view.addSubview(containerView)

        // 顶部 indicator
        indicator.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        indicator.layer.cornerRadius = 2
        indicator.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            indicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 36),
            indicator.heightAnchor.constraint(equalToConstant: 4)
        ])

        // ⭐ 加载 contentViewController
        if let childVC = contentViewController {
            addChild(childVC)
            childVC.view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(childVC.view)

            NSLayoutConstraint.activate([
                childVC.view.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 12),
                childVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                childVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                childVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])

            childVC.didMove(toParent: self)
        }
    }

    // MARK: - Gesture
    private func setupPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        containerView.addGestureRecognizer(pan)
    }

    @objc private func handlePan(_ pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: view)

        switch pan.state {

        case .began:
            panStartY = containerView.frame.minY

        case .changed:
            let newY = max(panStartY + translation.y, view.bounds.height - sheetHeight)
            containerView.frame.origin.y = newY
            dimmingView.alpha = max(0, 1 - (newY - (view.bounds.height - sheetHeight)) / 200)

        case .ended, .cancelled:
            let velocity = pan.velocity(in: view).y
            if translation.y > 100 || velocity > 800 {
                dismissSheet()
            } else {
                restoreSheet()
            }

        default: break
        }
    }

    // MARK: - Animations
    private func presentSheet() {
        UIView.animate(withDuration: 0.25) {
            self.containerView.frame.origin.y = self.view.bounds.height - self.sheetHeight
            self.dimmingView.alpha = 1
        }
    }

    private func restoreSheet() {
        UIView.animate(withDuration: 0.25) {
            self.containerView.frame.origin.y = self.view.bounds.height - self.sheetHeight
            self.dimmingView.alpha = 1
        }
    }

    @objc private func dismissSheet() {
        UIView.animate(withDuration: 0.25, animations: {
            self.containerView.frame.origin.y = self.view.bounds.height
            self.dimmingView.alpha = 0
        }) { _ in
            self.dismiss(animated: false)
        }
    }
}
