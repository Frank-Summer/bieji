

import Foundation
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUSwiftMyListCell: UICollectionViewCell {
    var clickMoreBlock: (() -> Void)?
    var clickSelectBlock: ((Bool) -> Void)?
    private var tufuh_mArr: [String] = []
    
    func tukou_resModel(_ model: [Any]) {
        self.tufuh_mArr = model.map { "\($0)" }
        
        if self.tufuh_mArr.count > 9 {
            tufuh_botIV.isHidden = false
            var tufuh_ulrS = TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[10])
            if !tufuh_ulrS.contains(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[31] as! String) {
                tufuh_ulrS = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_v_placeStr!
            }
            tufuh_coverIV.kf.setImage(with: URL(string: tufuh_ulrS))
            tufuh_titL.text = TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[9])
            
            var tufuh_conS = TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[11])
            if TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_conS) || tufuh_conS == "0.0" {
                    tufuh_conS = "N/A"
                }
            tufuh_numV.tufuh_numLabel.text = " \(tufuh_conS) "
            let tufuh_xin = TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[3])
            if tufuh_xin == "1" {
                tufuh_botIV.isHidden = false
                tufuh_typeL.isHidden = false
                tufuh_paraL.isHidden = false
                tufuh_paraL.text = "· \(TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[0])) \(TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[1]))"
            } else {
                tufuh_botIV.isHidden = true
                tufuh_typeL.isHidden = true
                tufuh_paraL.isHidden = true
            }
            tufuh_camIV.isHidden = true
        } else {
            let tufuh_xin = TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[2])
            if tufuh_xin == "1" {
                tufuh_botIV.isHidden = false
                tufuh_typeL.isHidden = false
                tufuh_paraL.isHidden = false
                tufuh_paraL.text = "· \(TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[0])) \(TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[1]))"
            } else {
                tufuh_botIV.isHidden = true
                tufuh_typeL.isHidden = true
                tufuh_paraL.isHidden = true
            }
            var tufuh_conS = TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[6])
            if TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_conS) || tufuh_conS == "0.0" {
                tufuh_conS = "N/A"
            }
            tufuh_numV.tufuh_numLabel.text = " \(tufuh_conS) "
            
            var tufuh_ulrS = TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[5])
            if !tufuh_ulrS.contains(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[31] as! String) {
                tufuh_ulrS = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_v_placeStr!
            }
            tufuh_coverIV.kf.setImage(with: URL(string: tufuh_ulrS))
                
            tufuh_titL.text = TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[3])
                
            if tufuh_mArr.count > 8 {
                let tufuh_hzStr = TUOKOUXIUSSStringUtils.tukou_killNil(self.tufuh_mArr[8])
                if tufuh_hzStr == "CAM" || tufuh_hzStr == "TS" {
                    tufuh_camIV.isHidden = false
                } else {
                    tufuh_camIV.isHidden = true
                }
            } else {
                tufuh_camIV.isHidden = true
            }
        }
    }
    
    func tukou_resEdit(_ isEdit: Bool) {
        tufuh_botSelBtn.isSelected = false
        if isEdit {
            tufuh_botMoreBtn.isHidden = true
            tufuh_botSelBtn.isHidden = false
        } else {
            tufuh_botMoreBtn.isHidden = false
            tufuh_botSelBtn.isHidden = true
        }
    }
    
    func tukou_resSelectAll(_ isSelectAll: Bool) {
        tufuh_botSelBtn.isSelected = isSelectAll
    }
    
    @objc func tukou_goToSelect(_ sender: UIButton) {
        sender.isSelected.toggle()
        clickSelectBlock?(sender.isSelected)
    }
    private lazy var tufuh_coverIV: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = TUOKOUXIUSwiftheiseC
        imageView.contentMode = .scaleAspectFill
        imageView.tukou_roundCor(5)
        return imageView
    }()
    private lazy var tufuh_camIV: UIImageView = {
        let imageView = UIImageView()
        imageView.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_cam_tag", andIsOne: false)
        return imageView
    }()
    private lazy var tufuh_botIV: UIImageView = {
        let imageView = UIImageView()
        imageView.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_cov_bot_gradual", andIsOne: false)
        return imageView
    }()
    private lazy var tufuh_botV: UIView = {
        let v = UIView()
        v.backgroundColor = TUOKOUXIUSwiftheiseC
        v.tukou_roundCor(5)
        return v
    }()
    private lazy var tufuh_titL: TUOKOUXIUSwiftVerAligTopL = {
        let label = TUOKOUXIUSwiftVerAligTopL()
        label.textColor = TUOKOUXIUSwiftZTClr4A
        label.font = TUOKOUXIUSwiftFont.regular(12)
        label.tufuh_verAlig = .top
        label.numberOfLines = 2
        return label
    }()
    private lazy var tufuh_botMoreBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_his_more", andIsOne: false), for: .normal)
        button.addTarget(self, action: #selector(tukou_goToMore), for: .touchUpInside)
        button.isHidden = false
        return button
    }()
    @objc private func tukou_goToMore() {
        clickMoreBlock?()
    }
    private lazy var tufuh_numV: TUOKOUXIUSwiftRouCornVL = {
        let label = TUOKOUXIUSwiftRouCornVL()
        label.backgroundColor = TUOKOUXIUSwiftZTClr
        return label
    }()
    private lazy var tufuh_typeL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.medium(10)
        label.text = "New"
        return label
    }()
    private lazy var tufuh_paraL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.medium(10)
        return label
    }()
    private lazy var tufuh_botSelBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_his_nosel", andIsOne: false), for: .normal)
        button.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_his_select", andIsOne: false), for: .selected)
        button.addTarget(self, action: #selector(tukou_goToSelect), for: .touchUpInside)
        button.isHidden = true
        return button
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
        tufuh_coverIV.addSubview(tufuh_botIV)
        
        contentView.addSubview(tufuh_camIV)
        contentView.addSubview(tufuh_botV)
        contentView.addSubview(tufuh_titL)
        contentView.addSubview(tufuh_numV)
        
        tufuh_botIV.addSubview(tufuh_typeL)
        tufuh_botIV.addSubview(tufuh_paraL)
        
        contentView.addSubview(tufuh_botMoreBtn)
        contentView.addSubview(tufuh_botSelBtn)
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
        tufuh_botIV.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(24)
        }
        tufuh_botV.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(tufuh_coverIV.snp.bottom).offset(0)
        }
        
        tufuh_titL.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(tufuh_coverIV.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-29)
        }
        tufuh_botMoreBtn.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.right.equalToSuperview()
            make.top.equalTo(tufuh_coverIV.snp.bottom).offset(5)
        }
        
        tufuh_botSelBtn.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.right.equalToSuperview()
            make.top.equalTo(tufuh_coverIV.snp.bottom).offset(5)
        }
        tufuh_numV.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(26)
            make.top.right.equalToSuperview()
        }
        
        tufuh_paraL.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().offset(-4)
            make.top.equalToSuperview().offset(5)
        }
        tufuh_typeL.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-4)
            make.top.equalToSuperview().offset(5)
            make.right.equalTo(tufuh_paraL.snp.left).offset(-3)
        }
    }
}

