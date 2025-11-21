
import UIKit
import SnapKit

class TUOKOUXIUSwiftHomeContentCell4: UITableViewCell {
 
    private let tufuh_titleL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(20)
        label.textAlignment = .left
        return label
    }()
    
    private let tufuh_subTitleL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.medium(18)
        label.textAlignment = .left
        return label
    }()
    
    private let tufuh_contL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.regular(15)
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
        contentView.addSubview(tufuh_contL)
        contentView.addSubview(tufuh_lineV)
        
        tufuh_titleL.text = "工作原理"
        tufuh_subTitleL.text = "音乐结构"
        tufuh_contL.text = """
        五声音阶与更纯和的比率，降低不协和与紧张。
        长音与缓慢包络，减少瞬态干扰，利于持续专注。
        细微随机（1/f 起伏）与呼吸节律，避免听觉疲劳。
        """
        
        tufuh_titleL.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-44)
            make.height.equalTo(40)
        }
        tufuh_subTitleL.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titleL.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(22)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-44)
            make.height.equalTo(20)
        }

        tufuh_contL.snp.makeConstraints { make in
            make.top.equalTo(tufuh_subTitleL.snp.bottom).offset(10)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
            make.left.equalToSuperview().offset(22)
        }
        
        tufuh_lineV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.top.equalTo(tufuh_contL.snp.bottom).offset(10)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
            make.height.equalTo(1)
        }
    }
//    func tukou_contStr(_ string: String?) {
//        tufuh_contL.text = TUOKOUXIUSSStringUtils.tukou_killNil(string)
//    }
}
