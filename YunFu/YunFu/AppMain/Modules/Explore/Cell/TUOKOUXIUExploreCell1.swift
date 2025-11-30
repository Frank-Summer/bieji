
import UIKit
import SnapKit

//enum TufuhItemNew {
//    case dict([String: Any])
//    case array([Any])
//}

class TUOKOUXIUExploreCell1: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var tufuh_collcV: UICollectionView!
    var tufuh_priDict: [String: Any] = [:]
    
//    private var tufuh_dataArr: [TufuhItemNew] = []
    
    private let tufuh_titleL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftZTClr3
        label.font = TUOKOUXIUSwiftFont.semibold(24)
        label.text = "为你推荐"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .black
        contentView.isUserInteractionEnabled = true
        tukou_initV()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tukou_initV() {
        contentView.addSubview(tufuh_titleL)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        tufuh_collcV = UICollectionView(frame: CGRect(x: 0, y: 64, width: TUOKOUXIUSwiftSCRE_W, height: 92), collectionViewLayout: layout)
        tufuh_collcV.delegate = self
        tufuh_collcV.dataSource = self
        tufuh_collcV.backgroundColor = TUOKOUXIUSwiftheiseC
        tufuh_collcV.showsHorizontalScrollIndicator = false
        
        tufuh_collcV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TUOKOUXIUExploreTabVHisDefCellId")
        tufuh_collcV.register(TUOKOUXIUExploreCollVCell.self, forCellWithReuseIdentifier: "TUOKOUXIUExploreCollVCellId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollReuV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TUOKOUXIUExploreTbColHeReuVId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollReuV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUExploreTbColFoReuVId")
        tufuh_collcV.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUExploreTabVHisDefSuppVId")
        tufuh_collcV.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TUOKOUXIUExploreTabVHisDefSuppVId")
        
        contentView.addSubview(tufuh_collcV)
        
        tufuh_titleL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(32)
        }
        
    }
//    func tukou_contStr(_ string: String?) {
//        tufuh_contL.text = TUOKOUXIUSSStringUtils.tukou_killNil(string)
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return min(tufuh_dataArr.count, 20)
        return 10
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

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUExploreCollVCellId", for: indexPath) as! TUOKOUXIUExploreCollVCell
        cell.tukou_resModel(["name":""])
//        switch tufuh_dataArr[indexPath.row] {
//        case .dict(let dict):
//            cell.tukou_resModel(dict)
//        case .array(_): break
//        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if tufuh_dataArr.isEmpty { return .zero }
        return CGSize(width: 60, height: 92)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 20, height: 92)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 20, height: 92)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TUOKOUXIUExploreTbColFoReuVId", for: indexPath)
        } else if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TUOKOUXIUExploreTbColHeReuVId", for: indexPath)
        }
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TUOKOUXIUExploreTabVHisDefSuppVId", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    //列间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (TUOKOUXIUSwiftSCRE_W-40-4*60)/3
    }
    //一行的话不生效
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    
    func tukou_resData(_ dataArray: [Any]) {
//        tufuh_dataArr = dataArray.map { item in
//            if let dict = item as? [String: Any] {
//                return TufuhItemNew.dict(dict)
//            } else if let arr = item as? [Any] {
//                return TufuhItemNew.array(arr)
//            } else {
//                return TufuhItemNew.dict([:])
//            }
//        }
        tufuh_collcV.reloadData()
    }
}
