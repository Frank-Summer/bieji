
import UIKit

class TUOKOUXIUSwiftSSSReCell: UITableViewCell {
 
    private let tufuh_lV: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.TUOKOUXIUSSRGBA(r: 236, g: 236, b: 236, a: 0.1)
        return view
    }()
    private let tufuh_searIV: UIImageView = {
        let imageView = UIImageView()
        imageView.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_cel_search", andIsOne: false)
        return imageView
    }()
    private let tufuh_contL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftZTClr4A
        label.font = TUOKOUXIUSwiftFont.regular(12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = TUOKOUXIUSwiftheiseC
        tukou_initV()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tukou_initV() {
        tufuh_lV.frame = CGRect(x: 10, y: 0, width: TUOKOUXIUSwiftSCRE_W - 20, height: 1)
        contentView.addSubview(tufuh_lV)
        
        tufuh_searIV.frame = CGRect(x: 10, y: 17, width: 16, height: 16)
        contentView.addSubview(tufuh_searIV)
        
        tufuh_contL.frame = CGRect(x: 36, y: 15, width: TUOKOUXIUSwiftSCRE_W - 46, height: 20)
        contentView.addSubview(tufuh_contL)
    }
    func tukou_contStr(_ string: String?) {
        tufuh_contL.text = TUOKOUXIUSSStringUtils.tukou_killNil(string)
    }
}
