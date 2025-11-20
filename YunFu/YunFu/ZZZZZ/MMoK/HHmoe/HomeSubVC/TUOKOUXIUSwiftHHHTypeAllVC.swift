
import UIKit
import Foundation

class TUOKOUXIUSwiftHHHTypeAllVC: TUOKOUXIUSwiftBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var tufuh_dict: [String: Any] = [:]
    
    private var tufuh_topV: UIView?
    private var tufuh_tNavV: UIView?
    private var tufuh_toTopBtn: UIButton?

    private var tufuh_dataArr: [[String: Any]] = []
    
    lazy var tufuh_collcV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coll.delegate = self
        coll.dataSource = self
        coll.backgroundColor = TUOKOUXIUSwiftheiseC
        coll.showsVerticalScrollIndicator = false
        coll.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TUOKOUXIUHHHTypeAllCollVDefCellId")
        coll.register(TUOKOUXIUSwiftHHHCollVCell.self, forCellWithReuseIdentifier: "TUOKOUXIUHHHTypeAllCollVCellId")
        coll.register(TUOKOUXIUSwiftHHHSubCollReuV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUHHHSubTypeCollFooterReusaVId")
        coll.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUHHHTypeAllCollVDefSuppVId")
        return coll
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = TUOKOUXIUSwiftheiseC
        self.tufuh_dataArr = []
        _ = self.tufuh_collcV
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func tukou_resTAllDat(_ dataDict: [String: Any]) {
        self.tufuh_dict = dataDict
        self.tukou_topVi()
        
        self.tufuh_collcV.frame = CGRect(
            x: 10,
            y: (self.tufuh_tNavV?.frame.maxY ?? 0) + 10,
            width: TUOKOUXIUSwiftSCRE_W - 20,
            height: TUOKOUXIUSwiftSCRE_H - (self.tufuh_tNavV?.frame.maxY ?? 0) - 10
        )
        self.view.addSubview(self.tufuh_collcV)
        
        if let arr = dataDict["data"] as? [[String: Any]] {
            self.tufuh_dataArr = arr
        }
        self.tufuh_collcV.reloadData()
    }
    
    private func tukou_topVi() {
        self.tufuh_topV = UIView.tukou_bjView(
            CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight),
            superView: self.view,
            bgColor: TUOKOUXIUSwiftheiseC
        )
        
        self.tufuh_tNavV = UIView.tukou_bjView(
            CGRect(x: 0, y: self.tufuh_topV!.frame.maxY, width: TUOKOUXIUSwiftSCRE_W, height: 56),
            superView: self.view,
            bgColor: TUOKOUXIUSwiftheiseC
        )
        
        let tufuh_iV = UIImageView.tukou_bjImageV(
            CGRect(x: 10, y: 16, width: 24, height: 24),
            superView: self.tufuh_tNavV!,
            image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_nav_top_left", andIsOne: false)
        )
        tufuh_iV.isUserInteractionEnabled = true
        tufuh_iV.tukou_addTapGesture(target: self, action: #selector(tukou_goBack))
        
        UILabel.tukou_bjLabel(
            CGRect(x: 44, y: 17, width: TUOKOUXIUSwiftSCRE_W - 88, height: 22),
            text: tufuh_dict["module"] as? String ?? "",
            superView: self.tufuh_tNavV!,
            textAlignment: .center,
            font: TUOKOUXIUSwiftFont.semibold(18),
            textColor: TUOKOUXIUSwiftZTClr3
        )
        
        let tufuh_sV = UIImageView.tukou_bjImageV(
            CGRect(x: TUOKOUXIUSwiftSCRE_W - 34, y: 16, width: 24, height: 24),
            superView: self.tufuh_tNavV!,
            image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_sub_vie_sear", andIsOne: false)
        )
        tufuh_sV.isUserInteractionEnabled = true
        tufuh_sV.tukou_addTapGesture(target: self, action: #selector(tukou_goToSearch))
    }
    
    private func tukou_shoTopBtn() {
        self.tufuh_toTopBtn = UIButton.tukou_bjBtn(
            CGRect(x: TUOKOUXIUSwiftSCRE_W - 60, y: TUOKOUXIUSwiftSCRE_H - 40 - 50, width: 40, height: 40),
            target: self,
            image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_totop", andIsOne: false),
            superView: self.view,
            action: #selector(tukou_toTop)
        )
    }
    
    @objc private func tukou_toTop() {
        self.tufuh_collcV.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    private func tukou_hidTopBt() {
        if (tufuh_toTopBtn != nil) {
            tufuh_toTopBtn!.removeFromSuperview()
            tufuh_toTopBtn = nil
        }
    }
    
    @objc private func tukou_goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func tukou_goToSearch() {
        let tufuh_tarVC = TUOKOUXIUSwiftSSSVC()
        tufuh_tarVC.tufuh_source = "3"
        tufuh_tarVC.tufuh_isHHH = false
        self.navigationController?.pushViewController(tufuh_tarVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.tufuh_collcV {
            let tufuh_yy = self.tufuh_collcV.contentOffset.y
            if tufuh_yy >= (TUOKOUXIUSwiftSCRE_H / 2) && self.tufuh_dataArr.count > 0 {
                if self.tufuh_toTopBtn == nil {
                    self.tukou_shoTopBtn()
                }
            } else {
                if self.tufuh_toTopBtn != nil {
                    self.tukou_hidTopBt()
                }
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tufuh_dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if tufuh_dataArr.isEmpty {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHHHTypeAllCollVDefCellId", for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHHHTypeAllCollVCellId", for: indexPath) as! TUOKOUXIUSwiftHHHCollVCell
        cell.tukou_resModel(tufuh_dataArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if tufuh_dataArr.isEmpty { return CGSize(width: 0, height: 0) }
        return CGSize(width: 112 * TUOKOUXIUDeviceInfo.scaleX, height: 160 * TUOKOUXIUDeviceInfo.scaleX + 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if tufuh_dataArr.isEmpty { return CGSize(width: 0, height: 0) }
        return CGSize(width: TUOKOUXIUSwiftSCRE_W, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "TUOKOUXIUHHHSubTypeCollFooterReusaVId",
                for: indexPath
            ) as! TUOKOUXIUSwiftHHHSubCollReuV
            return footView
        }
        return collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "TUOKOUXIUHHHTypeAllCollVDefSuppVId",
            for: indexPath
        )
    }
}
