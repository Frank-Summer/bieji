
import UIKit

class TUOKOUXIUSwiftHHHSubCollReuV: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = TUOKOUXIUSwiftheiseC
        
        _ = UILabel.tukou_bjLabel(
            CGRect(x: 0, y: 20, width: TUOKOUXIUSwiftSCRE_W, height: 20),
            text: "No more content!",
            superView: self,
            textAlignment: .center,
            font: TUOKOUXIUSwiftFont.regular(15),
            textColor: TUOKOUXIUSwiftZTClr4A
        )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
