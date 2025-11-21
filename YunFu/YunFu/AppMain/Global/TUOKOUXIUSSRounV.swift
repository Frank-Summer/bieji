
import UIKit
import ObjectiveC
import Foundation

let TUOKOUXIUSwiftSCRE_W   = UIScreen.main.bounds.width
let TUOKOUXIUSwiftSCRE_H   = UIScreen.main.bounds.height
let TUOKOUXIUSwiftheiseC   = UIColor(red: 1/255.0, green: 1/255.0, blue: 1/255.0, alpha: 1.0)
let TUOKOUXIUSwiftbaiseC   = UIColor(red: 254/255.0, green: 254/255.0, blue: 254/255.0, alpha: 1.0)
let TUOKOUXIUSwiftwuseC    = UIColor.clear


let TUOKOUXIUSwiftZTClr2A  = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.8)
let TUOKOUXIUSwiftZTClr3A  = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.6)
let TUOKOUXIUSwiftZTClr4A  = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.3)

let TUOKOUXIUSwiftZTClr6A  = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.7)
let TUOKOUXIUSwiftZTClr7A  = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5)
let TUOKOUXIUSwiftZTClr    = UIColor(red: 14/255.0, green: 136/255.0, blue: 253/255.0, alpha: 1.0)
let TUOKOUXIUSwiftZTClr2   = UIColor(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0)
let TUOKOUXIUSwiftZTClr3   = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1.0)
let TUOKOUXIUSwiftZTClr4   = UIColor(red: 135/255.0, green: 135/255.0, blue: 135/255.0, alpha: 1.0)

let TUOKOUXIUSwiftZTClr6   = UIColor(red: 151/255.0, green: 138/255.0, blue: 140/255.0, alpha: 1.0)
let TUOKOUXIUSwiftZTClr7   = UIColor(red: 243/255.0, green: 243/255.0, blue: 243/255.0, alpha: 1.0)

extension UIColor {
    static func TUOKOUXIUSSRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    static func TUOKOUXIUSSRGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}

func TUOKOUXIUSwiftDelaBlk(_ delay: TimeInterval, block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: block)
}

func TUOKOUXIUSwiftKeyWindow() -> UIWindow? {
    return UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }
}

var TUOKOUXIUSwiftKeyWinRoV: UIView? {
    return TUOKOUXIUSwiftKeyWindow()?.rootViewController?.view
}

struct TUOKOUXIUSwiftFont {
    static func semibold(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    static func medium(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .medium)
    }
    static func regular(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .regular)
    }
    static func light(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .light)
    }
}

struct TUOKOUXIUSwiftConstIX {
    static func deviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        return machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
    }
    
    static func isIPhoneXOrLater() -> Bool {
        let model = deviceIdentifier()
        
        let nonNotchModels: Set<String> = [
            "iPhone7,2", "iPhone7,1",
            "iPhone8,1", "iPhone8,2",
            "iPhone8,4",
            "iPhone9,1", "iPhone9,3", "iPhone9,2", "iPhone9,4",
            "iPhone10,1", "iPhone10,4", "iPhone10,2", "iPhone10,5",
            "iPhone12,8", "iPhone14,6"
        ]
        
        return !nonNotchModels.contains(model)
    }
}

struct TUOKOUXIUDeviceInfo {
    static var tukou_tabBarHeight: CGFloat {
        return TUOKOUXIUSwiftConstIX.isIPhoneXOrLater() ? 83.0 : 49.0
    }

    static var tukou_statusBarTopHeight: CGFloat {
        return TUOKOUXIUSwiftConstIX.isIPhoneXOrLater() ? 44.0 : 20.0
    }
    static let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let scaleX: CGFloat = isPad ? (screenWidth / 600.0) : (screenWidth / 375.0)
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

extension UIApplication {
    private static let runOnce: Void = {
        UIButton.tukou_swizzle()
    }()

    open override var next: UIResponder? {
        UIApplication.runOnce
        return super.next
    }
}

class TUOKOUXISSDictionaryUtil: NSObject {
    static func tukou_isEmpty(_ dict: Any?) -> Bool {
        guard let dict = dict else { return true }
        if dict is NSNull { return true }
        guard let realDict = dict as? NSDictionary else { return true }
        return realDict.count == 0
    }
}

class TUOKOUXISSObjectUtil: NSObject {
    static func tukou_isNilOrNull(_ obj: Any?) -> Bool {
        if obj == nil { return true }
        if obj is NSNull { return true }
        return false
    }
}

class TUOKOUXISSUUtils: NSObject {
    static func tukou_isStringEmpty(_ string: Any?) -> Bool {
        guard let value = string else { return true }

        if value is NSNull { return true }
        if !(value is NSString) { return true }

        let str = (value as! NSString) as String

        let trimmed = str.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ||
               trimmed.lowercased() == "null" ||
               trimmed.lowercased() == "<null>" ||
               trimmed.lowercased() == "(null)" ||
               trimmed.lowercased() == "none"
    }
}

class TUOKOUXIUSSStringUtils: NSObject {
    static func tukou_isEmpty(_ value: Any?) -> Bool {
        guard let str = value as? String else { return true }
        let trimmed = str.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return trimmed.isEmpty || ["null", "<null>", "(null)", "none"].contains(trimmed)
    }

    static func tukou_killNil(_ value: Any?) -> String {
        guard let str = value as? String else { return "" }
        let trimmed = str.trimmingCharacters(in: .whitespacesAndNewlines)
        if tukou_isEmpty(trimmed) {
            return ""
        }
        return trimmed
    }
    
    static func tukou_sizWithT(_ text: String, font: UIFont, maxSize: CGSize) -> CGSize {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let boundingRect = text.boundingRect(
            with: maxSize,
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        )
        return boundingRect.size
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

class TUOKOUXIUAppUpdW: UIWindow {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        self.frame = CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H)
        self.isHidden = false
        self.backgroundColor = TUOKOUXIUSwiftZTClr6A
        self.windowLevel = .alert
        self.tukou_loadUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func tukou_loadUI() {
        UIView.animate(withDuration: 0.1) {
            self.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H)
        }
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
