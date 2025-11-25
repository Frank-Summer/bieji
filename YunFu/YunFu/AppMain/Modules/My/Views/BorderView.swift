//
//  BorderView.swift
//  CommonUI
//
//  Author: Frank
//  Created: 2025-11-22
//
//  文件用途：
//  --------------------------------------------
//  支持上下左右四边任意边框的 UIView
//  可配合圆角使用，比 UIKit 默认 layer.border 更灵活
//  --------------------------------------------
//

import UIKit

final class BorderView: UIView {

    // 四条边框 layer
    private let top = CALayer()
    private let bottom = CALayer()
    private let left = CALayer()
    private let right = CALayer()

    // 可配置属性
    public var borderColor: UIColor = UIColor.white.withAlphaComponent(0.15) {
        didSet { updateColors() }
    }

    public var borderWidth: CGFloat = 0.5 {
        didSet { setNeedsLayout() }
    }

    public var showTop = false       { didSet { top.isHidden = !showTop } }
    public var showBottom = false    { didSet { bottom.isHidden = !showBottom } }
    public var showLeft = false      { didSet { left.isHidden = !showLeft } }
    public var showRight = false     { didSet { right.isHidden = !showRight } }

    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    
    private func setupLayers() {
        layer.addSublayer(top)
        layer.addSublayer(bottom)
        layer.addSublayer(left)
        layer.addSublayer(right)

        updateColors()
        top.isHidden = true
        bottom.isHidden = true
        left.isHidden = true
        right.isHidden = true
    }
    
    
    private func updateColors() {
        top.backgroundColor = borderColor.cgColor
        bottom.backgroundColor = borderColor.cgColor
        left.backgroundColor = borderColor.cgColor
        right.backgroundColor = borderColor.cgColor
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()

        let w = bounds.width
        let h = bounds.height

        top.frame = CGRect(x: 0, y: 0, width: w, height: borderWidth)
        bottom.frame = CGRect(x: 0, y: h - borderWidth, width: w, height: borderWidth)
        left.frame = CGRect(x: 0, y: 0, width: borderWidth, height: h)
        right.frame = CGRect(x: w - borderWidth, y: 0, width: borderWidth, height: h)
    }
}
