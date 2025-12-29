//
//  BottomSheetController.swift
//  YunFu
//
//  Created by Frank on 2025/01/17.
//  Description:
//  一个可复用的 Bottom Sheet 组件，支持：
//  - 固定高度 / 内容自适应 / 全屏
//  - 下拉关闭
//  - 点击遮罩关闭
//  - 可配置背景颜色（不传使用默认黑色）
//
//  Usage Example:
//
//  let sheet = BottomSheetController(
//      contentView: yourContentView,
//      height: .fit,
//      backgroundColor: .black
//  )
//  present(sheet, animated: false)
//

import UIKit

/// 底部弹出控制器
final class FocusShieldController: UIViewController {

    // MARK: - 高度模式
    enum SheetHeight {
        /// 固定高度
        case fixed(CGFloat)

        /// 根据内容自适应
        case fit

        /// 全屏（safeArea 内）
        case full
    }

    // MARK: - Public Config
    private let heightMode: SheetHeight        // 高度模式
    private let contentView: UIView            // 内容视图
    private let sheetBackgroundColor: UIColor  // 背景颜色

    // MARK: - UI Components
    private let dimView = UIView()              // 遮罩层
    private let containerView = UIView()        // Sheet 容器
    private let dragIndicator = UIView()        // 顶部拖拽指示条

    // MARK: - Constraints
    private var containerHeightConstraint: NSLayoutConstraint!
    private var containerBottomConstraint: NSLayoutConstraint!

    // MARK: - Gesture State
    private var panStartY: CGFloat = 0

    // MARK: - Init
    /// 初始化
    /// - Parameters:
    ///   - contentView: 内容视图
    ///   - height: 高度模式
    ///   - backgroundColor: Sheet 背景色（可选，默认黑色）
    init(
        contentView: UIView,
        height: SheetHeight,
        backgroundColor: UIColor = UIColor(red: 36/255, green: 38/255, blue: 39/255, alpha: 1)
    ) {
        self.contentView = contentView
        self.heightMode = height
        self.sheetBackgroundColor = backgroundColor
        super.init(nibName: nil, bundle: nil)

        // 使用全屏叠加样式
        modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()          // 构建 UI
        setupGesture()     // 添加拖拽手势
        animateIn()        // 进场动画
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .clear

        // ① 遮罩层
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimView.alpha = 0
        dimView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dimView)

        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: view.topAnchor),
            dimView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // ② Sheet 容器
        containerView.backgroundColor = sheetBackgroundColor
        containerView.layer.cornerRadius = 32
        containerView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)

        // 底部约束（用于拖拽）
        containerBottomConstraint = containerView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: calculateHeight()
        )

        // 高度约束
        containerHeightConstraint = containerView.heightAnchor.constraint(
            equalToConstant: calculateHeight()
        )

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerBottomConstraint,
            containerHeightConstraint
        ])

        // ③ 拖拽指示条
        dragIndicator.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        dragIndicator.layer.cornerRadius = 2.5
        dragIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dragIndicator)

        NSLayoutConstraint.activate([
            dragIndicator.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            dragIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dragIndicator.widthAnchor.constraint(equalToConstant: 36),
            dragIndicator.heightAnchor.constraint(equalToConstant: 5)
        ])

        // ④ 内容视图
        contentView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: dragIndicator.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        // ⑤ 点击遮罩关闭
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        dimView.addGestureRecognizer(tap)
    }

    // MARK: - Gesture
    private func setupGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        containerView.addGestureRecognizer(pan)
    }

    @objc private func handlePan(_ pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: view)

        switch pan.state {
        case .began:
            panStartY = containerBottomConstraint.constant

        case .changed:
            let newValue = panStartY + translation.y
            if newValue >= 0 {
                containerBottomConstraint.constant = newValue
            }

        case .ended:
            let velocity = pan.velocity(in: view).y

            // 拖动超过阈值 or 快速下滑 → 关闭
            if containerBottomConstraint.constant > containerHeightConstraint.constant * 0.3
                || velocity > 1200 {
                dismissSelf()
            } else {
                restore()
            }

        default:
            break
        }
    }

    // MARK: - Animations
    private func animateIn() {
        view.layoutIfNeeded()
        containerBottomConstraint.constant = 0

        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut]) {
            self.dimView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

    private func restore() {
        containerBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func dismissSelf() {
        containerBottomConstraint.constant = containerHeightConstraint.constant

        UIView.animate(withDuration: 0.25, animations: {
            self.dimView.alpha = 0
            self.view.layoutIfNeeded()
        }) { _ in
            self.dismiss(animated: false)
        }
    }

    // MARK: - Height Calculation
    private func calculateHeight() -> CGFloat {
        let safeHeight = view.bounds.height - view.safeAreaInsets.top

        switch heightMode {
        case .fixed(let h):
            return h

        case .full:
            return safeHeight

        case .fit:
            // 根据 AutoLayout 计算内容高度
            contentView.layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(
                CGSize(
                    width: view.bounds.width,
                    height: UIView.layoutFittingCompressedSize.height
                )
            )
            return min(size.height + 40, safeHeight)
        }
    }
}
