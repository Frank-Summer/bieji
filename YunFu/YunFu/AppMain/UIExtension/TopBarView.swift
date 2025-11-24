//
//  TopBarView.swift
//  CommonUI
//
//  Author: Frank
//  Created: 2025-11-21
//
//  文件用途（Purpose）
//  -----------------------------------------------------
//  通用“顶部标题栏”组件（适用于所有 UIKit 项目）
//  特性：
//   • 左右 20 边距布局
//   • 左侧固定 28×28 图标按钮（可默认、可覆盖）
//   • 中间标题永远居中，不受左右按钮影响
//   • 右侧按钮可选（显示 / 隐藏）
//   • 提供点击回调 onLeftTap / onRightTap
//  -----------------------------------------------------
//
//  使用示例（Usage）
//  -----------------------------------------------------
//  let topBar = TopBarView()
//  topBar.title = "设置"
//  topBar.rightIcon = UIImage(named: "setting_icon") // 右侧可设可不设
//
//  topBar.onLeftTap = { self.navigationController?.popViewController(animated: true) }
//  topBar.onRightTap = { print("右侧按钮点击") }
//
//  view.addSubview(topBar)
//  topBar.translatesAutoresizingMaskIntoConstraints = false
//  NSLayoutConstraint.activate([
//      topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//      topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//      topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//      topBar.heightAnchor.constraint(equalToConstant: 44)
//  ])
//  -----------------------------------------------------
//

import UIKit

/// 顶部栏组件（可复用于所有 UIKit 页面）
final class TopBarView: UIView {
    
    // MARK: - 对外属性 -------------------------------------------------
    
    /// 外部设置标题（自动居中）
    public var title: String? {
        didSet { titleLabel.text = title }
    }
    
    /// 外部可设置的左侧图标（不设置则使用默认 back）
    public var leftIcon: UIImage? {
        didSet {
            // 如果外部有传入，则覆盖默认图标
            if let icon = leftIcon {
                leftButton.setImage(icon.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
    
    /// 外部可设置右侧图标（为空则隐藏按钮）
    public var rightIcon: UIImage? {
        didSet {
            rightButton.setImage(rightIcon?.withRenderingMode(.alwaysOriginal), for: .normal)
            rightButton.isHidden = (rightIcon == nil)
        }
    }
    
    /// 左侧点击回调
    public var onLeftTap: (() -> Void)?
    
    /// 右侧点击回调
    public var onRightTap: (() -> Void)?
    
    
    // MARK: - 内部 UI --------------------------------------------------
    
    /// 左侧按钮（固定尺寸 28×28）
    private let leftButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white                            // 图标默认白色
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 28).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 28).isActive = true
        return btn
    }()
    
    /// 右侧按钮（默认隐藏）
    private let rightButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.isHidden = true                               // 默认隐藏
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 28).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 28).isActive = true
        return btn
    }()
    
    /// 中间标题 Label
    private let titleLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = .systemFont(ofSize: 20, weight: .medium)
        lab.textAlignment = .center
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    
    
    // MARK: - 初始化 ----------------------------------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()           // 构建 UI
        bindActions()       // 绑定事件
        applyDefaultLeftIcon() // 设置默认返回图标
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        bindActions()
        applyDefaultLeftIcon()
    }
    
    
    // MARK: - 默认图标 --------------------------------------------------
    
    /// 设置默认返回图标（外部不设置 leftIcon 时也会显示）
    private func applyDefaultLeftIcon() {
        let defaultImage = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        leftButton.setImage(defaultImage, for: .normal)
    }
    
    
    // MARK: - UI 布局 --------------------------------------------------
    
    private func setupUI() {
        
        backgroundColor = .clear   // 背景交给外部控制
        
        // 添加到视图
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(titleLabel)
        
        // AutoLayout 约束
        NSLayoutConstraint.activate([
            
            // 左按钮（靠左 20）
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // 右按钮（靠右 20）
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // 标题永远居中
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // 避免标题被按钮遮挡
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leftButton.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: rightButton.leadingAnchor, constant: -16)
        ])
    }
    
    
    // MARK: - 点击事件 --------------------------------------------------
    
    private func bindActions() {
        leftButton.addTarget(self, action: #selector(leftPressed), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightPressed), for: .touchUpInside)
    }
    
    /// 左按钮点击 → 回调外部
    @objc private func leftPressed() {
        onLeftTap?()
    }
    
    /// 右按钮点击 → 回调外部
    @objc private func rightPressed() {
        onRightTap?()
    }
}
