
import Foundation
import UIKit
import Combine

class TUOKOUXIUSwiftPageVC: TUOKOUXIUSwiftBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var tufuh_dataTreArr: [Dictionary<String, Any>] = []
    var tufuh_num: Int = 0
    var tufuh_source: String = ""
    private var cancellables = Set<AnyCancellable>()

    private var tufuh_banH: CGFloat = 0.0
    
    lazy var tufuh_collcV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coll.delegate = self
        coll.dataSource = self
        coll.backgroundColor = TUOKOUXIUSwiftheiseC
        coll.showsVerticalScrollIndicator = false
        coll.keyboardDismissMode = .onDrag
        coll.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TUOKOUXIUTopTJCollVDefCellId")
        coll.register(TUOKOUXIUSwiftPageCollVCell.self, forCellWithReuseIdentifier: "TUOKOUXIUTopTJCollVCellId")
        return coll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if TUOKOUXIUSSApp.tukou_isPad() {
            tufuh_banH = 90
        } else {
            tufuh_banH = 50
        }
        
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUSouSuoHeight"))
            .sink { [weak self] _ in self?.tukou_sousuoHeight() }
            .store(in: &cancellables)

        view.backgroundColor = TUOKOUXIUSwiftheiseC
        
        var tufuh_h: CGFloat = 0

            tufuh_h = TUOKOUXIUSwiftSCRE_H - (TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 56 + 10) - 84
        
        
        if let hisArr = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisSearArr) as? [String] {
            var tufuh_hV: CGFloat = 80
            var numH = 1
            var numN = 0
            let tufuh_w = TUOKOUXIUSwiftSCRE_W - 40
            var tufuh_w2: CGFloat = 0
            let maxSize = CGSize(width: TUOKOUXIUSwiftSCRE_W - 40, height: 30)
            
            for (i, st1) in hisArr.enumerated() {
                let frame = (st1 as NSString).boundingRect(
                    with: maxSize,
                    options: [.usesFontLeading, .usesLineFragmentOrigin],
                    attributes: [.font: TUOKOUXIUSwiftFont.regular(14)],
                    context: nil
                )
                if i > 0 { numN = 10 }
                tufuh_w2 += (frame.size.width + 20) + CGFloat(numN)
                if tufuh_w2 + 10 > tufuh_w {
                    tufuh_w2 = frame.size.width + 20
                    numH += 1
                    tufuh_hV = 130
                    if numH == 3 {
                        tufuh_hV = 170
                        break
                    }
                }
            }
            tufuh_h -= tufuh_hV
        }
        
        tufuh_collcV.frame = CGRect(x: 10, y: 10, width: TUOKOUXIUSwiftSCRE_W - 20, height: tufuh_h - 10)
        view.addSubview(tufuh_collcV)
        tufuh_collcV.reloadData()
    }
    
    func tukou_sousuoHeight() {
        var tufuh_h: CGFloat = 0

            tufuh_h = TUOKOUXIUSwiftSCRE_H - (TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 56 + 10) - 84
        
        
        if let hisArr = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisSearArr) as? [String] {
            var tufuh_hV: CGFloat = 80
            var numH = 1
            var numN = 0
            let tufuh_w = TUOKOUXIUSwiftSCRE_W - 40
            var tufuh_w2: CGFloat = 0
            let maxSize = CGSize(width: TUOKOUXIUSwiftSCRE_W - 40, height: 30)
            
            for (i, st1) in hisArr.enumerated() {
                let frame = (st1 as NSString).boundingRect(
                    with: maxSize,
                    options: [.usesFontLeading, .usesLineFragmentOrigin],
                    attributes: [.font: TUOKOUXIUSwiftFont.regular(14)],
                    context: nil
                )
                if i > 0 { numN = 10 }
                tufuh_w2 += (frame.size.width + 20) + CGFloat(numN)
                if tufuh_w2 + 10 > tufuh_w {
                    tufuh_w2 = frame.size.width + 20
                    numH += 1
                    tufuh_hV = 130
                    if numH == 3 {
                        tufuh_hV = 170
                        break
                    }
                }
            }
            tufuh_h -= tufuh_hV
        }
        
        tufuh_collcV.frame = CGRect(x: 10, y: 10, width: TUOKOUXIUSwiftSCRE_W - 20, height: tufuh_h - 10)
        tufuh_collcV.reloadData()
    }
    
    func tukou_currVC() -> UIViewController? {
        var next = self.view.superview
        while let current = next {
            if let responder = current.next as? UIViewController {
                return responder
            }
            next = current.superview
        }
        return nil
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tufuh_dataTreArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if tufuh_dataTreArr.isEmpty {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUTopTJCollVDefCellId", for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUTopTJCollVCellId", for: indexPath) as! TUOKOUXIUSwiftPageCollVCell
        cell.tukou_resModel(tufuh_dataTreArr[indexPath.row])
        
        if indexPath.row >= 9 {
            cell.tufuh_numV.tufuh_numLabel.backgroundColor = UIColor(red: 62/255.0, green: 69/255.0, blue: 83/255.0, alpha: 1.0)
            cell.tufuh_numV.tufuh_numLabel.textColor = TUOKOUXIUSwiftZTClr3
            cell.tufuh_numV.tufuh_numLabel.text = "\(indexPath.row + 1)"
        } else {
            switch indexPath.row {
            case 0:
                cell.tufuh_numV.tufuh_numLabel.backgroundColor = UIColor(red: 251/255.0, green: 229/255.0, blue: 252/255.0, alpha: 0.9)
                cell.tufuh_numV.tufuh_numLabel.textColor = UIColor(red: 234/255.0, green: 51/255.0, blue: 138/255.0, alpha: 1.0)
            case 1:
                cell.tufuh_numV.tufuh_numLabel.backgroundColor = UIColor(red: 251/255.0, green: 234/255.0, blue: 229/255.0, alpha: 1.0)
                cell.tufuh_numV.tufuh_numLabel.textColor = UIColor(red: 236/255.0, green: 92/255.0, blue: 65/255.0, alpha: 1.0)
            case 2:
                cell.tufuh_numV.tufuh_numLabel.backgroundColor = UIColor(red: 252/255.0, green: 240/255.0, blue: 211/255.0, alpha: 1.0)
                cell.tufuh_numV.tufuh_numLabel.textColor = UIColor(red: 240/255.0, green: 150/255.0, blue: 54/255.0, alpha: 1.0)
            default:
                cell.tufuh_numV.tufuh_numLabel.backgroundColor = UIColor(red: 62/255.0, green: 69/255.0, blue: 83/255.0, alpha: 1.0)
                cell.tufuh_numV.tufuh_numLabel.textColor = TUOKOUXIUSwiftZTClr3
            }
            cell.tufuh_numV.tufuh_numLabel.text = String(format: "0%ld", indexPath.row + 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if tufuh_dataTreArr.isEmpty { return .zero }
        return CGSize(width: 112 * TUOKOUXIUDeviceInfo.scaleX, height: 160 * TUOKOUXIUDeviceInfo.scaleX + 34)
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
}
