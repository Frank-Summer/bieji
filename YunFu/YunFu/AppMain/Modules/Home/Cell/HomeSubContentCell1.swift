
import UIKit
import SnapKit

class HomeSubContentCell1: UITableViewCell {
 
    private let tufuh_titleL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(24)
        label.textAlignment = .center
        return label
    }()
    
    private let tufuh_subTitleL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUWhiteA60
        label.font = TUOKOUXIUSwiftFont.regular(14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tufuh_enterBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = TUOKOUXIUWhiteA10
        button.layer.cornerRadius = 24
        button.titleLabel?.font = TUOKOUXIUSwiftFont.semibold(17)
        button.setTitle("进入", for: .normal)
        button.addTarget(self, action: #selector(tukou_goToMore), for: .touchUpInside)
        return button
    }()
    private let tufuh_contL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUWhiteA80
        label.font = TUOKOUXIUSwiftFont.regular(18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tufuh_lineV: UIView = {
        let v = UIView()
        v.backgroundColor = TUOKOUXIUWhiteA10
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
//        contentView.backgroundColor = .black
        tukou_initV()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var meta: MetaInfo?
    private var introductions: String?
    
    func tukou_resModel(meta: MetaInfo, introductions: String) {
        self.meta = meta
        self.introductions = introductions
        
        tufuh_titleL.text = self.meta?.internalName
        tufuh_subTitleL.text = self.meta?.subTitle

        tufuh_contL.setText(self.introductions ?? "", lineSpacing: 10)
    }
    
    private func tukou_initV() {
        contentView.addSubview(tufuh_titleL)
        contentView.addSubview(tufuh_subTitleL)

        contentView.addSubview(tufuh_enterBtn)
        
        contentView.addSubview(tufuh_contL)
        contentView.addSubview(tufuh_lineV)
        
        
        tufuh_titleL.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W)
            make.height.equalTo(34)
        }
        tufuh_subTitleL.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titleL.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W)
            make.height.equalTo(24)
        }
//        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isOpenHomeMusicExpand {
//            tufuh_enterBtn.backgroundColor = TUOKOUXIUSwiftwuseC
//            
//            tufuh_enterBtn.snp.makeConstraints { make in
//                make.top.equalTo(tufuh_subTitleL.snp.bottom).offset(28)
//                make.left.equalToSuperview().offset(24)
//                make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
//                make.height.equalTo(0.01)
//            }
//            tufuh_contL.snp.makeConstraints { make in
//                make.left.equalToSuperview().offset(24)
//                make.top.equalTo(tufuh_enterBtn.snp.bottom).offset(32)
//                make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
//            }
//        } else {
            tufuh_enterBtn.backgroundColor = TUOKOUXIUWhiteA10
            tufuh_enterBtn.snp.makeConstraints { make in
                make.top.equalTo(tufuh_subTitleL.snp.bottom).offset(28)
                make.left.equalToSuperview().offset(24)
                make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
                make.height.equalTo(48)
            }
            tufuh_contL.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(24)
                make.top.equalTo(tufuh_enterBtn.snp.bottom).offset(32)
                make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
            }
//        }
        
        tufuh_lineV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-1)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
            make.height.equalTo(1)
        }
    }
    
   func tukou_refresh() {
       if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isOpenHomeMusicExpand {
           tufuh_enterBtn.backgroundColor = TUOKOUXIUSwiftwuseC
           tufuh_enterBtn.setTitleColor(TUOKOUXIUSwiftwuseC, for: .normal)
           tufuh_enterBtn.snp.updateConstraints { make in
               make.top.equalTo(tufuh_subTitleL.snp.bottom).offset(28)
               make.left.equalToSuperview().offset(24)
               make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
               make.height.equalTo(0.01)
           }
           tufuh_contL.snp.updateConstraints { make in
               make.left.equalToSuperview().offset(24)
               make.top.equalTo(tufuh_enterBtn.snp.bottom).offset(10)
               make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
           }
       } else {
           tufuh_enterBtn.backgroundColor = TUOKOUXIUWhiteA10
           tufuh_enterBtn.setTitleColor(TUOKOUXIUSwiftbaiseC, for: .normal)
           tufuh_enterBtn.snp.updateConstraints { make in
               make.top.equalTo(tufuh_subTitleL.snp.bottom).offset(28)
               make.left.equalToSuperview().offset(24)
               make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
               make.height.equalTo(48)
           }
           tufuh_contL.snp.updateConstraints { make in
               make.left.equalToSuperview().offset(24)
               make.top.equalTo(tufuh_enterBtn.snp.bottom).offset(32)
               make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
           }
       }
    }
    
    @objc func tukou_goToMore() {
        
    }
//    func tukou_contStr(_ string: String?) {
//        tufuh_contL.text = TUOKOUXIUSSStringUtils.tukou_killNil(string)
//    }
}
