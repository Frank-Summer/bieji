
import Foundation
import UIKit

class TUOKOUXIUSSBFCollUpdV: UICollectionReusableView {
    private lazy var tufuh_bgV: UIView = {
        let view = UIView()
        view.backgroundColor = TUOKOUXIUSwiftZTClr2
        view.tukou_roundCor(5)
        view.tukou_addTapGesture(target: self, action: #selector(tukou_clickV1))
        return view
    }()
    
    private lazy var tufuh_gxIV: UIImageView = {
        let imageView = UIImageView()
        imageView.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_bf_gx_bn", andIsOne: false)
        return imageView
    }()
    
    private lazy var tufuh_titL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftZTClr3A
        label.font = TUOKOUXIUSwiftFont.regular(9)
        label.text = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[4] as? String
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = TUOKOUXIUSwiftheiseC
        tukou_initV()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tukou_initV()
    }
    
    private func tukou_initV() {
        tufuh_bgV.frame = CGRect(x: 8, y: 0, width: 46, height: 68)
        addSubview(tufuh_bgV)

        tufuh_gxIV.frame = CGRect(x: 11, y: 2, width: 24, height: 24)
        tufuh_bgV.addSubview(tufuh_gxIV)

        tufuh_titL.frame = CGRect(x: 6, y: 26, width: 34, height: 42)
        tufuh_bgV.addSubview(tufuh_titL)
    }

    @objc private func tukou_clickV1() {
        
    }
}
