
import UIKit
import SnapKit
import Kingfisher

class TUOKOUXIUSwiftCycleDYCell: UICollectionViewCell {
    
    private var tufuh_dataStr: String?
    private lazy var tufuh_coverIV: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = TUOKOUXIUSwiftwuseC
        tukou_conSubV()
        tukou_conLaySubV()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = TUOKOUXIUSwiftwuseC
        tukou_conSubV()
        tukou_conLaySubV()
    }
    private func tukou_conSubV() {
        contentView.addSubview(tufuh_coverIV)
    }
    
    private func tukou_conLaySubV() {
        tufuh_coverIV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func tukou_resData(_ string: String) {
        self.tufuh_dataStr = string
        if let url = URL(string: string) {
            tufuh_coverIV.kf.setImage(with: url, options: [.transition(.fade(0.3))])
        }
    }
}
