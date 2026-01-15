
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUSwiftHHHCollVCell3: UICollectionViewCell {
    
    private var tufuh_model: SocialProof?

    private let tufuh_headIV: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = TUOKOUXIUSwiftZTClr8
        iv.image = UIImage(named: "icon_tukou_logo")
        iv.tukou_roundCor(20)
        iv.clipsToBounds = true
        iv.layer.borderWidth = 1
        iv.layer.borderColor = TUOKOUXIUWhiteA10.cgColor
        return iv
    }()

    private let tufuh_nameL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(14)
        return label
    }()
    
    private let tufuh_contentL: TUOKOUXIUSwiftVerAligTopL = {
        let label = TUOKOUXIUSwiftVerAligTopL()
        label.textColor = TUOKOUXIUWhiteA60
        label.font = TUOKOUXIUSwiftFont.regular(12)
        label.tufuh_verAlig = .top
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
        contentView.backgroundColor = TUOKOUXIUWhiteA10
        contentView.tukou_roundCor(20)
        contentView.clipsToBounds = true

        contentView.addSubview(tufuh_headIV)
        contentView.addSubview(tufuh_nameL)
        contentView.addSubview(tufuh_contentL)
    }
    
    private func tukou_conLaySubV() {
        tufuh_headIV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        tufuh_nameL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(tufuh_headIV.snp.right).offset(10)
            make.height.equalTo(40)
        }
        tufuh_contentL.snp.makeConstraints { make in
            make.top.equalTo(tufuh_headIV.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    func tukou_resModel(model: SocialProof) {
        self.tufuh_model = model
            
        if let urlString = self.tufuh_model?.avatar, let url = URL(string: urlString) {
            tufuh_headIV.kf.setImage(with: url, options: [.transition(.fade(0.3))])
        }

        tufuh_nameL.text = self.tufuh_model?.username
        tufuh_contentL.setText(self.tufuh_model?.content ?? "", lineSpacing: 4)
        
    }
}
