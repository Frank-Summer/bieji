
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUSwiftHHHBigCollVCell: UICollectionViewCell {
    
    private var tufuh_mDict: [String: Any] = [:]
    
    var tufuh_ClkItemBlk: (([String: Any], Int) -> Void)?
    
    private lazy var tufuh_v1: UIView = {
        let v = UIView()
        v.backgroundColor = TUOKOUXIUSwiftwuseC
        v.tukou_addTapGesture(target: self, action: #selector(tukou_clickV1))
        return v
    }()
    
    private lazy var tufuh_v2: UIView = {
        let v = UIView()
        v.backgroundColor = TUOKOUXIUSwiftwuseC
        v.tukou_addTapGesture(target: self, action: #selector(tukou_clickV2))
        return v
    }()
    
    private lazy var tufuh_v3: UIView = {
        let v = UIView()
        v.backgroundColor = TUOKOUXIUSwiftwuseC
        v.tukou_addTapGesture(target: self, action: #selector(tukou_clickV3))
        return v
    }()
    private lazy var tufuh_botV: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.TUOKOUXIUSSRGB(r: 23, g: 25, b: 28)
        return v
    }()
    
    private let tufuh_botIV: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.TUOKOUXIUSSRGB(r: 23, g: 25, b: 28)
        return iv
    }()
    
    private let tufuh_botIV2: UIImageView = {
        let iv = UIImageView()
        iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_bot_jb", andIsOne: false)
        return iv
    }()
    private let tufuh_numIV1: UIImageView = {
        let iv = UIImageView()
        iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_cel_p1", andIsOne: false)
        return iv
    }()
    private let tufuh_numIV2: UIImageView = {
        let iv = UIImageView()
        iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_cel_p2", andIsOne: false)
        return iv
    }()
    private let tufuh_numIV3: UIImageView = {
        let iv = UIImageView()
        iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_cel_p3", andIsOne: false)
        return iv
    }()
    private let tufuh_coverIV1: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = TUOKOUXIUSwiftheiseC
        iv.contentMode = .scaleAspectFill
        iv.tukou_roundCor(5)
        return iv
    }()
    
    private let tufuh_coverIV2: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = TUOKOUXIUSwiftheiseC
        iv.contentMode = .scaleAspectFill
        iv.tukou_roundCor(5)
        return iv
    }()
    private let tufuh_coverIV3: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = TUOKOUXIUSwiftheiseC
        iv.contentMode = .scaleAspectFill
        iv.tukou_roundCor(5)
        return iv
    }()
    private let tufuh_starIV1: UIImageView = {
        let iv = UIImageView()
        iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_co_xstar", andIsOne: false)
        return iv
    }()
    
    private let tufuh_starIV2: UIImageView = {
        let iv = UIImageView()
        iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_co_xstar", andIsOne: false)
        return iv
    }()
    private let tufuh_starIV3: UIImageView = {
        let iv = UIImageView()
        iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_co_xstar", andIsOne: false)
        return iv
    }()
    private let tufuh_titL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(16)
        return label
    }()
    private let tufuh_titL1: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(11)
        label.numberOfLines = 2
        return label
    }()
    private let tufuh_titL2: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(11)
        label.numberOfLines = 2
        return label
    }()
    private let tufuh_titL3: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(11)
        label.numberOfLines = 2
        return label
    }()
    private let tufuh_scoreL1: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftZTClr
        label.font = TUOKOUXIUSwiftFont.medium(12)
        label.textAlignment = .left
        return label
    }()
    private let tufuh_scoreL2: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftZTClr
        label.font = TUOKOUXIUSwiftFont.medium(12)
        label.textAlignment = .left
        return label
    }()
    private let tufuh_scoreL3: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftZTClr
        label.font = TUOKOUXIUSwiftFont.medium(12)
        label.textAlignment = .left
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
            
        contentView.addSubview(tufuh_botIV)
        contentView.addSubview(tufuh_botV)
        contentView.addSubview(tufuh_botIV2)
        contentView.addSubview(tufuh_titL)
        contentView.addSubview(tufuh_v1)
        contentView.addSubview(tufuh_v2)
        contentView.addSubview(tufuh_v3)
        
        tufuh_v1.addSubview(tufuh_numIV1)
        tufuh_v2.addSubview(tufuh_numIV2)
        tufuh_v3.addSubview(tufuh_numIV3)
        
        tufuh_v1.addSubview(tufuh_coverIV1)
        tufuh_v2.addSubview(tufuh_coverIV2)
        tufuh_v3.addSubview(tufuh_coverIV3)
        
        tufuh_v1.addSubview(tufuh_titL1)
        tufuh_v2.addSubview(tufuh_titL2)
        tufuh_v3.addSubview(tufuh_titL3)
        
        tufuh_v1.addSubview(tufuh_starIV1)
        tufuh_v2.addSubview(tufuh_starIV2)
        tufuh_v3.addSubview(tufuh_starIV3)
        
        tufuh_v1.addSubview(tufuh_scoreL1)
        tufuh_v2.addSubview(tufuh_scoreL2)
        tufuh_v3.addSubview(tufuh_scoreL3)
    }
    
    private func tukou_conLaySubV() {
        let width: CGFloat = 244
        let heightValue = (3 * (50.0 / 9.0) * 16.0 * TUOKOUXIUDeviceInfo.scaleX + 79.0) / 2.0
        let size = CGSize(width: width, height: heightValue)

        tufuh_botIV.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.size.equalTo(size)
        }
        tufuh_botV.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.size.equalTo(size)
        }
        tufuh_botIV2.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.size.equalTo(size)
        }
        tufuh_titL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(19)
        }
        tufuh_v1.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titL.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.height.equalTo((50/9)*16*TUOKOUXIUDeviceInfo.scaleX)
        }
        tufuh_v2.snp.makeConstraints { make in
            make.top.equalTo(tufuh_v1.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.height.equalTo((50/9)*16*TUOKOUXIUDeviceInfo.scaleX)
        }
        tufuh_v3.snp.makeConstraints { make in
            make.top.equalTo(tufuh_v2.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.height.equalTo((50/9)*16*TUOKOUXIUDeviceInfo.scaleX)
        }
        
        tufuh_numIV1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(((50/9)*16*TUOKOUXIUDeviceInfo.scaleX)/2-25)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(22)
            make.height.equalTo(50)
        }
        
        tufuh_numIV2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(((50/9)*16*TUOKOUXIUDeviceInfo.scaleX)/2-25)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(22)
            make.height.equalTo(50)
        }
        
        tufuh_numIV3.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(((50/9)*16*TUOKOUXIUDeviceInfo.scaleX)/2-25)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(22)
            make.height.equalTo(50)
        }
        
        tufuh_coverIV1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(34)
            make.width.equalTo(50*TUOKOUXIUDeviceInfo.scaleX)
            make.height.equalTo((50/9)*16*TUOKOUXIUDeviceInfo.scaleX)
        }
        
        tufuh_coverIV2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(34)
            make.width.equalTo(50*TUOKOUXIUDeviceInfo.scaleX)
            make.height.equalTo((50/9)*16*TUOKOUXIUDeviceInfo.scaleX)
        }
        
        tufuh_coverIV3.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(34)
            make.width.equalTo(50*TUOKOUXIUDeviceInfo.scaleX)
            make.height.equalTo((50/9)*16*TUOKOUXIUDeviceInfo.scaleX)
        }
        tufuh_titL1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(tufuh_coverIV1.snp.right).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
        tufuh_titL2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(tufuh_coverIV2.snp.right).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
        tufuh_titL3.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(tufuh_coverIV3.snp.right).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
        
        tufuh_starIV1.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titL1.snp.bottom).offset(7)
            make.left.equalTo(tufuh_coverIV1.snp.right).offset(6)
            make.width.height.equalTo(12)
        }
        tufuh_starIV2.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titL2.snp.bottom).offset(7)
            make.left.equalTo(tufuh_coverIV2.snp.right).offset(6)
            make.width.height.equalTo(12)
        }
        tufuh_starIV3.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titL3.snp.bottom).offset(7)
            make.left.equalTo(tufuh_coverIV3.snp.right).offset(6)
            make.width.height.equalTo(12)
        }
        
        tufuh_scoreL1.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titL1.snp.bottom).offset(6)
            make.left.equalTo(tufuh_starIV1.snp.right).offset(2)
            make.height.equalTo(15)
        }
        tufuh_scoreL2.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titL2.snp.bottom).offset(6)
            make.left.equalTo(tufuh_starIV2.snp.right).offset(2)
            make.height.equalTo(15)
        }
        tufuh_scoreL3.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titL3.snp.bottom).offset(6)
            make.left.equalTo(tufuh_starIV3.snp.right).offset(2)
            make.height.equalTo(15)
        }
    }
    
    func tukou_resModel(_ model: [String: Any]) {
        tufuh_mDict = model
        tufuh_titL.text = model["name"] as? String
        let tufuh_botUrl = "\(model["backdrop_path"] ?? "")"
        if TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_botUrl) {
            tufuh_botIV.image = nil
        } else {
            tufuh_botIV.kf.setImage(with: URL(string: tufuh_botUrl), options: [.transition(.fade(0.3))])
        }
        if let tufuh_arr = model["value"] as? [[String: Any]] {
            if tufuh_arr.count >= 3 {
                tukou_hidUI(3)
                let vDict  = tufuh_arr[0]
                let vDict1 = tufuh_arr[1]
                let vDict2 = tufuh_arr[2]
                
                updateTitleAndConstraints(label: tufuh_titL1, cover: tufuh_coverIV1, text: vDict["biaoti"] as? String ?? "")
                updateTitleAndConstraints(label: tufuh_titL2, cover: tufuh_coverIV2, text: vDict1["biaoti"] as? String ?? "")
                updateTitleAndConstraints(label: tufuh_titL3, cover: tufuh_coverIV3, text: vDict2["biaoti"] as? String ?? "")

                tufuh_coverIV1.kf.setImage(with: URL(string: vDict["haibao"] as? String ?? ""), options: [.transition(.fade(0.3))])
                tufuh_coverIV2.kf.setImage(with: URL(string: vDict1["haibao"] as? String ?? ""), options: [.transition(.fade(0.3))])
                tufuh_coverIV3.kf.setImage(with: URL(string: vDict2["haibao"] as? String ?? ""), options: [.transition(.fade(0.3))])
                
                
                tufuh_scoreL1.text = " \(formatScore(vDict["pingfen"])) "
                tufuh_scoreL2.text = " \(formatScore(vDict1["pingfen"])) "
                tufuh_scoreL3.text = " \(formatScore(vDict2["pingfen"])) "
            } else if tufuh_arr.count == 2 {
                tukou_hidUI(2)
                let vDict  = tufuh_arr[0]
                let vDict1 = tufuh_arr[1]

                updateTitleAndConstraints(label: tufuh_titL1, cover: tufuh_coverIV1, text: vDict["biaoti"] as? String ?? "")
                updateTitleAndConstraints(label: tufuh_titL2, cover: tufuh_coverIV2, text: vDict1["biaoti"] as? String ?? "")

                tufuh_coverIV1.kf.setImage(with: URL(string: vDict["haibao"] as? String ?? ""), options: [.transition(.fade(0.3))])
                tufuh_coverIV2.kf.setImage(with: URL(string: vDict1["haibao"] as? String ?? ""), options: [.transition(.fade(0.3))])

                tufuh_scoreL1.text = " \(formatScore(vDict["pingfen"])) "
                tufuh_scoreL2.text = " \(formatScore(vDict1["pingfen"])) "
            } else if tufuh_arr.count == 1 {
                tukou_hidUI(1)
                let vDict = tufuh_arr[0]

                updateTitleAndConstraints(label: tufuh_titL1, cover: tufuh_coverIV1, text: vDict["biaoti"] as? String ?? "")
                tufuh_coverIV1.kf.setImage(with: URL(string: vDict["haibao"] as? String ?? ""), options: [.transition(.fade(0.3))])
                tufuh_scoreL1.text = " \(formatScore(vDict["pingfen"])) "
            }
        }
    }
    
    private func updateTitleAndConstraints(label: UILabel, cover: UIImageView, text: String) {
        label.text = text
        let height = TUOKOUXIUSSStringUtils.tukou_sizWithT(
            text,
            font: TUOKOUXIUSwiftFont.medium(11),
            maxSize: CGSize(width: 144, height: CGFloat.greatestFiniteMagnitude)
        ).height

        label.snp.updateConstraints { make in
            make.left.equalTo(cover.snp.right).offset(5)
            make.top.equalTo(height > 20 ? 12 : 20)
            make.right.equalTo(-10)
        }
    }

    private func formatScore(_ value: Any?) -> String {
        let score = "\(value ?? "")"
        if TUOKOUXISSUUtils.tukou_isStringEmpty(score) || score == "0.0" {
            return "N/A"
        }
        return score
    }
    
    @objc private func tukou_clickV1() {
        tufuh_ClkItemBlk?(tufuh_mDict, 0)
    }
    
    @objc private func tukou_clickV2() {
        tufuh_ClkItemBlk?(tufuh_mDict, 1)
    }
    
    @objc private func tukou_clickV3() {
        tufuh_ClkItemBlk?(tufuh_mDict, 2)
    }
    
    private func tukou_hidUI(_ num: Int) {
        if (num==1) {
            tufuh_v1.isUserInteractionEnabled = true;
            tufuh_v2.isUserInteractionEnabled = false;
            tufuh_v3.isUserInteractionEnabled = false;
            tufuh_starIV1.isHidden = false;
            tufuh_scoreL1.isHidden = false;
            tufuh_starIV2.isHidden = true;
            tufuh_scoreL2.isHidden = true;
            tufuh_starIV3.isHidden = true;
            tufuh_scoreL3.isHidden = true;
            tufuh_numIV1.isHidden = false;
            tufuh_numIV2.isHidden = true;
            tufuh_numIV3.isHidden = true;
            tufuh_titL1.isHidden = false;
            tufuh_titL2.isHidden = true;
            tufuh_titL3.isHidden = true;
            tufuh_coverIV1.isHidden = false;
            tufuh_coverIV2.isHidden = true;
            tufuh_coverIV3.isHidden = true;
        }else if (num==2){
            tufuh_v1.isUserInteractionEnabled = true;
            tufuh_v2.isUserInteractionEnabled = true;
            tufuh_v3.isUserInteractionEnabled = false;
            tufuh_starIV1.isHidden = false;
            tufuh_scoreL1.isHidden = false;
            tufuh_starIV2.isHidden = false;
            tufuh_scoreL2.isHidden = false;
            tufuh_starIV3.isHidden = true;
            tufuh_scoreL3.isHidden = true;
            tufuh_numIV1.isHidden = false;
            tufuh_numIV2.isHidden = false;
            tufuh_numIV3.isHidden = true;
            tufuh_titL1.isHidden = false;
            tufuh_titL2.isHidden = false;
            tufuh_titL3.isHidden = true;
            tufuh_coverIV1.isHidden = false;
            tufuh_coverIV2.isHidden = false;
            tufuh_coverIV3.isHidden = true;
        }else{
            tufuh_v1.isUserInteractionEnabled = true;
            tufuh_v2.isUserInteractionEnabled = true;
            tufuh_v3.isUserInteractionEnabled = true;
            tufuh_starIV1.isHidden = false;
            tufuh_scoreL1.isHidden = false;
            tufuh_starIV2.isHidden = false;
            tufuh_scoreL2.isHidden = false;
            tufuh_starIV3.isHidden = false;
            tufuh_scoreL3.isHidden = false;
            tufuh_numIV1.isHidden = false;
            tufuh_numIV2.isHidden = false;
            tufuh_numIV3.isHidden = false;
            tufuh_titL1.isHidden = false;
            tufuh_titL2.isHidden = false;
            tufuh_titL3.isHidden = false;
            tufuh_coverIV1.isHidden = false;
            tufuh_coverIV2.isHidden = false;
            tufuh_coverIV3.isHidden = false;
        }
    }
}
