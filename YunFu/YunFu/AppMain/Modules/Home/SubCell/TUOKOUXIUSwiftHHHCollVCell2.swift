
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUSwiftHHHCollVCell2: UICollectionViewCell {
    
    private var tufuh_model: BannerItem?

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
        contentView.backgroundColor = TUOKOUXIUSwiftwuseC
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
            make.bottom.equalToSuperview().offset(-24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(48)
        }
    }
    
    func tukou_resModel(model: BannerItem) {
        self.tufuh_model = model
        
        if let urlString = self.tufuh_model?.pic, let url = URL(string: urlString) {
            tufuh_coverIV.kf.setImage(with: url, options: [.transition(.fade(0.3)), .requestModifier(ImageAuthModifier())])
        }
        tufuh_contentL.setText(self.tufuh_model?.headline ?? "", lineSpacing: 6)
        
    }
}
