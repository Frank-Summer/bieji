
import UIKit
import SnapKit

class TUOKOUXIUSwiftHomeContentCell1: UITableViewCell {
 
    private let tufuh_titleL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(22)
        label.textAlignment = .center
        return label
    }()
    
    private let tufuh_subTitleL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.regular(15)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tufuh_enterBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 12
        button.setTitle("进入", for: .normal)
        button.addTarget(self, action: #selector(tukou_goToMore), for: .touchUpInside)
        return button
    }()
    private let tufuh_contL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.regular(18)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tufuh_lineV: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .black
        tukou_initV()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tukou_initV() {
        contentView.addSubview(tufuh_titleL)
        contentView.addSubview(tufuh_subTitleL)
        contentView.addSubview(tufuh_enterBtn)
        contentView.addSubview(tufuh_contL)
        contentView.addSubview(tufuh_lineV)
        
        tufuh_titleL.text = "东方禅境"
        tufuh_subTitleL.text = "空灵东方之声，抚平内在涟漪"
        tufuh_contL.text = """
        以东方器物与吟诵为灵感，营造静谧而温和的内在空间。
        不同于情绪化的常规音乐，它弱化节拍与旋律锋芒，以延绵的泛音与宽阔的空间感，轻轻包裹专注与休息。
        你无需刻意参与，声音会在不知不觉间抚平紧张与脑疲劳，让思绪慢慢安住于当下。
        """
        
        tufuh_titleL.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W)
            make.height.equalTo(30)
        }
        tufuh_subTitleL.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titleL.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W)
            make.height.equalTo(20)
        }
        tufuh_enterBtn.snp.makeConstraints { make in
            make.top.equalTo(tufuh_subTitleL.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
            make.height.equalTo(44)
        }
        tufuh_contL.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.top.equalTo(tufuh_enterBtn.snp.bottom).offset(10)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
        }
        
        tufuh_lineV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.top.equalTo(tufuh_contL.snp.bottom).offset(10)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
            make.height.equalTo(1)
        }
    }
    
    @objc func tukou_goToMore() {
        
    }
//    func tukou_contStr(_ string: String?) {
//        tufuh_contL.text = TUOKOUXIUSSStringUtils.tukou_killNil(string)
//    }
}
