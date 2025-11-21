
import UIKit

class TUOKOUXIUSwiftHomeTopCell: UITableViewCell {
 
//    private let tufuh_lV: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.TUOKOUXIUSSRGBA(r: 236, g: 236, b: 236, a: 0.1)
//        return view
//    }()
    private let tufuh_playerIV: UIImageView = {
        let imageView = UIImageView()
        imageView.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("icon_tukou_bg", andIsOne: false)
        return imageView
    }()
    private let tufuh_contL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.regular(22)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .orange
        tukou_initV()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tukou_initV() {
//        tufuh_lV.frame = CGRect(x: 10, y: 0, width: TUOKOUXIUSwiftSCRE_W - 20, height: 1)
//        contentView.addSubview(tufuh_lV)
        
        tufuh_playerIV.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H)
        contentView.addSubview(tufuh_playerIV)
        
        tufuh_contL.frame = CGRect(x: 0, y: 200, width: TUOKOUXIUSwiftSCRE_W, height: 50)
        contentView.addSubview(tufuh_contL)
        tufuh_contL.text = "视频占位图"
    }
//    func tukou_contStr(_ string: String?) {
//        tufuh_contL.text = TUOKOUXIUSSStringUtils.tukou_killNil(string)
//    }
}
