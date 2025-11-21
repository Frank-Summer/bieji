
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUSwiftHHHCollVCell: UICollectionViewCell {
    
    private var tufuh_mDict: [String: Any] = [:]
    let tufuh_numIV = UIImageView()
    private let tufuh_coverIV: UIImageView = {
            let iv = UIImageView()
            iv.backgroundColor = TUOKOUXIUSwiftheiseC
            iv.contentMode = .scaleAspectFill
            iv.tukou_roundCor(5)
            iv.clipsToBounds = true
            return iv
        }()
    private let tufuh_camIV: UIImageView = {
            let iv = UIImageView()
            iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_cam_tag", andIsOne: false)
            return iv
        }()
    private let tufuh_botIV: UIImageView = {
            let iv = UIImageView()
            iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_cov_blue", andIsOne: false)
            return iv
        }()
    
    private let tufuh_titL: TUOKOUXIUSwiftVerAligTopL = {
            let label = TUOKOUXIUSwiftVerAligTopL()
            label.textColor = TUOKOUXIUSwiftZTClr4A
        label.font = TUOKOUXIUSwiftFont.regular(12)
            label.numberOfLines = 2
            label.tufuh_verAlig = .top
            return label
        }()
    private let tufuh_numV: TUOKOUXIUSwiftRouCornVL = {
            let v = TUOKOUXIUSwiftRouCornVL()
            v.backgroundColor = TUOKOUXIUSwiftZTClr
            return v
        }()
    private let tufuh_typeL: UILabel = {
            let label = UILabel()
            label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(11)
            label.text = "New"
            label.textAlignment = .center
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
            contentView.tukou_roundCor(5)
            contentView.clipsToBounds = true
            
            contentView.addSubview(tufuh_coverIV)
            tufuh_coverIV.addSubview(tufuh_numIV)
            tufuh_coverIV.addSubview(tufuh_botIV)
            tufuh_botIV.addSubview(tufuh_typeL)
            
            contentView.addSubview(tufuh_camIV)
            contentView.addSubview(tufuh_titL)
            contentView.addSubview(tufuh_numV)
        }
    
    private func tukou_conLaySubV() {
            tufuh_coverIV.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: 112 * TUOKOUXIUDeviceInfo.scaleX, height: 160 * TUOKOUXIUDeviceInfo.scaleX))
                make.top.left.equalToSuperview()
            }
            
            tufuh_camIV.snp.makeConstraints { make in
                make.top.left.equalToSuperview().offset(5)
                make.size.equalTo(CGSize(width: 34, height: 16))
            }
            
            tufuh_numIV.snp.makeConstraints { make in
                make.right.bottom.equalToSuperview()
                make.size.equalTo(CGSize(width: 42, height: 59))
            }
            
            tufuh_botIV.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.left.equalTo(56 * TUOKOUXIUDeviceInfo.scaleX - 22)
                make.size.equalTo(CGSize(width: 44, height: 17))
            }
            
            tufuh_typeL.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            tufuh_titL.snp.makeConstraints { make in
                make.top.equalTo(tufuh_coverIV.snp.bottom).offset(2)
                make.left.equalToSuperview().offset(5)
                make.right.equalToSuperview().offset(-5)
                make.bottom.equalToSuperview()
            }
            
            tufuh_numV.snp.makeConstraints { make in
                make.right.top.equalToSuperview()
                make.size.equalTo(CGSize(width: 26, height: 16))
            }
        }
    
    func tukou_resModel(_ model: [String: Any]) {
            tufuh_mDict = model
            
        let tufuh_ulrS = TUOKOUXIUSSStringUtils.tukou_killNil(model["haibao"])
//            if !tufuh_ulrS.contains(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[31] as! String) {
//                tufuh_ulrS = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_v_placeStr!
//            }
            if let url = URL(string: tufuh_ulrS) {
                tufuh_coverIV.kf.setImage(with: url, options: [.transition(.fade(0.3))])
            }
            tufuh_titL.text = TUOKOUXIUSSStringUtils.tukou_killNil(model["biaoti"])
            
            var tufuh_conS = TUOKOUXIUSSStringUtils.tukou_killNil(model["pingfen"])
            if TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_conS) || tufuh_conS == "0.0" {
                tufuh_conS = "N/A"
            }
            tufuh_numV.tufuh_numLabel.text = " \(tufuh_conS) "
            
            let tufuh_lx = Int("\(model["leixing"] ?? "0")") ?? 0
            let tufuh_xin = Int("\(model["xin"] ?? "0")") ?? 0
            
            tufuh_botIV.isHidden = tufuh_xin != 1
            tufuh_typeL.isHidden = tufuh_xin != 1
            
            if tufuh_lx == 1 {
                tufuh_camIV.isHidden = true
            } else {
                let huazhi = model["huazhi"] as? String ?? ""
                tufuh_camIV.isHidden = !(huazhi == "CAM" || huazhi == "TS")
            }
        }
}
