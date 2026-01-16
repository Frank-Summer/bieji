
import UIKit
import SnapKit

class HomeSubContentCell9: UITableViewCell {
    
    private lazy var tufuh_hintIV: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_blocking")
        return imageView
    }()
    
    private let tufuh_subTitleL: UILabel = {
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
        
        contentView.addSubview(tufuh_hintIV)
        contentView.addSubview(tufuh_subTitleL)
        contentView.addSubview(tufuh_contL)
        
        tufuh_hintIV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(24)
            make.width.height.equalTo(24)
        }
        tufuh_subTitleL.snp.makeConstraints { make in
            make.left.equalTo(tufuh_hintIV.snp.right).offset(10)
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(24)
        }

        tufuh_contL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.left.equalTo(tufuh_subTitleL.snp.right).offset(10)
        }
    }
    func tukou_resModel(acousticItem: AcousticItem) {
        self.tufuh_model = acousticItem
        tufuh_subTitleL.text = "\(self.tufuh_model?.name ?? "")："
        tufuh_contL.setText(self.tufuh_model?.description ?? "", lineSpacing: 6)
    }
}
