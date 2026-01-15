
import UIKit
import SnapKit

class HomeSubContentCell99: UITableViewCell {
    
    private let tufuh_titleL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(14)
        return label
    }()
    

    private let tufuh_contL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUWhiteA60
        label.font = TUOKOUXIUSwiftFont.regular(14)
        label.numberOfLines = 0
        return label
    }()
    private var tufuh_model: AcousticItem?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = TUOKOUXIUSwiftwuseC
        tukou_initV()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tukou_initV() {
        
        contentView.addSubview(tufuh_titleL)
        contentView.addSubview(tufuh_contL)

        tufuh_titleL.text = "音乐结构"
        tufuh_contL.text = "五声音阶与更纯"
        
        tufuh_titleL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(20)
        }

        tufuh_contL.snp.makeConstraints { make in
            make.top.equalTo(tufuh_titleL.snp.bottom).offset(10)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
            make.left.equalToSuperview().offset(24)
        }
    }
    
    func tukou_resModel(acousticItem: AcousticItem) {
        self.tufuh_model = acousticItem
        tufuh_titleL.text = self.tufuh_model?.tag
        tufuh_contL.setText(self.tufuh_model?.description ?? "", lineSpacing: 6)
    }
}
