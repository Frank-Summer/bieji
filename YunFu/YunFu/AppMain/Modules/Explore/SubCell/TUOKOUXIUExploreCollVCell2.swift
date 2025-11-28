
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUExploreCollVCell2: UICollectionViewCell {
    
    private var tufuh_mDict: [String: Any] = [:]

    private let tufuh_coverIV: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = TUOKOUXIUSwiftheiseC
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    private let tufuh_playingIV: UIImageView = {
        let iv = UIImageView()
        iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_cam_tag", andIsOne: false)
        iv.tukou_roundCor(40)
        iv.clipsToBounds = true
        return iv
    }()
    
    private let tufuh_lockIV: UIImageView = {
        let iv = UIImageView()
        iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_cam_tag", andIsOne: false)
//        iv.tukou_roundCor(10)
//        iv.clipsToBounds = true
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
        contentView.backgroundColor = TUOKOUXIUSwiftheiseC
        contentView.tukou_roundCor(20)
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = TUOKOUXIUSwiftZTClr3.cgColor
        
        contentView.addSubview(tufuh_coverIV)
        contentView.addSubview(tufuh_lockIV)
        contentView.addSubview(tufuh_playingIV)
        contentView.addSubview(tufuh_typeL)
        contentView.addSubview(tufuh_contentL)
    }
    
    private func tukou_conLaySubV() {
        tufuh_coverIV.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 144, height: 144))
            make.top.left.equalToSuperview()
        }
        
        tufuh_lockIV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        
        tufuh_playingIV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.left.equalToSuperview().offset(32)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        tufuh_typeL.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-31)
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(22)
        }
        tufuh_contentL.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(17)
        }

    }
    
    func tukou_resModel(_ model: [String: Any]) {
        tufuh_mDict = model
            
        let tufuh_ulrS = TUOKOUXIUSSStringUtils.tukou_killNil(model["haibao"])

        if let url = URL(string: tufuh_ulrS) {
            tufuh_coverIV.kf.setImage(with: url, options: [.transition(.fade(0.3))])
        }
        tufuh_coverIV.image = UIImage(named: "icon_tukou_bg")
        tufuh_playingIV.image = UIImage(named: "icon_tukou_logo")
        tufuh_typeL.text = "自然场景"
        tufuh_contentL.text = "稳定氛围/长效专注"
        tufuh_lockIV.image = UIImage(named: "icon_tukou_logo")
    }
    
    func tukou_isLock(_ isBool: Bool) {
        if isBool {
            tufuh_lockIV.tukou_setIVCorners(
                [.bottomLeft, .topRight],
                radius: 20,
                borderColor: TUOKOUXIUSwiftZTClr5A,
                borderWidth: 1
            )
            tufuh_lockIV.image = UIImage(named: "icon_tukou_logo")
        } else {
            tufuh_lockIV.image = nil
        }
    }
}
