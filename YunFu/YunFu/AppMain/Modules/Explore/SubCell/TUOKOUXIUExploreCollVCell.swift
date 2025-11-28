
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUExploreCollVCell: UICollectionViewCell {
    
    private var tufuh_mDict: [String: Any] = [:]

    private let tufuh_coverIV: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = TUOKOUXIUSwiftheiseC
        iv.contentMode = .scaleAspectFill
        iv.tukou_roundCor(30)
        iv.clipsToBounds = true
        return iv
    }()

    private let tufuh_typeL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftZTClr3
        label.font = TUOKOUXIUSwiftFont.medium(14)
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
        contentView.addSubview(tufuh_coverIV)
        contentView.addSubview(tufuh_typeL)
    }
    
    private func tukou_conLaySubV() {
        tufuh_coverIV.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.top.left.equalToSuperview()
        }
        
        tufuh_typeL.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
    }
    
    func tukou_resModel(_ model: [String: Any]) {
        tufuh_mDict = model
            
        let tufuh_ulrS = TUOKOUXIUSSStringUtils.tukou_killNil(model["haibao"])

        if let url = URL(string: tufuh_ulrS) {
            tufuh_coverIV.kf.setImage(with: url, options: [.transition(.fade(0.3))])
        }
        tufuh_coverIV.image = UIImage(named: "icon_tukou_logo")
        
        tufuh_typeL.text = "东方禅境"
        
        
    }
}
