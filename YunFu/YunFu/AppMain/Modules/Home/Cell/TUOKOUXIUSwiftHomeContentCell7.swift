
import UIKit
import SnapKit

class TUOKOUXIUSwiftHomeContentCell7: UITableViewCell {
    
    private let tufuh_titleL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(22)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var tufuh_hintIV: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_blocking")
        return imageView
    }()
    
    private let tufuh_subTitleL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(17)
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
        contentView.addSubview(tufuh_hintIV)
        contentView.addSubview(tufuh_subTitleL)
        contentView.addSubview(tufuh_contL)
        contentView.addSubview(tufuh_lineV)
        
        tufuh_titleL.text = "声音与乐器"
        tufuh_subTitleL.text = "敲钵："
        tufuh_contL.text = """
        长尾泛音，4–7秒自然衰减
        """
        
        tufuh_titleL.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-44)
            make.height.equalTo(40)
        }
        
        tufuh_hintIV.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titleL.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(22)
            make.width.height.equalTo(24)
        }
        tufuh_subTitleL.snp.makeConstraints { make in
            make.left.equalTo(tufuh_hintIV.snp.right).offset(10)
            make.top.equalTo(tufuh_titleL.snp.bottom).offset(10)
            make.height.equalTo(24)
        }

        tufuh_contL.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titleL.snp.bottom).offset(10)
            make.left.equalTo(tufuh_subTitleL.snp.right).offset(10)
            make.height.equalTo(24)
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
