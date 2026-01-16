
import UIKit
import SnapKit

enum TufuhItemNew3 {
    case dict([String: Any])
    case array([Any])
}

class HomeSubContentCell8: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var tufuh_collcV: UICollectionView!
    var tufuh_priDict: [String: Any] = [:]
    
    private var tufuh_dataArr: [TufuhItemNew3] = []
    private var tufuh_socialProofsArray: [SocialProof] = []
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
//        contentView.backgroundColor = .black
        contentView.isUserInteractionEnabled = true
        tukou_initV()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tukou_initV() {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        tufuh_collcV = UICollectionView(frame: CGRect(x: 0, y: 16, width: TUOKOUXIUSwiftSCRE_W, height: 134), collectionViewLayout: layout)
        tufuh_collcV.delegate = self
        tufuh_collcV.dataSource = self
        tufuh_collcV.backgroundColor = TUOKOUXIUSwiftwuseC
        tufuh_collcV.showsHorizontalScrollIndicator = false
        
        tufuh_collcV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TUOKOUXIUHHHTabVHisDefCellId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollVCell3.self, forCellWithReuseIdentifier: "TUOKOUXIUHHHTabCollVCellId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollReuV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TUOKOUXIUHHHTbColHeReuVId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollReuV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUHHHTbColFoReuVId")
        tufuh_collcV.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUHHHTabVHisDefSuppVId")
        tufuh_collcV.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TUOKOUXIUHHHTabVHisDefSuppVId")
        
        contentView.addSubview(tufuh_collcV)
        
    }
    
    func tukou_resModel(tufuh_socialProofsArray: [SocialProof]) {
        self.tufuh_socialProofsArray = tufuh_socialProofsArray
        tufuh_collcV.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tufuh_socialProofsArray.count
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
//            return collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHHHTabVHisDefCellId", for: indexPath)
//        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHHHTabCollVCellId", for: indexPath) as! TUOKOUXIUSwiftHHHCollVCell3
        if self.tufuh_socialProofsArray.count > 0 {
            let model = self.tufuh_socialProofsArray[indexPath.row]
            cell.tukou_resModel(model: model)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if tufuh_dataArr.isEmpty { return .zero }
        return CGSize(width: 180, height: 134)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 16, height: 134)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 16, height: 134)
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
    
    func tukou_resData(_ dataArray: [Any]) {
        tufuh_dataArr = dataArray.map { item in
            if let dict = item as? [String: Any] {
                return TufuhItemNew3.dict(dict)
            } else if let arr = item as? [Any] {
                return TufuhItemNew3.array(arr)
            } else {
                return TufuhItemNew3.dict([:])
            }
        }
        tufuh_collcV.reloadData()
    }
}

