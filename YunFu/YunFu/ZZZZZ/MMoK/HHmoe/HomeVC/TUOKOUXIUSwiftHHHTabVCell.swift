
import UIKit
import Foundation

typealias TUOKOUXIU_ClkItemBlk = (_ dict: [String: Any]) -> Void
typealias TUOKOUXIU_ClkItemArrBlk = (_ array: [Any]) -> Void
typealias TUOKOUXIU_ClkAdGuideBlk = () -> Void

enum TufuhItem {
    case dict([String: Any])
    case array([Any])
}

class TUOKOUXIUSwiftHHHTabVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var tufuh_collcV: UICollectionView!
    var tufuh_priDict: [String: Any] = [:]
    var tufuh_isHis: Bool = false
    var tufuh_isFirstMonth: Bool = false
    var tufuh_isAddList: Bool = false
    var tufuh_isZhanShiAd: Bool = false {
        didSet {
            tukou_isZhanShiAd(tufuh_isZhanShiAd)
        }
    }
    var tufuh_clkItemBlk: TUOKOUXIU_ClkItemBlk?
    var tufuh_clkItemArrBlk: TUOKOUXIU_ClkItemArrBlk?
    var tufuh_clkAdGuideBlk: TUOKOUXIU_ClkAdGuideBlk?
    var tufuh_isTop: Bool = false
    
    private var tufuh_zhanShiAdV: UIView?
    private var tufuh_dataArr: [TufuhItem] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        tukou_initV()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.selectionStyle = .none
        tukou_initV()
    }
    
    private func tukou_initV() {
        contentView.backgroundColor = TUOKOUXIUSwiftheiseC
        contentView.isUserInteractionEnabled = true
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        tufuh_collcV = UICollectionView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 160 * TUOKOUXIUDeviceInfo.scaleX + 40), collectionViewLayout: layout)
        tufuh_collcV.delegate = self
        tufuh_collcV.dataSource = self
        tufuh_collcV.backgroundColor = TUOKOUXIUSwiftheiseC
        tufuh_collcV.showsHorizontalScrollIndicator = false
        
        tufuh_collcV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TUOKOUXIUHHHTabVHisDefCellId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHHisCell.self, forCellWithReuseIdentifier: "TUOKOUXIUHHHTabVHisCellId")
        tufuh_collcV.register(TUOKOUXIUSwiftSetAddCell.self, forCellWithReuseIdentifier: "TUOKOUXIUSetTabAddCellId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollVCell.self, forCellWithReuseIdentifier: "TUOKOUXIUHHHTabCollVCellId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollReuV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TUOKOUXIUHHHTbColHeReuVId")
        tufuh_collcV.register(TUOKOUXIUSwiftHHHCollReuV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUHHHTbColFoReuVId")
        tufuh_collcV.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUHHHTabVHisDefSuppVId")
        tufuh_collcV.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TUOKOUXIUHHHTabVHisDefSuppVId")
        
        contentView.addSubview(tufuh_collcV)
    }
    
    @objc private func tukou_clickAdGuide() {
        tufuh_clkAdGuideBlk?()
    }
    
    private func tukou_isZhanShiAd(_ value: Bool) {
        if value {
            if tufuh_zhanShiAdV != nil { return }
            let view = UIView(frame: CGRect(x: 10, y: 160 * TUOKOUXIUDeviceInfo.scaleX + 45, width: TUOKOUXIUSwiftSCRE_W - 20, height: 60))
            view.backgroundColor = TUOKOUXIUSwiftwuseC
            contentView.addSubview(view)
            tufuh_zhanShiAdV = view
            
            let _ = UIImageView.tukou_bjImageV(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W - 20, height: 60),
                                               superView: view,
                                               image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_bg_vip", andIsOne: false))
            
            let _ = UILabel.tukou_bjLabel(CGRect(x: 10, y: 7, width: TUOKOUXIUSwiftSCRE_W - 50, height: 21),
                                          text: "Special Offer For You",
                                          superView: view,
                                          textAlignment: .left,
                                          font: UIFont.boldSystemFont(ofSize: 16),
                                          textColor: TUOKOUXIUSwiftZTClr2)
            
            let tufuh_priStr = tufuh_priDict["price"] as? String ?? ""
            let tufuh_w = TUOKOUXIUSSStringUtils.tukou_sizWithT(tufuh_priStr,
                                                                font: UIFont.boldSystemFont(ofSize: 16),
                                                                maxSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 18)).width
            let _ = UILabel.tukou_bjLabel(CGRect(x: 10, y: 31, width: tufuh_w, height: 22),
                                          text: tufuh_priStr,
                                          superView: view,
                                          textAlignment: .left,
                                          font: UIFont.boldSystemFont(ofSize: 16),
                                          textColor: TUOKOUXIUSwiftZTClr2)
            
            var tufuh_timeStr = "for 1 \(tufuh_priDict["time"] ?? "")"
            if tufuh_isFirstMonth {
                tufuh_timeStr = "for the 1st \(tufuh_priDict["time"] ?? "")"
            }
            let _ = UILabel.tukou_bjLabel(CGRect(x: 14 + tufuh_w, y: 36, width: 200, height: 15),
                                          text: tufuh_timeStr,
                                          superView: view,
                                          textAlignment: .left,
                                          font: UIFont.systemFont(ofSize: 11),
                                          textColor: TUOKOUXIUSwiftZTClr2)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tukou_clickAdGuide))
            view.addGestureRecognizer(tap)
        } else {
            if (tufuh_zhanShiAdV != nil) {
                tufuh_zhanShiAdV!.removeFromSuperview()
                tufuh_zhanShiAdV = nil
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(tufuh_dataArr.count, 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch tufuh_dataArr[indexPath.row] {
        case .dict(let dict):
            tufuh_clkItemBlk?(dict)
        case .array(let arr):
            tufuh_clkItemArrBlk?(arr)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if tufuh_dataArr.isEmpty {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHHHTabVHisDefCellId", for: indexPath)
        }
        if tufuh_isHis {
            if tufuh_isAddList {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUSetTabAddCellId", for: indexPath) as! TUOKOUXIUSwiftSetAddCell
                switch tufuh_dataArr[indexPath.row] {
                case .dict(_): break
                case .array(let arr):
                    if let sArr = arr as? [String] {
                        cell.tukou_resModel(sArr)
                    } else {
                        let sArr = arr.map { element -> String in
                            if let s = element as? String { return s }
                            if let n = element as? NSNumber { return n.stringValue }
                            return "\(element)"
                        }
                        cell.tukou_resModel(sArr)
                    }
                }
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHHHTabVHisCellId", for: indexPath) as! TUOKOUXIUSwiftHHHHisCell
                switch tufuh_dataArr[indexPath.row] {
                case .dict(_): break
                case .array(let arr):
                    if let sArr = arr as? [String] {
                        cell.tukou_resModel(sArr)
                    } else {
                        let sArr = arr.map { element -> String in
                            if let s = element as? String { return s }
                            if let n = element as? NSNumber { return n.stringValue }
                            return "\(element)"
                        }
                        cell.tukou_resModel(sArr)
                    }
                }
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHHHTabCollVCellId", for: indexPath) as! TUOKOUXIUSwiftHHHCollVCell
            if indexPath.row < 3 {
                if tufuh_isTop {
                    cell.tufuh_numIV.isHidden = false
                    let imageName: String
                    switch indexPath.row {
                    case 0: imageName = "TUOKOUXIU_ic_hh_cel_top1"
                    case 1: imageName = "TUOKOUXIU_ic_hh_cel_top2"
                    default: imageName = "TUOKOUXIU_ic_hh_cel_top3"
                    }
                    cell.tufuh_numIV.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon(imageName, andIsOne: false)
                } else {
                    cell.tufuh_numIV.isHidden = true
                }
            } else {
                cell.tufuh_numIV.isHidden = true
            }
            switch tufuh_dataArr[indexPath.row] {
            case .dict(let dict):
                cell.tukou_resModel(dict)
            case .array(_): break
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if tufuh_dataArr.isEmpty { return .zero }
        return CGSize(width: 112 * TUOKOUXIUDeviceInfo.scaleX, height: 160 * TUOKOUXIUDeviceInfo.scaleX + 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 10, height: 160 * TUOKOUXIUDeviceInfo.scaleX + 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 10, height: 160 * TUOKOUXIUDeviceInfo.scaleX + 34)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func tukou_resData(_ dataArray: [Any]) {
        tufuh_dataArr = dataArray.map { item in
            if let dict = item as? [String: Any] {
                return TufuhItem.dict(dict)
            } else if let arr = item as? [Any] {
                return TufuhItem.array(arr)
            } else {
                return TufuhItem.dict([:])
            }
        }
        tufuh_collcV.reloadData()
    }
    
}
