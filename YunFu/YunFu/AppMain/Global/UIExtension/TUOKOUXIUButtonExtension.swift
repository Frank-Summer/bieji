
import UIKit

extension UIButton {

    @discardableResult
    static func tukou_bjBtn(_ frame: CGRect,
                           target: AnyObject?,
                           title: String? = nil,
                           superView: UIView,
                           action: Selector) -> UIButton {
        let tufuh_btn = UIButton(type: .custom)
        tufuh_btn.frame = frame
        tufuh_btn.backgroundColor = TUOKOUXIUSwiftwuseC
        
        if let title = title, !title.isEmpty {
            tufuh_btn.setTitle(title, for: .normal)
        }
        tufuh_btn.addTarget(target, action: action, for: .touchUpInside)
        superView.addSubview(tufuh_btn)
        return tufuh_btn
    }
    @discardableResult
    static func tukou_bjBtn(_ frame: CGRect,
                           target: AnyObject?,
                           title: String? = nil,
                           color: UIColor?,
                           color2: UIColor?,
                           font: UIFont,
                           superView: UIView,
                           action: Selector) -> UIButton {
        let tufuh_btn = UIButton(type: .custom)
        tufuh_btn.frame = frame
        tufuh_btn.backgroundColor = TUOKOUXIUSwiftwuseC
        
        if let title = title, !title.isEmpty {
            tufuh_btn.setTitle(title, for: .normal)
        }
        if let color = color {
            tufuh_btn.setTitleColor(color, for: .normal)
        }
        if let color2 = color2 {
            tufuh_btn.setTitleColor(color2, for: .selected)
        }
        tufuh_btn.titleLabel?.font = font
        tufuh_btn.addTarget(target, action: action, for: .touchUpInside)
        superView.addSubview(tufuh_btn)
        return tufuh_btn
    }
    @discardableResult
    static func tukou_bjBtn(_ frame: CGRect,
                           target: AnyObject?,
                           title: String? = nil,
                           title2: String? = nil,
                           superView: UIView,
                           action: Selector) -> UIButton {
        let tufuh_btn = UIButton(type: .custom)
        tufuh_btn.frame = frame
        tufuh_btn.backgroundColor = TUOKOUXIUSwiftwuseC
        
        if let title = title, !title.isEmpty {
            tufuh_btn.setTitle(title, for: .normal)
        }
        if let title2 = title2, !title2.isEmpty {
            tufuh_btn.setTitle(title2, for: .selected)
        }
        tufuh_btn.addTarget(target, action: action, for: .touchUpInside)
        superView.addSubview(tufuh_btn)
        return tufuh_btn
    }
    @discardableResult
    static func tukou_bjBtn(_ frame: CGRect,
                           target: AnyObject?,
                           image: UIImage? = nil,
                           superView: UIView,
                           action: Selector) -> UIButton {
        let tufuh_btn = UIButton(type: .custom)
        tufuh_btn.frame = frame
        tufuh_btn.backgroundColor = TUOKOUXIUSwiftwuseC
        
        if let image = image {
            tufuh_btn.setImage(image, for: .normal)
        }
        tufuh_btn.addTarget(target, action: action, for: .touchUpInside)
        superView.addSubview(tufuh_btn)
        return tufuh_btn
    }
    @discardableResult
    static func tukou_bjBtn(_ frame: CGRect,
                           target: AnyObject?,
                           image: UIImage? = nil,
                           superView: UIView,
                           action: Selector,
                           title: String? = nil,
                           color: UIColor?,
                           font: UIFont,
                           titleEdgeInsets:UIEdgeInsets,
                           imageEdgeInsets:UIEdgeInsets) -> UIButton {
        let tufuh_btn = UIButton(type: .custom)
        tufuh_btn.frame = frame
        tufuh_btn.backgroundColor = TUOKOUXIUSwiftwuseC
        
        if let image = image {
            tufuh_btn.setImage(image, for: .normal)
        }
        if let title = title, !title.isEmpty {
            tufuh_btn.setTitle(title, for: .normal)
        }
        if let color = color {
            tufuh_btn.setTitleColor(color, for: .normal)
        }
        tufuh_btn.titleLabel?.font = font
        tufuh_btn.titleEdgeInsets = titleEdgeInsets
        tufuh_btn.imageEdgeInsets = imageEdgeInsets
        tufuh_btn.addTarget(target, action: action, for: .touchUpInside)
        superView.addSubview(tufuh_btn)
        return tufuh_btn
    }
    @discardableResult
    static func tukou_bjBtn(_ frame: CGRect,
                           target: AnyObject?,
                           imageName: String? = nil,
                           superView: UIView,
                           action: Selector,
                           font: UIFont,
                           title: String? = nil,
                           color: UIColor? = nil,
                           bgColor: UIColor?,
                           cornerRadius:CGFloat = 0) -> UIButton {
        let tufuh_btn = UIButton(type: .custom)
        tufuh_btn.frame = frame
        tufuh_btn.backgroundColor = bgColor
        
        if let name = imageName, !name.isEmpty {
            let image = UIImage(named: name)
            tufuh_btn.setImage(image, for: .normal)
        }
        if let title = title {
            tufuh_btn.setTitle(title, for: .normal)
        }
        if let color = color {
            tufuh_btn.setTitleColor(color, for: .normal)
        }
        
        tufuh_btn.titleLabel?.font = font
        
        if cornerRadius > 0 {
            tufuh_btn.layer.cornerRadius = cornerRadius
        }
        tufuh_btn.addTarget(target, action: action, for: .touchUpInside)
        superView.addSubview(tufuh_btn)
        return tufuh_btn
    }
}

extension UIButton {
    private struct AssociatedKeys {
        static var top: UInt8 = 0
        static var right: UInt8 = 0
        static var bottom: UInt8 = 0
        static var left: UInt8 = 0
    }

    func tukou_setEnlargeEdge(_ size: CGFloat) {
        objc_setAssociatedObject(self, &AssociatedKeys.top, size, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.right, size, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.bottom, size, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.left, size, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }

    private var tukou_enlargedRect: CGRect {
        let top = objc_getAssociatedObject(self, &AssociatedKeys.top) as? CGFloat ?? 0
        let right = objc_getAssociatedObject(self, &AssociatedKeys.right) as? CGFloat ?? 0
        let bottom = objc_getAssociatedObject(self, &AssociatedKeys.bottom) as? CGFloat ?? 0
        let left = objc_getAssociatedObject(self, &AssociatedKeys.left) as? CGFloat ?? 0

        return CGRect(
            x: bounds.origin.x - left,
            y: bounds.origin.y - top,
            width: bounds.size.width + left + right,
            height: bounds.size.height + top + bottom
        )
    }

    @objc private func tukou_pointInside(_ point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.tukou_enlargedRect
        return rect.contains(point)
    }

    static func tukou_swizzle() {
        guard let originalMethod = class_getInstanceMethod(UIButton.self, #selector(point(inside:with:))),
              let swizzledMethod = class_getInstanceMethod(UIButton.self, #selector(tukou_pointInside(_:with:))) else {
            return
        }
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
