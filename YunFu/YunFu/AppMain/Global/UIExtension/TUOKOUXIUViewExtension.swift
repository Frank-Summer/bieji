
import UIKit

extension UIView {

    @discardableResult
    static func tukou_bjView(_ frame: CGRect,
                                    superView: UIView,
                                    bgColor: UIColor?) -> UIView {
        let tufuh_v = UIView(frame: frame)
        if let bgColor = bgColor {
            tufuh_v.backgroundColor = bgColor
        }
        superView.addSubview(tufuh_v)
        return tufuh_v
    }
    @discardableResult
    static func tukou_bjView(_ frame: CGRect,
                                    superView: UIView,
                                    bgColor: UIColor?,
                                    cornerRadius:CGFloat = 0,
                                    borderWidth:CGFloat = 0,
                                    borderColor:UIColor?) -> UIView {
        let tufuh_v = UIView(frame: frame)
        if let bgColor = bgColor {
            tufuh_v.backgroundColor = bgColor
        }
        if cornerRadius > 0 {
            tufuh_v.layer.cornerRadius = cornerRadius
            tufuh_v.layer.masksToBounds = true
        }
        if borderWidth > 0 {
            tufuh_v.layer.borderWidth = borderWidth
        }
        if let borderColor = borderColor {
            tufuh_v.layer.borderColor = borderColor.cgColor
        }
        superView.addSubview(tufuh_v)
        return tufuh_v
    }
}

extension UIView {
    func tukou_addTapGesture(target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
}

extension UIView {
    func tukou_roundCor(_ cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

class TUOKOUXIUZMTitV: UIView {
    
    @objc(initHintInView:)
    init(hintIn superView: UIView) {
        super.init(frame: superView.bounds)
        self.backgroundColor = TUOKOUXIUSwiftheiseC.withAlphaComponent(0.5)
        superView.addSubview(self)
        self.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func tukou_closeView() {
        self.isHidden = true
        self.removeFromSuperview()
    }
}

extension UIView {
    var tuks_spx: CGFloat {
        get { return frame.origin.x }
        set { frame.origin.x = newValue }
    }
    
    var tuks_spy: CGFloat {
        get { return frame.origin.y }
        set { frame.origin.y = newValue }
    }
    
    var tuks_spwidth: CGFloat {
        get { return frame.size.width }
        set { frame.size.width = newValue }
    }
    
    var tuks_spheight: CGFloat {
        get { return frame.size.height }
        set { frame.size.height = newValue }
    }
    
    var tuks_sptop: CGFloat {
        get { return frame.origin.y }
        set { frame.origin.y = newValue }
    }
    
    var tuks_spbottom: CGFloat {
        get { return frame.origin.y + frame.size.height }
        set { frame.origin.y = newValue - frame.size.height }
    }
    
    var tuks_spleft: CGFloat {
        get { return frame.origin.x }
        set { frame.origin.x = newValue }
    }
    
    var tuks_spright: CGFloat {
        get { return frame.origin.x + frame.size.width }
        set { frame.origin.x = newValue - frame.size.width }
    }
    
    var tuks_spcenterX: CGFloat {
        get { return center.x }
        set { center.x = newValue }
    }
    
    var tuks_spcenterY: CGFloat {
        get { return center.y }
        set { center.y = newValue }
    }
    
    var tuks_sporigin: CGPoint {
        get { return frame.origin }
        set { frame.origin = newValue }
    }
    
    var tuks_spsize: CGSize {
        get { return frame.size }
        set { frame.size = newValue }
    }
}
