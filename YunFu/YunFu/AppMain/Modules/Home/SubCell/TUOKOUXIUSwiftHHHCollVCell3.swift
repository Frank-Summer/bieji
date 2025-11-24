
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUSwiftHHHCollVCell3: UICollectionViewCell {
    
    private var tufuh_mDict: [String: Any] = [:]

    private let tufuh_headIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "icon_tukou_logo")
        iv.tukou_roundCor(20)
        iv.clipsToBounds = true
        iv.layer.borderWidth = 1
        iv.layer.borderColor = TUOKOUXIUSwiftZTClr8.cgColor
        return iv
    }()

    private let tufuh_nameL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftZTClr5
        label.font = TUOKOUXIUSwiftFont.semibold(14)
        return label
    }()
    
    private let tufuh_contentL: TUOKOUXIUSwiftVerAligTopL = {
        let label = TUOKOUXIUSwiftVerAligTopL()
        label.textColor = TUOKOUXIUSwiftZTClr3A
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
        contentView.backgroundColor = TUOKOUXIUSwiftZTClr5A
        contentView.tukou_roundCor(20)
        contentView.clipsToBounds = true

        contentView.addSubview(tufuh_headIV)
        contentView.addSubview(tufuh_nameL)
        contentView.addSubview(tufuh_contentL)
    }
    
    private func tukou_conLaySubV() {
        tufuh_headIV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10 * TUOKOUXIUDeviceInfo.scaleX)
            make.left.equalToSuperview().offset(10 * TUOKOUXIUDeviceInfo.scaleX)
            make.size.equalTo(CGSize(width: 40 * TUOKOUXIUDeviceInfo.scaleX, height: 40 * TUOKOUXIUDeviceInfo.scaleX))
        }
        
        tufuh_nameL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20 * TUOKOUXIUDeviceInfo.scaleX)
            make.left.equalTo(tufuh_headIV.snp.right).offset(10)
            make.height.equalTo(20)
        }
        tufuh_contentL.snp.makeConstraints { make in
            make.top.equalTo(tufuh_headIV.snp.bottom).offset(10 * TUOKOUXIUDeviceInfo.scaleX)
            make.left.equalToSuperview().offset(10 * TUOKOUXIUDeviceInfo.scaleX)
            make.right.equalToSuperview().offset(-10 * TUOKOUXIUDeviceInfo.scaleX)
        }
    }
    
    func tukou_resModel(_ model: [String: Any]) {
        tufuh_mDict = model
            
        let tufuh_ulrS = TUOKOUXIUSSStringUtils.tukou_killNil(model["haibao"])

        if let url = URL(string: tufuh_ulrS) {
            tufuh_headIV.kf.setImage(with: url, options: [.transition(.fade(0.3))])
        }
        tufuh_nameL.text = "huoluo"
        tufuh_contentL.setText("“夜里思绪翻涌时，它像在胸腔铺了一层柔软。” — 晚间·入睡前", lineSpacing: 5)
        
    }
}
