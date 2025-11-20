
import Foundation
import UIKit

class TUOKOUXIUSwiftTabHeadV: UIView {

    var tufuh_secN: Int = 0

    var didSelectBlock: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        tukou_setTapGes()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tukou_setTapGes()
    }

    private func tukou_setTapGes() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tukou_onTap))
        self.addGestureRecognizer(tap)
    }

    @objc private func tukou_onTap() {
        didSelectBlock?(tufuh_secN)
    }
}
