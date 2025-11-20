
import UIKit

class TUOKOUXIUSSTagCollVCell: UICollectionViewCell {
    
    var tufuh_titL: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(tufuh_titL)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tufuh_titL.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tufuh_titL.text = ""
    }
}
