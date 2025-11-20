

import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUSwiftCycPagVCell: UICollectionViewCell {
    
    private var tufuh_dataDict: [String: Any] = [:]
    
    private let tufuh_coveTIV = UIImageView()
    private let tufuh_coveBIV = UIImageView()
    private let tufuh_botJIV: UIImageView = {
        let iv = UIImageView()
        iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_cel_bot_j", andIsOne: false)
        return iv
    }()
    
    private let tufuh_xIV: UIImageView = {
        let iv = UIImageView()
        iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_cel_x", andIsOne: false)
        return iv
    }()

    private let tufuh_bIV: UIImageView = {
        let iv = UIImageView()
        iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_cel_b", andIsOne: false)
        return iv
    }()

    private let tufuh_fenL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(20)
        return label
    }()

    private let tufuh_lxL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.light(10)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = TUOKOUXIUSwiftwuseC
        tukou_conSubV()
        tukou_conLaySubV()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = TUOKOUXIUSwiftwuseC
        tukou_conSubV()
        tukou_conLaySubV()
    }

    private func tukou_conSubV() {
        contentView.addSubview(tufuh_coveTIV)
        contentView.addSubview(tufuh_coveBIV)
        contentView.addSubview(tufuh_botJIV)
        contentView.addSubview(tufuh_xIV)
        contentView.addSubview(tufuh_bIV)
        contentView.addSubview(tufuh_fenL)
        contentView.addSubview(tufuh_lxL)
    }

    private func tukou_conLaySubV() {
        tufuh_coveTIV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(-(TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60))
        }

        tufuh_coveBIV.snp.makeConstraints { make in
            make.top.equalTo(TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60)
            make.left.right.bottom.equalToSuperview()
        }

        tufuh_botJIV.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(60)
        }

        tufuh_xIV.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.bottom.equalTo(-25)
            make.width.height.equalTo(24)
        }

        tufuh_bIV.snp.makeConstraints { make in
            make.bottom.equalTo(-22)
            make.right.equalTo(-12)
            make.width.height.equalTo(40)
        }

        tufuh_fenL.snp.makeConstraints { make in
            make.left.equalTo(35)
            make.bottom.equalTo(-25)
            make.height.equalTo(24)
            make.width.equalTo(60)
        }

        tufuh_lxL.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.bottom.equalTo(-9)
            make.right.equalTo(-130)
            make.height.equalTo(12)
        }
    }

    func tukou_resData(_ dataDict: [String: Any]) {
        tufuh_dataDict = dataDict

        let tufuh_ulrS = TUOKOUXIUSSStringUtils.tukou_killNil(dataDict["whaibao"] as? String)

        if !tufuh_ulrS.isEmpty, let url = URL(string: tufuh_ulrS) {
            tufuh_coveTIV.kf.setImage(with: url, options: [.transition(.fade(0.3))]) { result in
                switch result {
                case .success(let value):
                    self.tufuh_coveTIV.image = value.image.tukou_applyDarkEffectGPU()
                default:
                    break
                }
            }
            tufuh_coveBIV.kf.setImage(with: url, options: [.transition(.fade(0.3))])
        }

        if let tufuh_fenS = dataDict["pingfen"] as? String,
           !TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_fenS),
           tufuh_fenS != "0.0" {
            tufuh_fenL.text = tufuh_fenS
        } else {
            tufuh_fenL.text = "N/A"
        }

        var tufuh_genS = dataDict["genre"] as? String ?? ""
        if TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_genS) {
            tufuh_lxL.text = ""
        } else {
            if tufuh_genS.contains(",") {
                tufuh_genS = tufuh_genS.replacingOccurrences(of: ",", with: " · ")
            }
            tufuh_lxL.text = tufuh_genS
        }
    }
}
