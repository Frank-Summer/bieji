
import UIKit
import SnapKit

class TUOKOUXIUSwiftHomeContentCell6: UITableViewCell {
 
    private let tufuh_titleL: UILabel = {
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
        contentView.addSubview(tufuh_contL)
        contentView.addSubview(tufuh_lineV)
        
        tufuh_titleL.text = "东方意象"
        tufuh_contL.text = """
        敲钵回响象征“收束与释怀”，余音延长时间感。
        木鱼弱节律如禅定计数，“念起即觉”。
        吟诵远近交替，构建“内外一体”的心灵殿堂。
        """
        
        tufuh_titleL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(22)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-44)
            make.height.equalTo(20)
        }

        tufuh_contL.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titleL.snp.bottom).offset(10)
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
