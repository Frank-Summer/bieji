
import Foundation
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUSwiftHisCell: UICollectionViewCell {
    var TUOKOUXIUclickMoreBlock: (() -> Void)?
    var TUOKOUXIUclickSelectBlock: ((Bool) -> Void)?

    private var tufuh_mArr: [String] = []
    
    func tukou_resModel(_ model: [Any]) {
        self.tufuh_mArr = model.map { "\($0)" }
        
        if self.tufuh_mArr.count > 9 {
            var tufuh_ulrS = TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[10])
            if !tufuh_ulrS.contains(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[31] as! String) {
                tufuh_ulrS = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_v_placeStr!
            }
            tufuh_coverIV.kf.setImage(with: URL(string: tufuh_ulrS))
            tufuh_titL.text = TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[9])
            
            let curT = toCGFloat(self.tufuh_mArr[0])
            let totT = toCGFloat(self.tufuh_mArr[1])
            var wid = curT / totT * 112 * TUOKOUXIUDeviceInfo.scaleX
            if totT <= 0 || curT < 0 {
                wid = 0
                tufuh_currTL.text = "00:00"
            } else {
                tufuh_currTL.text = tukou_TimeStr(totT: totT, curT: curT)
            }
            
            tufuh_curV.snp.updateConstraints { make in
                make.top.left.equalToSuperview()
                make.width.equalTo(wid)
                make.height.equalTo(4)
            }
            
            tufuh_juNumAndjiNumL.isHidden = false
            tufuh_juNumAndjiNumL.text = " S\(tufuh_mArr[2]) E\(tufuh_mArr[8])   "
            tufuh_camIV.isHidden = true
        } else {
            tufuh_juNumAndjiNumL.text = ""
            tufuh_juNumAndjiNumL.isHidden = true
            
            var tufuh_ulrS = TUOKOUXIUSSStringUtils.tukou_killNil(tufuh_mArr[5])
            if !tufuh_ulrS.contains(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[31] as! String) {
                tufuh_ulrS = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_v_placeStr!
            }
            tufuh_coverIV.kf.setImage(with: URL(string: tufuh_ulrS))
            tufuh_titL.text = TUOKOUXIUSSStringUtils.tukou_killNil(tufuh_mArr[3])
            
            if tufuh_mArr.count > 8 {
                let tufuh_hzStr = TUOKOUXIUSSStringUtils.tukou_killNil(tufuh_mArr[8])
                if tufuh_hzStr == "CAM" || tufuh_hzStr == "TS" {
                    tufuh_camIV.isHidden = false
                } else {
                    tufuh_camIV.isHidden = true
                }
            } else {
                tufuh_camIV.isHidden = true
            }
            
            let curT = toCGFloat(self.tufuh_mArr[0])
            let totT = toCGFloat(self.tufuh_mArr[1])
            var wid = curT / totT * 112 * TUOKOUXIUDeviceInfo.scaleX
            if totT <= 0 || curT < 0 {
                wid = 0
                tufuh_currTL.text = "00:00"
            } else {
                tufuh_currTL.text = tukou_TimeStr(totT: totT, curT: curT)
            }
            
            tufuh_curV.snp.updateConstraints { make in
                make.top.left.equalToSuperview()
                make.width.equalTo(wid)
                make.height.equalTo(4)
            }
        }
    }
    
    private func toCGFloat(_ value: Any?) -> CGFloat {
        if let num = value as? NSNumber {
            return CGFloat(num.floatValue)
        }
        if let str = value as? NSString {
            return CGFloat(str.floatValue)
        }
        return 0
    }
    
    private func tukou_TimeStr(totT: CGFloat, curT: CGFloat) -> String {
        let syTime = totT - curT
        let shi = Int(syTime / 3600)
        var fen = 0
        var miao = 0
        
        if shi == 0 {
            if syTime >= 60 {
                fen = Int(syTime / 60)
                miao = Int(syTime) - fen * 60
            } else {
                fen = 0
                miao = Int(syTime)
            }
        } else {
            fen = Int((syTime - CGFloat(shi) * 3600) / 60)
            miao = Int(syTime) - shi * 3600 - fen * 60
        }
        
        let shiStr = shi == 0 ? "" : String(format: "0%d", shi)
        let fenStr = fen == 0 ? "00" : (fen < 10 ? String(format: "0%d", fen) : "\(fen)")
        let miaoStr = miao == 0 ? "00" : (miao < 10 ? String(format: "0%d", miao) : "\(miao)")
        
        if !shiStr.isEmpty {
            return " \(shiStr):\(fenStr):\(miaoStr)   "
        } else {
            return " \(fenStr):\(miaoStr)   "
        }
    }
    
    func tukou_resEdit(_ isEdit: Bool) {
        tufuh_botSelectBtn.isSelected = false
        if isEdit {
            tufuh_botMoreBtn.isHidden = true
            tufuh_botSelectBtn.isHidden = false
        } else {
            tufuh_botMoreBtn.isHidden = false
            tufuh_botSelectBtn.isHidden = true
        }
    }
    
    func tukou_resSelectAll(_ isSelectAll: Bool) {
        tufuh_botSelectBtn.isSelected = isSelectAll
    }
    
    @objc func tukou_goToSelect(_ sender: UIButton) {
        sender.isSelected.toggle()
        TUOKOUXIUclickSelectBlock?(sender.isSelected)
    }
    
    @objc private func tukou_goToMore() {
        TUOKOUXIUclickMoreBlock?()
    }
    
    private lazy var tufuh_coverIV: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = TUOKOUXIUSwiftheiseC
        imageView.contentMode = .scaleAspectFill
        imageView.tukou_roundCor(5)
        return imageView
    }()
    
    private lazy var tufuh_botMoreBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_his_more", andIsOne: false), for: .normal)
        button.addTarget(self, action: #selector(tukou_goToMore), for: .touchUpInside)
        button.isHidden = false
        return button
    }()
    
    lazy var tufuh_botSelectBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_his_nosel", andIsOne: false), for: .normal)
        button.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_his_select", andIsOne: false), for: .selected)
        button.addTarget(self, action: #selector(tukou_goToSelect), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private lazy var tufuh_camIV: UIImageView = {
        let imageView = UIImageView()
        imageView.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_cam_tag", andIsOne: false)
        return imageView
    }()
    
    private lazy var tufuh_juNumAndjiNumL: UILabel = {
        let label = UILabel()
        label.backgroundColor = TUOKOUXIUSwiftbaiseC
        label.textColor = TUOKOUXIUSwiftheiseC
        label.font = TUOKOUXIUSwiftFont.medium(10)
        label.textAlignment = .center
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var tufuh_titL: TUOKOUXIUSwiftVerAligTopL = {
        let label = TUOKOUXIUSwiftVerAligTopL()
        label.textColor = TUOKOUXIUSwiftZTClr4A
        label.font = TUOKOUXIUSwiftFont.regular(12)
        label.tufuh_verAlig = .top
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var tufuh_currTL: UILabel = {
        let label = UILabel()
        label.backgroundColor = TUOKOUXIUSwiftZTClr6A
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.medium(10)
        label.textAlignment = .center
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var tufuh_botV: UIView = {
        let v = UIView()
        v.backgroundColor = TUOKOUXIUSwiftheiseC
        v.tukou_roundCor(5)
        return v
    }()
    
    private lazy var tufuh_curV: UIView = {
        let v = UIView()
        v.backgroundColor = TUOKOUXIUSwiftZTClr
        return v
    }()
    
    private lazy var tufuh_totalV: UIView = {
        let v = UIView()
        v.backgroundColor = TUOKOUXIUSwiftZTClr3A
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tukou_conSubV()
        tukou_conLaySubV()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tukou_conSubV()
        tukou_conLaySubV()
    }
    
    private func tukou_conSubV() {
        contentView.backgroundColor = TUOKOUXIUSwiftheiseC
        self.tukou_roundCor(5)
        contentView.addSubview(tufuh_coverIV)
        contentView.addSubview(tufuh_camIV)
        tufuh_coverIV.addSubview(tufuh_juNumAndjiNumL)
        tufuh_coverIV.addSubview(tufuh_currTL)
        
        contentView.addSubview(tufuh_botV)
        contentView.addSubview(tufuh_titL)
        contentView.addSubview(tufuh_botMoreBtn)
        contentView.addSubview(tufuh_botSelectBtn)
        
        tufuh_coverIV.addSubview(tufuh_totalV)
        tufuh_totalV.addSubview(tufuh_curV)
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
        tufuh_juNumAndjiNumL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.height.equalTo(16)
        }
        tufuh_currTL.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-4)
            make.height.equalTo(16)
        }
        
        tufuh_botV.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.left.equalToSuperview()
            make.top.equalTo(tufuh_coverIV.snp.bottom).offset(0)
        }
        tufuh_titL.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-29)
            make.top.equalTo(tufuh_coverIV.snp.bottom).offset(2)
        }
        
        tufuh_botMoreBtn.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.right.equalToSuperview()
            make.top.equalTo(tufuh_coverIV.snp.bottom).offset(5)
        }
        tufuh_botSelectBtn.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.right.equalToSuperview()
            make.top.equalTo(tufuh_coverIV.snp.bottom).offset(5)
        }
        
        tufuh_totalV.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview()
            make.width.equalTo(112 * TUOKOUXIUDeviceInfo.scaleX)
            make.height.equalTo(4)
        }
        tufuh_curV.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(0)
            make.height.equalTo(4)
        }
    }
}
