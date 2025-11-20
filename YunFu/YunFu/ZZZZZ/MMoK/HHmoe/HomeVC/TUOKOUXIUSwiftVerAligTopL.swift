
import UIKit

enum TUOKOUXIUSwiftENUM_VerAlig: Int {
    case top
    case left
    case bottom
}

class TUOKOUXIUSwiftVerAligTopL: UILabel {
    var tufuh_verAlig: TUOKOUXIUSwiftENUM_VerAlig = .top {
        didSet {
            setNeedsDisplay()
        }
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        switch tufuh_verAlig {
        case .left:
            textRect.origin.x = bounds.origin.x
        case .top:
            textRect.origin.y = bounds.origin.y
        case .bottom:
            textRect.origin.y = bounds.origin.y + bounds.height - textRect.height
        @unknown default:
            break
        }
        return textRect
    }

    override func drawText(in rect: CGRect) {
        let actualRect = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: actualRect)
    }
}
