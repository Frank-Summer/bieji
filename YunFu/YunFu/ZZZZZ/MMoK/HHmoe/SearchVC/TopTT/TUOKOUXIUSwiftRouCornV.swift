

import UIKit

class TUOKOUXIUSwiftRouCornV: UIView {
    
    let tufuh_numLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = TUOKOUXIUSwiftFont.regular(18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tukou_setViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tukou_setViews()
    }
    
    private func tukou_setViews() {
        addSubview(tufuh_numLabel)
        NSLayoutConstraint.activate([
            tufuh_numLabel.topAnchor.constraint(equalTo: topAnchor),
            tufuh_numLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            tufuh_numLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            tufuh_numLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func draw(_ rect: CGRect) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
