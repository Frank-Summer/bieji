
import UIKit
import SnapKit

class HomeSubContentCell2: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var tufuh_collcV: UICollectionView!
    
    private var tufuh_explpreArray: [ExploreItem] = []
    
    private let tufuh_titleL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(20)
        label.text = "探索深睡眠"
        return label
    }()
    
    private lazy var tufuh_lineV: UIView = {
        let v = UIView()
        v.backgroundColor = TUOKOUXIUWhiteA10
        return v
    }()
    
    func tukou_resModel(explpreArray: [ExploreItem]) {
        self.tufuh_explpreArray = explpreArray
        tufuh_collcV.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
//        contentView.backgroundColor = .black
        contentView.isUserInteractionEnabled = true
        tukou_initV()
    }
    
    func tukou_refresh() {
        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isOpenHomeMusicExpand {
            tufuh_titleL.isHidden = true
            tufuh_collcV.isHidden = true
            tufuh_lineV.isHidden = true
        } else {
            tufuh_titleL.isHidden = false
            tufuh_collcV.isHidden = false
            tufuh_lineV.isHidden = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tukou_initV() {
        contentView.addSubview(tufuh_titleL)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        tufuh_collcV = UICollectionView(frame: CGRect(x: 0, y: 60, width: TUOKOUXIUSwiftSCRE_W, height: 185 * TUOKOUXIUDeviceInfo.scaleX), collectionViewLayout: layout)
        tufuh_collcV.delegate = self
        tufuh_collcV.dataSource = self
        tufuh_collcV.backgroundColor = TUOKOUXIUSwiftwuseC
        tufuh_collcV.showsHorizontalScrollIndicator = false
        
        tufuh_collcV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TUOKOUXIUHHHTabVHisDefCellId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollVCell.self, forCellWithReuseIdentifier: "TUOKOUXIUHHHTabCollVCellId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollReuV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TUOKOUXIUHHHTbColHeReuVId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollReuV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUHHHTbColFoReuVId")
        tufuh_collcV.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUHHHTabVHisDefSuppVId")
        tufuh_collcV.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TUOKOUXIUHHHTabVHisDefSuppVId")
        
        contentView.addSubview(tufuh_collcV)
        contentView.addSubview(tufuh_lineV)
        
        
        tufuh_titleL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(32)
        }
        
        tufuh_lineV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-1)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
            make.height.equalTo(1)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tufuh_explpreArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHHHTabCollVCellId", for: indexPath) as! TUOKOUXIUSwiftHHHCollVCell
        if self.tufuh_explpreArray.count > 0 {
            let model = self.tufuh_explpreArray[indexPath.row]
            cell.tukou_resModel(model: model)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 144 * TUOKOUXIUDeviceInfo.scaleX, height: 185 * TUOKOUXIUDeviceInfo.scaleX)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 16, height: 185 * TUOKOUXIUDeviceInfo.scaleX)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 16, height: 185 * TUOKOUXIUDeviceInfo.scaleX)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TUOKOUXIUHHHTbColFoReuVId", for: indexPath)
        } else if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TUOKOUXIUHHHTbColHeReuVId", for: indexPath)
        }
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TUOKOUXIUHHHTabVHisDefSuppVId", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    //列间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    //一行的话不生效
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    
}
