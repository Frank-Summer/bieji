
import UIKit
import ObjectiveC
import Foundation

let TUOKOUXIUSwiftSCRE_W   = UIScreen.main.bounds.width
let TUOKOUXIUSwiftSCRE_H   = UIScreen.main.bounds.height


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
    //需要添加行间距的
    static func tukou_textSize(
        text: String,
        font: UIFont,
        maxSize: CGSize,
        lineSpacing: CGFloat = 4,
        alignment: NSTextAlignment = .left,
        lineHeightMultiple: CGFloat = 0
    ) -> CGSize {

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment

        if lineHeightMultiple > 0 {
            paragraphStyle.lineHeightMultiple = lineHeightMultiple
        }

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]

        let attributedText = NSAttributedString(string: text, attributes: attributes)

        let rect = attributedText.boundingRect(
            with: maxSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )

        // 向上取整，防止 1px 截断
        return CGSize(
            width: ceil(rect.width),
            height: ceil(rect.height)
        )
    }
}


class TUOKOUXIUMusicW: UIView {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        self.frame = CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H, width: TUOKOUXIUSwiftSCRE_W, height: 40)
//        self.isHidden = false
        self.backgroundColor = .clear
//        self.windowLevel = .alert
        self.tukou_loadUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func tukou_loadUI() {
        UIView.animate(withDuration: 0.1) {
            self.frame = CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H-120-110-20, width: TUOKOUXIUSwiftSCRE_W, height: 40)
        }
    }
    func tukou_updateUI() {
        UIView.animate(withDuration: 0.1) {
            self.frame = CGRect(x: 0, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 44 + 32 + 10, width: TUOKOUXIUSwiftSCRE_W, height: 40)
        }
    }
}

class TUOKOUXIUToolsW: UIView {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        self.frame = CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H, width: TUOKOUXIUSwiftSCRE_W, height: 80)
//        self.isHidden = false
        self.backgroundColor = .clear
//        self.windowLevel = .alert
        self.tukou_loadUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func tukou_loadUI() {
        UIView.animate(withDuration: 0.1) {
            self.frame = CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H-80-110-20, width: TUOKOUXIUSwiftSCRE_W, height: 80)
        }
    }
}

class TUOKOUXIUTopTypeViewW: UIWindow {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        self.frame = CGRect(x: 20, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 12, width: TUOKOUXIUSwiftSCRE_W-40, height: 32)
        self.isHidden = false
        self.backgroundColor = .clear
        self.windowLevel = .alert
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}


class TUOKOUXIUselectTypeW: UIWindow {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        self.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H)
        self.isHidden = false
        self.backgroundColor = .clear
        self.windowLevel = .alert
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class TUOKOUXIUTopselectTypeW: UIWindow {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        self.frame = CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H)
        self.isHidden = false
        self.backgroundColor = .black
        self.windowLevel = .alert
        self.tukou_addTapGesture(target: self, action: #selector(clickTopselectTypeW))
        self.tukou_loadUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func tukou_loadUI() {
        UIView.animate(withDuration: 0.25) {
            self.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H)
        }
    }
    
    @objc func clickTopselectTypeW() {
        UIView.animate(withDuration: 0.25) {
            self.frame = CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H)
        }
        TUOKOUXIUSwiftDelaBlk(0.25) {
            self.isHidden = true
            self.removeFromSuperview()
        }
    }
}

