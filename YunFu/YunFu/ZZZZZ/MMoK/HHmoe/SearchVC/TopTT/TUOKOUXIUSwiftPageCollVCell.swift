
import UIKit
import SnapKit

class TUOKOUXIUSwiftPageCollVCell: UICollectionViewCell {
    var tufuh_numV = TUOKOUXIUSwiftRouCornV()
    private var tufuh_coverIV = UIImageView()
    private var tufuh_camIV = UIImageView()
    private var tufuh_botIV = UIImageView()
    private var tufuh_titL = TUOKOUXIUSwiftVerAligTopL()
    private var tufuh_typeL = UILabel()
    private var tufuh_paraL = UILabel()
    private var tufuh_mDict: [String: Any] = [:]
    
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

        tufuh_coverIV.backgroundColor = TUOKOUXIUSwiftheiseC
        tufuh_coverIV.contentMode = .scaleAspectFill
        tufuh_coverIV.tukou_roundCor(5)
        tufuh_coverIV.clipsToBounds = true

        tufuh_botIV.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_cov_bot_gradual", andIsOne: false)

        tufuh_camIV.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_cam_tag", andIsOne: false)

        tufuh_titL.textColor = TUOKOUXIUSwiftZTClr4A
        tufuh_titL.font = TUOKOUXIUSwiftFont.regular(12)
        tufuh_titL.numberOfLines = 2
        tufuh_titL.tufuh_verAlig = .top

        tufuh_typeL.textColor = UIColor.TUOKOUXIUSSRGB(r: 255, g: 109, b: 28)
        tufuh_typeL.font = TUOKOUXIUSwiftFont.semibold(8)
        tufuh_typeL.text = "New"

        tufuh_paraL.textColor = TUOKOUXIUSwiftZTClr3A
        tufuh_paraL.font = TUOKOUXIUSwiftFont.semibold(8)

        contentView.addSubview(tufuh_coverIV)
        tufuh_coverIV.addSubview(tufuh_botIV)
        contentView.addSubview(tufuh_camIV)
        contentView.addSubview(tufuh_titL)
        tufuh_botIV.addSubview(tufuh_typeL)
        tufuh_botIV.addSubview(tufuh_paraL)
        contentView.addSubview(tufuh_numV)
    }
    private func tukou_conLaySubV() {
        tufuh_coverIV.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 112 * TUOKOUXIUDeviceInfo.scaleX, height: 160 * TUOKOUXIUDeviceInfo.scaleX))
            make.top.left.equalToSuperview()
        }

        tufuh_camIV.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.right.equalTo(-5)
            make.width.equalTo(34)
            make.height.equalTo(16)
        }

        tufuh_botIV.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(24)
        }

        tufuh_titL.snp.makeConstraints { make in
            make.top.equalTo(tufuh_coverIV.snp.bottom).offset(2)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.bottom.equalToSuperview()
        }

        tufuh_paraL.snp.makeConstraints { make in
            make.right.equalTo(-5)
            make.top.equalTo(7)
            make.bottom.equalTo(-7)
        }

        tufuh_typeL.snp.makeConstraints { make in
            make.right.equalTo(tufuh_paraL.snp.left).offset(-2)
            make.top.equalTo(7)
            make.bottom.equalTo(-7)
        }

        tufuh_numV.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
    func tukou_resModel(_ model: [String: Any]) {
        tufuh_mDict = model

//        var tufuh_urlS = TUOKOUXIUSSStringUtils.tukou_killNil(model["haibao"])
//        if !tufuh_urlS.contains(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[31] as! String) {
//            tufuh_urlS = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_v_placeStr!
//        }
//        tufuh_coverIV.kf.setImage(with: URL(string: tufuh_urlS))

        tufuh_titL.text = TUOKOUXIUSSStringUtils.tukou_killNil(model["biaoti"])

        let tufuh_lx = Int("\(model["leixing"] ?? "0")") ?? 0
        let tufuh_xin = Int("\(model["xin"] ?? "0")") ?? 0

        if tufuh_xin == 1 {
            tufuh_botIV.isHidden = false
            tufuh_typeL.isHidden = false
            tufuh_paraL.isHidden = false
            let year = TUOKOUXIUSSStringUtils.tukou_killNil(model["nian"])
            let time = TUOKOUXIUSSStringUtils.tukou_killNil(model["shijian"])
            tufuh_paraL.text = "| \(year) \(time)"
        } else {
            tufuh_botIV.isHidden = true
            tufuh_typeL.isHidden = true
            tufuh_paraL.isHidden = true
        }

        if tufuh_lx == 1 {
            tufuh_camIV.isHidden = true
        } else {
            let huazhi = model["huazhi"] as? String ?? ""
            tufuh_camIV.isHidden = !(huazhi == "CAM" || huazhi == "TS")
        }
    }
    
}
