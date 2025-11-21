
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUSwiftHHHHisCell: UICollectionViewCell {
    private var tufuh_mArr: [String] = []
    
    private lazy var tufuh_coverIV: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = TUOKOUXIUSwiftheiseC
        iv.contentMode = .scaleAspectFill
        iv.tukou_roundCor(5)
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var tufuh_camIV: UIImageView = {
            let iv = UIImageView()
            iv.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_cam_tag", andIsOne: false)
            return iv
        }()
    
    private lazy var tufuh_titL: TUOKOUXIUSwiftVerAligTopL = {
            let label = TUOKOUXIUSwiftVerAligTopL()
            label.textColor = TUOKOUXIUSwiftZTClr4A
            label.font = TUOKOUXIUSwiftFont.regular(12)
            label.numberOfLines = 2
            label.tufuh_verAlig = .top
            return label
        }()
    private lazy var tufuh_juNumAndjiNumL: UILabel = {
            let label = UILabel()
            label.backgroundColor = TUOKOUXIUSwiftbaiseC
            label.textColor = TUOKOUXIUSwiftheiseC
            label.font = TUOKOUXIUSwiftFont.medium(10)
            label.textAlignment = .center
            label.tukou_roundCor(2)
            label.layer.masksToBounds = true
            return label
        }()
    
    private lazy var tufuh_currTL: UILabel = {
            let label = UILabel()
            label.backgroundColor = TUOKOUXIUSwiftZTClr6A
            label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.medium(10)
            label.textAlignment = .center
            label.tukou_roundCor(2)
            label.layer.masksToBounds = true
            return label
        }()
    private lazy var tufuh_totalV: UIView = {
        let v = UIView()
        v.backgroundColor = TUOKOUXIUSwiftZTClr3A
        return v
    }()

    private lazy var tufuh_curV: UIView = {
        let v = UIView()
        v.backgroundColor = TUOKOUXIUSwiftZTClr
        return v
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = TUOKOUXIUSwiftheiseC
        contentView.tukou_roundCor(5)
        contentView.clipsToBounds = true
        tukou_conSubV()
        tukou_conLaySubV()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func tukou_conSubV() {
        contentView.addSubview(tufuh_coverIV)
        contentView.addSubview(tufuh_camIV)
        tufuh_coverIV.addSubview(tufuh_juNumAndjiNumL)
        tufuh_coverIV.addSubview(tufuh_currTL)
        contentView.addSubview(tufuh_titL)
        tufuh_coverIV.addSubview(tufuh_totalV)
        tufuh_totalV.addSubview(tufuh_curV)
    }
    private func tukou_conLaySubV() {
        tufuh_coverIV.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 112 * TUOKOUXIUDeviceInfo.scaleX, height: 160 * TUOKOUXIUDeviceInfo.scaleX))
            make.top.left.equalToSuperview()
        }

        tufuh_camIV.snp.makeConstraints { make in
            make.top.left.equalTo(5)
            make.size.equalTo(CGSize(width: 34, height: 16))
        }

        tufuh_juNumAndjiNumL.snp.makeConstraints { make in
            make.top.equalTo(4)
            make.right.equalTo(-4)
            make.height.equalTo(16)
        }

        tufuh_currTL.snp.makeConstraints { make in
            make.bottom.equalTo(-8)
            make.right.equalTo(-4)
            make.height.equalTo(16)
        }

        tufuh_titL.snp.makeConstraints { make in
            make.top.equalTo(tufuh_coverIV.snp.bottom).offset(2)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.bottom.equalToSuperview()
        }

        tufuh_totalV.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(112 * TUOKOUXIUDeviceInfo.scaleX)
            make.height.equalTo(4)
        }

        tufuh_curV.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(0)
            make.height.equalTo(4)
        }
    }
    func tukou_resModel(_ model: [String]) {
        tufuh_mArr = model
        
        if model.count > 9 {
            let urlStr = TUOKOUXIUSSStringUtils.tukou_killNil(model[10])
//            if !urlStr.contains(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[31] as! String) {
//                urlStr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_v_placeStr!
//            }
            tufuh_coverIV.kf.setImage(with: URL(string: urlStr))
            tufuh_titL.text = TUOKOUXIUSSStringUtils.tukou_killNil(model[9])
            
            let curT = CGFloat(Double(model[0]) ?? 0)
            let totT = CGFloat(Double(model[1]) ?? 0)
            let wid = totT > 0 ? curT / totT * 112 * TUOKOUXIUDeviceInfo.scaleX : 0
            tufuh_currTL.text = totT > 0 ? tukou_TimeStr(totT: totT, curT: curT) : "00:00"

            tufuh_curV.snp.updateConstraints { make in
                make.width.equalTo(wid)
            }

            tufuh_juNumAndjiNumL.isHidden = false
            tufuh_juNumAndjiNumL.text = " S\(model[2]) E\(model[8])   "
            tufuh_camIV.isHidden = true
        } else {
            tufuh_juNumAndjiNumL.text = ""
            tufuh_juNumAndjiNumL.isHidden = true

            let urlStr = TUOKOUXIUSSStringUtils.tukou_killNil(model[5])
//            if !urlStr.contains(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[31] as! String) {
//                urlStr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_v_placeStr!
//            }
            tufuh_coverIV.kf.setImage(with: URL(string: urlStr))
            tufuh_titL.text = TUOKOUXIUSSStringUtils.tukou_killNil(model[3])

            if model.count > 8 {
                let hzStr = TUOKOUXIUSSStringUtils.tukou_killNil(model[8])
                tufuh_camIV.isHidden = !(hzStr == "CAM" || hzStr == "TS")
            } else {
                tufuh_camIV.isHidden = true
            }

            let curT = CGFloat(Double(model[0]) ?? 0)
            let totT = CGFloat(Double(model[1]) ?? 0)
            let wid = totT > 0 ? curT / totT * 112 * TUOKOUXIUDeviceInfo.scaleX : 0
            tufuh_currTL.text = totT > 0 ? tukou_TimeStr(totT: totT, curT: curT) : "00:00"

            tufuh_curV.snp.updateConstraints { make in
                make.width.equalTo(wid)
            }
        }
    }
    private func tukou_TimeStr(totT: CGFloat, curT: CGFloat) -> String {
        var syTime = totT - curT
        let shi = Int(syTime / 3600)
        syTime -= CGFloat(shi * 3600)
        let fen = Int(syTime / 60)
        let miao = Int(syTime.truncatingRemainder(dividingBy: 60))

        let shiStr = shi > 0 ? String(format: "%02d", shi) : nil
        let fenStr = String(format: "%02d", fen)
        let miaoStr = String(format: "%02d", miao)

        if let shiStr = shiStr {
            return " \(shiStr):\(fenStr):\(miaoStr)   "
        } else {
            return " \(fenStr):\(miaoStr)   "
        }
    }

}
