
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUSwiftHHHCollVCell: UICollectionViewCell {
    
    private var tufuh_model: ExploreItem?

    private let tufuh_coverIV: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = TUOKOUXIUWhiteA5
        iv.contentMode = .scaleAspectFill
        iv.tukou_roundCor(20)
        iv.clipsToBounds = true
        iv.layer.borderWidth = 1
        iv.layer.borderColor = TUOKOUXIUSmallWhiteA10.cgColor
        return iv
    }()
    private let tufuh_playingIV: UIImageView = {
        let iv = UIImageView()
        iv.tukou_roundCor(40)
        iv.clipsToBounds = true
        return iv
    }()

    private let tufuh_typeL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(16)
        return label
    }()
    
    private let tufuh_contentL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftZTClr3
        label.font = TUOKOUXIUSwiftFont.regular(12)
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
        contentView.backgroundColor = TUOKOUXIUSwiftwuseC
        
        contentView.addSubview(tufuh_coverIV)
        contentView.addSubview(tufuh_playingIV)
        contentView.addSubview(tufuh_typeL)
        contentView.addSubview(tufuh_contentL)
    }
    
    private func tukou_conLaySubV() {
        tufuh_coverIV.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 144 * TUOKOUXIUDeviceInfo.scaleX, height: 185 * TUOKOUXIUDeviceInfo.scaleX))
            make.top.left.equalToSuperview()
        }
        
        tufuh_playingIV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40 * TUOKOUXIUDeviceInfo.scaleX)
            make.left.equalToSuperview().offset(144 * TUOKOUXIUDeviceInfo.scaleX/2 - 40)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        tufuh_typeL.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-31)
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(22)
        }
        tufuh_contentL.snp.makeConstraints { make in
            make.top.equalTo(tufuh_typeL.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(17)
        }
    }
    
    func tukou_resModel(model: ExploreItem) {
        self.tufuh_model = model
            
        tufuh_typeL.text = self.tufuh_model?.headline
        tufuh_contentL.text = self.tufuh_model?.subhead
        
        if let urlString = self.tufuh_model?.musicPic, let url = URL(string: urlString) {
            tufuh_coverIV.kf.setImage(with: url, options: [.transition(.fade(0.3)), .requestModifier(ImageAuthModifier())])
        }
        
    }
}
