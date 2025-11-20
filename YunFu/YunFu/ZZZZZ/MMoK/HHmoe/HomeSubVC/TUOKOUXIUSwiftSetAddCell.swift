
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUSwiftSetAddCell: UICollectionViewCell {
    private var tufuh_mArr: [String] = []
    private lazy var tufuh_coverIV: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = TUOKOUXIUSwiftheiseC
        imageView.contentMode = .scaleAspectFill
        imageView.tukou_roundCor(5)
        imageView.clipsToBounds = true
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
    private lazy var tufuh_titL: TUOKOUXIUSwiftVerAligTopL = {
        let label = TUOKOUXIUSwiftVerAligTopL()
        label.textColor = TUOKOUXIUSwiftZTClr4A
        label.font = TUOKOUXIUSwiftFont.regular(12)
        label.numberOfLines = 2
        label.tufuh_verAlig = .top
        return label
    }()
    private lazy var tufuh_numV: TUOKOUXIUSwiftRouCornVL = {
        let view = TUOKOUXIUSwiftRouCornVL()
        view.backgroundColor = TUOKOUXIUSwiftZTClr
        return view
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
        tufuh_coverIV.addSubview(tufuh_botIV)
        contentView.addSubview(tufuh_camIV)
        contentView.addSubview(tufuh_titL)
        contentView.addSubview(tufuh_numV)
        tufuh_botIV.addSubview(tufuh_typeL)
        tufuh_botIV.addSubview(tufuh_paraL)
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
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(24)
        }

        tufuh_titL.snp.makeConstraints { make in
            make.top.equalTo(tufuh_coverIV.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview()
        }

        tufuh_numV.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 26, height: 16))
        }

        tufuh_paraL.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-4)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-4)
        }

        tufuh_typeL.snp.makeConstraints { make in
            make.right.equalTo(tufuh_paraL.snp.left).offset(-3)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    func tukou_resModel(_ model: [String]) {
        self.tufuh_mArr = model

        if model.count > 9 {
            tufuh_botIV.isHidden = false
            var urlStr = TUOKOUXIUSSStringUtils.tukou_killNil(model[10])
            if !urlStr.contains(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[31] as! String) {
                urlStr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_v_placeStr!
            }

            tufuh_coverIV.kf.setImage(with: URL(string: urlStr))
            tufuh_titL.text = TUOKOUXIUSSStringUtils.tukou_killNil(model[9])

            var countStr = TUOKOUXIUSSStringUtils.tukou_killNil(model[11])
            if TUOKOUXISSUUtils.tukou_isStringEmpty(countStr) || countStr == "0.0" {
                countStr = "N/A"
            }
            tufuh_numV.tufuh_numLabel.text = " \(countStr) "

            let xin = TUOKOUXIUSSStringUtils.tukou_killNil(model[3])
            if xin == "1" {
                tufuh_botIV.isHidden = false
                tufuh_typeL.isHidden = false
                tufuh_paraL.isHidden = false
                tufuh_paraL.text = "· \(TUOKOUXIUSSStringUtils.tukou_killNil(model[0])) \(TUOKOUXIUSSStringUtils.tukou_killNil(model[1]))"
            } else {
                tufuh_botIV.isHidden = true
                tufuh_typeL.isHidden = true
                tufuh_paraL.isHidden = true
            }

            tufuh_camIV.isHidden = true

        } else {
            let xin = TUOKOUXIUSSStringUtils.tukou_killNil(model[2])
            if xin == "1" {
                tufuh_botIV.isHidden = false
                tufuh_typeL.isHidden = false
                tufuh_paraL.isHidden = false
                tufuh_paraL.text = "· \(TUOKOUXIUSSStringUtils.tukou_killNil(model[0])) \(TUOKOUXIUSSStringUtils.tukou_killNil(model[1]))"
            } else {
                tufuh_botIV.isHidden = true
                tufuh_typeL.isHidden = true
                tufuh_paraL.isHidden = true
            }

            var countStr = TUOKOUXIUSSStringUtils.tukou_killNil(model[6])
            if TUOKOUXISSUUtils.tukou_isStringEmpty(countStr) || countStr == "0.0" {
                countStr = "N/A"
            }
            tufuh_numV.tufuh_numLabel.text = " \(countStr) "

            var urlStr = TUOKOUXIUSSStringUtils.tukou_killNil(model[5])
            if !urlStr.contains(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[31] as! String) {
                urlStr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_v_placeStr!
            }
            tufuh_coverIV.kf.setImage(with: URL(string: urlStr))
            tufuh_titL.text = TUOKOUXIUSSStringUtils.tukou_killNil(model[3])

            if model.count > 8 {
                let hzStr = TUOKOUXIUSSStringUtils.tukou_killNil(model[8])
                tufuh_camIV.isHidden = !(hzStr == "CAM" || hzStr == "TS")
            } else {
                tufuh_camIV.isHidden = true
            }
        }
    }
}
