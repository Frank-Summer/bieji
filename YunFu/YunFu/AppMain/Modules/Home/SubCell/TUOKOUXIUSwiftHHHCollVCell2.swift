
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUSwiftHHHCollVCell2: UICollectionViewCell {
    
    private var tufuh_mDict: [String: Any] = [:]

    private let tufuh_coverIV: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = TUOKOUXIUSwiftheiseC
        iv.contentMode = .scaleAspectFill
        iv.tukou_roundCor(20)
        iv.clipsToBounds = true
        return iv
    }()
    
    private let tufuh_contentL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.regular(14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        tukou_conSubV()
        tukou_conLaySubV()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func tukou_conSubV() {
        contentView.backgroundColor = TUOKOUXIUSwiftheiseC
        contentView.tukou_roundCor(20)
        contentView.clipsToBounds = true
        
        contentView.addSubview(tufuh_coverIV)
        contentView.addSubview(tufuh_contentL)
    }
    
    private func tukou_conLaySubV() {
        tufuh_coverIV.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 240 * TUOKOUXIUDeviceInfo.scaleX, height: 320 * TUOKOUXIUDeviceInfo.scaleX))
            make.top.left.equalToSuperview()
        }
        tufuh_contentL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(250 * TUOKOUXIUDeviceInfo.scaleX)
            make.left.equalToSuperview().offset(15 * TUOKOUXIUDeviceInfo.scaleX)
            make.right.equalToSuperview().offset(-15 * TUOKOUXIUDeviceInfo.scaleX)
        }
    }
    
    func tukou_resModel(_ model: [String: Any]) {
        tufuh_mDict = model
            
        let tufuh_ulrS = TUOKOUXIUSSStringUtils.tukou_killNil(model["haibao"])

        if let url = URL(string: tufuh_ulrS) {
            tufuh_coverIV.kf.setImage(with: url, options: [.transition(.fade(0.3))])
        }
        tufuh_coverIV.image = UIImage(named: "icon_tukou_bg")
        tufuh_contentL.text = "风在山谷里转一遍，带着悠远的回响"
        
    }
}
