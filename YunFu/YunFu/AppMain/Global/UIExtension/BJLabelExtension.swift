
import UIKit

extension UILabel {

    /// 设置文本行间距
    /// - Parameters:
    ///   - text: 文本内容
    ///   - lineSpacing: 行间距（默认 4）
    ///   - alignment: 文本对齐方式（默认 .left）
    ///   - lineHeightMultiple: 行高倍数（如想要微信效果可设置 1.3）
    func setText(_ text: String,
                 lineSpacing: CGFloat = 4,
                 alignment: NSTextAlignment = .left,
                 lineHeightMultiple: CGFloat = 0) {

        // 基本样式
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment

        // 如果设置了行高倍数则使用它
        if lineHeightMultiple > 0 {
            paragraphStyle.lineHeightMultiple = lineHeightMultiple
        }

        let attributes: [NSAttributedString.Key: Any] = [
            .font: self.font as Any,
            .foregroundColor: self.textColor as Any,
            .paragraphStyle: paragraphStyle
        ]

        self.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
}

extension UILabel {

    @discardableResult
    static func tukou_bjLabel(_ frame: CGRect,
                                      text: String?,
                                      superView: UIView,
                                      textAlignment: NSTextAlignment,
                                      font: UIFont,
                                      textColor: UIColor?) -> UILabel {
        let tufuh_l = UILabel(frame: frame)
        if let text = text, !text.isEmpty {
            tufuh_l.text = text
        }
        tufuh_l.textAlignment = textAlignment
        tufuh_l.font = font
        if let textColor = textColor {
            tufuh_l.textColor = textColor
        }
        superView.addSubview(tufuh_l)
        return tufuh_l
    }
}
