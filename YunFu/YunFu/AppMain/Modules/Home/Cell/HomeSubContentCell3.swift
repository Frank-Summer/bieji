
import UIKit
import SnapKit

enum TufuhItemNew2 {
    case dict([String: Any])
    case array([Any])
}

class HomeSubContentCell3: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var tufuh_collcV: UICollectionView!
    var tufuh_priDict: [String: Any] = [:]
    
    private var tufuh_dataArr: [TufuhItemNew2] = []
    
    private var tufuh_bannerArray: [BannerItem] = []
    
    private lazy var tufuh_lineV: UIView = {
        let v = UIView()
        v.backgroundColor = TUOKOUXIUWhiteA10
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
//        contentView.backgroundColor = .black
        contentView.isUserInteractionEnabled = true
        tukou_initV()
    }
    
    func tukou_resModel(banners: [BannerItem]) {
        self.tufuh_bannerArray = banners
        tufuh_collcV.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tukou_initV() {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        tufuh_collcV = UICollectionView(frame: CGRect(x: 0, y: 10 * TUOKOUXIUDeviceInfo.scaleX, width: TUOKOUXIUSwiftSCRE_W, height: 320 * TUOKOUXIUDeviceInfo.scaleX), collectionViewLayout: layout)
        tufuh_collcV.delegate = self
        tufuh_collcV.dataSource = self
        tufuh_collcV.backgroundColor = TUOKOUXIUSwiftwuseC
        tufuh_collcV.showsHorizontalScrollIndicator = false
        
        tufuh_collcV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TUOKOUXIUHomeDefaultCellId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollVCell2.self, forCellWithReuseIdentifier: "TUOKOUXIUHomeTableViewCollCellId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollReuV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TUOKOUXIUHomeHeadViewId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollReuV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUHomeFooterViewId")
        tufuh_collcV.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUHomeDefaultSupplementaryViewId")
        tufuh_collcV.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TUOKOUXIUHomeDefaultSupplementaryViewId")
        
        contentView.addSubview(tufuh_collcV)
        contentView.addSubview(tufuh_lineV)
        
        tufuh_lineV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-1)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
            make.height.equalTo(1)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tufuh_bannerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch tufuh_dataArr[indexPath.row] {
//        case .dict(let dict):
//            tufuh_clkItemBlk?(dict)
//        case .array(let arr):
//            tufuh_clkItemArrBlk?(arr)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if tufuh_dataArr.isEmpty {
//            return collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHomeDefaultCellId", for: indexPath)
//        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHomeTableViewCollCellId", for: indexPath) as! TUOKOUXIUSwiftHHHCollVCell2
        if self.tufuh_bannerArray.count > 0 {
            let model = self.tufuh_bannerArray[indexPath.row]
            cell.tukou_resModel(model: model)
        }
//        switch tufuh_dataArr[indexPath.row] {
//        case .dict(let dict):
//            cell.tukou_resModel(dict)
//        case .array(_): break
//        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if tufuh_dataArr.isEmpty { return .zero }
        return CGSize(width: 240 * TUOKOUXIUDeviceInfo.scaleX, height: 320 * TUOKOUXIUDeviceInfo.scaleX)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 16, height: 320 * TUOKOUXIUDeviceInfo.scaleX)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 16, height: 320 * TUOKOUXIUDeviceInfo.scaleX)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TUOKOUXIUHomeFooterViewId", for: indexPath)
        } else if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TUOKOUXIUHomeHeadViewId", for: indexPath)
        }
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TUOKOUXIUHomeDefaultSupplementaryViewId", for: indexPath)
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
    
    func tukou_resData(_ dataArray: [Any]) {
        tufuh_dataArr = dataArray.map { item in
            if let dict = item as? [String: Any] {
                return TufuhItemNew2.dict(dict)
            } else if let arr = item as? [Any] {
                return TufuhItemNew2.array(arr)
            } else {
                return TufuhItemNew2.dict([:])
            }
        }
        tufuh_collcV.reloadData()
    }
}
