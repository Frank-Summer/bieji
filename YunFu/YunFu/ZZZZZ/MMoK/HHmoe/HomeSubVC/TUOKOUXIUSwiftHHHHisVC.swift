
import Foundation
import UIKit
import Toast

class TUOKOUXIUSwiftHHHHisVC: TUOKOUXIUSwiftBaseVC, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var TUOKOUXIUisBlockRefresh: (() -> Void)?
    var tufuh_isList: Bool = false
    
    private var tufuh_topV: UIView!
    private var tufuh_tNavV: UIView!
    
    private var tufuh_dataArr: [[Any]] = []
    private var tufuh_deleArr: [[Any]] = []
    private var tufuh_topEdit: UILabel!
    private var tufuh_isEdit: Bool = false
    private var tufuh_isSelectAll: Bool = false
    private var tufuh_toTopBtn: UIButton?
    private var tufuh_botV: UIView?
    private var tufuh_isFirst: Bool = false
    private var tufuh_infoRow: Int = 0
    private var tufuh_selBtn: UIButton?
    
    private lazy var tufuh_collcV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collcV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collcV.delegate = self
        collcV.dataSource = self
        collcV.backgroundColor = TUOKOUXIUSwiftheiseC
        collcV.showsVerticalScrollIndicator = false
        
        collcV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TUOKOUXIUHHHHisDefCellId")
        collcV.register(TUOKOUXIUSwiftHisCell.self, forCellWithReuseIdentifier: "TUOKOUXIUHHHHisCellId")
        collcV.register(TUOKOUXIUSwiftMyListCell.self, forCellWithReuseIdentifier: "TUOKOUXIUListCellId")
        collcV.register(TUOKOUXIUSwiftHHHSubCollReuV.self,
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                        withReuseIdentifier: "TUOKOUXIUHHHSubTypeCollReusaVId")
        collcV.register(UICollectionReusableView.self,
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                        withReuseIdentifier: "TUOKOUXIUHHHHisSubTypeDefSuppVId")
        
        return collcV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TUOKOUXIUSwiftheiseC
        tufuh_deleArr = []
        tukou_resData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        if !tufuh_isFirst {
            tufuh_isFirst = true
            return
        }
        
        if tufuh_isList {
            tufuh_dataArr = (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftMYLISTArr) as? [[Any]]) ?? []
        } else {
            tufuh_dataArr = (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr) as? [[Any]]) ?? []
        }
        
        if !tufuh_dataArr.isEmpty {
            let aniEna = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            tufuh_collcV.reloadData()
            UIView.setAnimationsEnabled(aniEna)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func tukou_resData() {
        if tufuh_isList {
            tufuh_dataArr = (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftMYLISTArr) as? [[Any]]) ?? []
        } else {
            tufuh_dataArr = (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr) as? [[Any]]) ?? []
        }
        tukou_topVi()
        tufuh_collcV.frame = CGRect(x: 10, y: tufuh_tNavV.frame.maxY + 10,
                                    width: TUOKOUXIUSwiftSCRE_W - 20,
                                    height: TUOKOUXIUSwiftSCRE_H - tufuh_tNavV.frame.maxY - 10)
        view.addSubview(tufuh_collcV)
        tufuh_collcV.reloadData()
    }
    
    private func tukou_topVi() {
        tufuh_topV = UIView.tukou_bjView(CGRect(x: 0, y: 0,
                                               width: TUOKOUXIUSwiftSCRE_W,
                                                height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight),
                                         superView: view,
                                         bgColor: TUOKOUXIUSwiftheiseC)
        tufuh_tNavV = UIView.tukou_bjView(CGRect(x: 0, y: tufuh_topV.frame.maxY,
                                                width: TUOKOUXIUSwiftSCRE_W,
                                                height: 56),
                                          superView: view,
                                          bgColor: TUOKOUXIUSwiftheiseC)
        
        let tufuh_iV = UIImageView.tukou_bjImageV(CGRect(x: 10, y: 16, width: 24, height: 24),
                                                  superView: tufuh_tNavV,
                                                  image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_nav_top_left", andIsOne: false))
        tufuh_iV.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tukou_goBack))
        tufuh_iV.addGestureRecognizer(tap)
        
        if tufuh_isList {
            UILabel.tukou_bjLabel(CGRect(x: TUOKOUXIUSwiftSCRE_W/2 - 100, y: 17, width: 200, height: 22),
                                  text: "My List",
                                  superView: tufuh_tNavV,
                                  textAlignment: .center,
                                  font: TUOKOUXIUSwiftFont.semibold(18),
                                  textColor: TUOKOUXIUSwiftZTClr3)
        } else {
            UILabel.tukou_bjLabel(CGRect(x: TUOKOUXIUSwiftSCRE_W/2 - 100, y: 17, width: 200, height: 22),
                                  text: "Recently Played",
                                  superView: tufuh_tNavV,
                                  textAlignment: .center,
                                  font: TUOKOUXIUSwiftFont.semibold(18),
                                  textColor: TUOKOUXIUSwiftZTClr3)
        }
        
        tufuh_topEdit = UILabel.tukou_bjLabel(CGRect(x: TUOKOUXIUSwiftSCRE_W - 70, y: 19, width: 50, height: 20),
                                              text: "Edit",
                                              superView: tufuh_tNavV,
                                              textAlignment: .center,
                                              font: TUOKOUXIUSwiftFont.semibold(14),
                                              textColor: TUOKOUXIUSwiftbaiseC)
        tufuh_topEdit.isUserInteractionEnabled = true
        let editTap = UITapGestureRecognizer(target: self, action: #selector(tukou_goToEdit))
        tufuh_topEdit.addGestureRecognizer(editTap)
    }
    
    @objc private func tukou_goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tukou_goToEdit() {
        if !tufuh_deleArr.isEmpty {
            tufuh_deleArr.removeAll()
        }
        tufuh_isSelectAll = false
        if !tufuh_isEdit {
            tufuh_isEdit = true
            tufuh_topEdit.text = "Cancel"
            tufuh_botV = UIView.tukou_bjView(CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H,
                                                    width: TUOKOUXIUSwiftSCRE_W, height: 50),
                                             superView: view,
                                             bgColor: TUOKOUXIUSwiftheiseC)
            
            tufuh_selBtn = UIButton.tukou_bjBtn(CGRect(x: 0, y: 0,
                                                       width: TUOKOUXIUSwiftSCRE_W/2, height: 50),
                                                target: self,
                                                title: "Select All",
                                                title2: "Deselect All",
                                                superView: tufuh_botV!,
                                                action: #selector(tukou_SelectAll(_:)))
            tufuh_selBtn?.setTitleColor(TUOKOUXIUSwiftZTClr3, for: .normal)
            tufuh_selBtn?.setTitleColor(TUOKOUXIUSwiftZTClr3, for: .selected)
            
            let deleteBtn = UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W/2, y: 0,
                                                       width: TUOKOUXIUSwiftSCRE_W/2, height: 50),
                                                 target: self,
                                                 title: "Delete",
                                                 superView: tufuh_botV!,
                                                 action: #selector(tukou_Delete))
            deleteBtn.setTitleColor(UIColor(red: 234/255.0, green: 77/255.0, blue: 61/255.0, alpha: 1.0), for: .normal)
            
            UIView.animate(withDuration: 0.2) {
                self.tufuh_botV?.frame = CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H-50,
                                                width: TUOKOUXIUSwiftSCRE_W, height: 50)
            }
        } else {
            tufuh_isEdit = false
            tufuh_topEdit.text = "Edit"
            UIView.animate(withDuration: 0.2) {
                self.tufuh_botV?.frame = CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H,
                                                width: TUOKOUXIUSwiftSCRE_W, height: 50)
            } completion: { _ in
                self.tufuh_botV?.removeFromSuperview()
                self.tufuh_botV = nil
            }
        }
        tufuh_collcV.reloadData()
    }
    
    @objc private func tukou_SelectAll(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            tufuh_isSelectAll = true
            tufuh_deleArr = tufuh_dataArr
        } else {
            tufuh_isSelectAll = false
            tufuh_deleArr.removeAll()
        }
        tufuh_collcV.reloadData()
    }
    
    @objc private func tukou_Delete() {
        if tufuh_deleArr.isEmpty {
            TUOKOUXIUSwiftKeyWindow()!.makeToast("Not selected!", duration: 2.0, position: .center)
        } else {
            if tufuh_deleArr.count == tufuh_dataArr.count {
                tufuh_deleArr.removeAll()
                tufuh_dataArr.removeAll()
                if tufuh_isList {
                    TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_delArrK(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftMYLISTArr)
                    TUOKOUXIUSwiftKeyWindow()!.makeToast("My list has been cleaned up!", duration: 2.0, position: .center)
                } else {
                    TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_delArrK(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr)
                    TUOKOUXIUSwiftKeyWindow()!.makeToast("The playback has been cleaned up recently!", duration: 2.0, position: .center)
                }
                tufuh_collcV.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.tukou_goBack()
                }
            } else {
                for (i, tufuh_arr) in tufuh_deleArr.enumerated() {
                    if tufuh_dataArr.firstIndex(where: { NSArray(array: $0).isEqual(to: tufuh_arr) }) != nil {
                        if let idx = tufuh_dataArr.firstIndex(where: { NSArray(array: $0).isEqual(to: tufuh_arr) }) {
                            tufuh_dataArr.remove(at: idx)
                        }
                    }
                    if i == tufuh_deleArr.count - 1 {
                        if tufuh_isList {
                            TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_setArrV(tufuh_dataArr, forKey: TUOKOUXIUSwiftConst.TUOKOUXIUSwiftMYLISTArr)
                        } else {
                            TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_setArrV(tufuh_dataArr, forKey: TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr)
                        }
                    }
                }
                TUOKOUXIUSwiftKeyWindow()!.makeToast("Delete successfully!", duration: 2.0, position: .center)
                tukou_goToEdit()
            }
        }
    }
    
    @objc func tukou_closeV() {
        if let botV = tufuh_botV {
            botV.removeFromSuperview()
            tufuh_botV = nil
        }
        tufuh_infoRow = 0
    }
    
    @objc func tukou_goToRemove() {
        if let botV = tufuh_botV {
            botV.removeFromSuperview()
            tufuh_botV = nil
        }
        
        tufuh_deleArr.append(tufuh_dataArr[tufuh_infoRow])
        
        if tufuh_deleArr.count == tufuh_dataArr.count {
            tufuh_deleArr.removeAll()
            tufuh_dataArr.removeAll()
            
            if tufuh_isList {
                TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_delArrK(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftMYLISTArr)
                TUOKOUXIUSwiftKeyWindow()!.makeToast("My list has been cleaned up!", duration: 2.0, position: .center)
            } else {
                TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_delArrK(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr)
                TUOKOUXIUSwiftKeyWindow()!.makeToast("The playback has been cleaned up recently!", duration: 2.0, position: .center)
            }
            
            tufuh_collcV.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.tukou_goBack()
            }
        } else {
            let tufuh_arr = tufuh_deleArr[0]
            if let idx = tufuh_dataArr.firstIndex(where: { $0 as AnyObject === tufuh_arr as AnyObject }) {
                tufuh_dataArr.remove(at: idx)
            }
            
            if tufuh_isList {
                TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_setArrV(tufuh_dataArr, forKey: TUOKOUXIUSwiftConst.TUOKOUXIUSwiftMYLISTArr)
            } else {
                TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_setArrV(tufuh_dataArr, forKey: TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr)
            }
            
            TUOKOUXIUSwiftKeyWindow()!.makeToast("Delete successfully!", duration: 2.0, position: .center)
            
            tufuh_deleArr.removeAll()
            tufuh_collcV.reloadData()
        }
    }
    
    @objc func tukou_goToMore() {
        if let botV = tufuh_botV {
            botV.removeFromSuperview()
            tufuh_botV = nil
        }
        guard tufuh_infoRow < tufuh_dataArr.count else { return }

        tufuh_infoRow = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if tufuh_dataArr.isEmpty {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHHHHisDefCellId", for: indexPath)
        }

        if tufuh_isList {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUListCellId", for: indexPath) as? TUOKOUXIUSwiftMyListCell else {
                return UICollectionViewCell()
            }
            cell.tukou_resModel(tufuh_dataArr[indexPath.row])
            cell.tukou_resEdit(tufuh_isEdit)
            cell.tukou_resSelectAll(tufuh_isSelectAll)

            cell.clickMoreBlock = { [weak self] in
                guard let self = self else { return }
                self.tufuh_infoRow = indexPath.row

                self.tufuh_botV?.removeFromSuperview()
                self.tufuh_botV = nil
                self.tufuh_botV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H),
                                                     superView: self.view,
                                                     bgColor: TUOKOUXIUSwiftZTClr7A)

                let botV = UIView.tukou_bjView(CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H - 150, width: TUOKOUXIUSwiftSCRE_W, height: 150),
                                               superView: self.tufuh_botV!,
                                               bgColor: TUOKOUXIUSwiftheiseC)

                let tufuh_mArr = self.tufuh_dataArr[indexPath.row]
                let tufuh_tit: String
                if tufuh_mArr.count > 9, let title = tufuh_mArr[9] as? String {
                    tufuh_tit = title
                } else if tufuh_mArr.count > 3, let title = tufuh_mArr[3] as? String {
                    tufuh_tit = title
                } else {
                    tufuh_tit = ""
                }

                UILabel.tukou_bjLabel(CGRect(x: 10, y: 0, width: TUOKOUXIUSwiftSCRE_W - 54, height: 50),
                                      text: tufuh_tit,
                                      superView: botV,
                                      textAlignment: .left,
                                      font: TUOKOUXIUSwiftFont.semibold(24),
                                      textColor: TUOKOUXIUSwiftZTClr3)

                UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W - 34, y: 15, width: 24, height: 24),
                                      target: self,
                                      image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_his_gb", andIsOne: false),
                                      superView: botV,
                                      action: #selector(self.tukou_closeV))

                UIImageView.tukou_bjImageV(CGRect(x: 10, y: 63, width: 24, height: 24),
                                           superView: botV,
                                           image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_his_info", andIsOne: false))

                let tufuh_titL = UILabel.tukou_bjLabel(CGRect(x: 44, y: 50, width: TUOKOUXIUSwiftSCRE_W - 44, height: 50),
                                                       text: "More Info",
                                                       superView: botV,
                                                       textAlignment: .left,
                                                       font: TUOKOUXIUSwiftFont.semibold(15),
                                                       textColor: TUOKOUXIUSwiftbaiseC)
                tufuh_titL.isUserInteractionEnabled = true
                tufuh_titL.tukou_addTapGesture(target: self, action: #selector(tukou_goToMore))
                UIImageView.tukou_bjImageV(CGRect(x: 10, y: 113, width: 24, height: 24),
                                           superView: botV,
                                           image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_his_delect", andIsOne: false))

                let tufuh_titL2 = UILabel.tukou_bjLabel(CGRect(x: 44, y: 100, width: TUOKOUXIUSwiftSCRE_W - 44, height: 50),
                                                        text: "Remove From List",
                                                        superView: botV,
                                                        textAlignment: .left,
                                                        font: TUOKOUXIUSwiftFont.semibold(15),
                                                        textColor: TUOKOUXIUSwiftbaiseC)
                tufuh_titL2.isUserInteractionEnabled = true
                tufuh_titL2.tukou_addTapGesture(target: self, action: #selector(tukou_goToRemove))
            }

            cell.clickSelectBlock = { [weak self] isSelect in
                guard let self = self else { return }
                if isSelect {
                    self.tufuh_deleArr.append(self.tufuh_dataArr[indexPath.row])
                    if self.tufuh_deleArr.count == self.tufuh_dataArr.count {
                        self.tufuh_selBtn!.isSelected = true
                        self.tufuh_isSelectAll = true
                    }
                } else {
                    self.tufuh_selBtn!.isSelected = false
                    self.tufuh_deleArr.removeAll { $0 as AnyObject === self.tufuh_dataArr[indexPath.row] as AnyObject }
                    self.tufuh_isSelectAll = false
                }
            }

            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHHHHisCellId", for: indexPath) as? TUOKOUXIUSwiftHisCell else {
                return UICollectionViewCell()
            }

            cell.tukou_resModel(tufuh_dataArr[indexPath.row])
            cell.tukou_resEdit(tufuh_isEdit)
            cell.tukou_resSelectAll(tufuh_isSelectAll)

            cell.TUOKOUXIUclickMoreBlock = { [weak self] in
                guard let self = self else { return }
                self.tufuh_infoRow = indexPath.row

                self.tufuh_botV?.removeFromSuperview()
                self.tufuh_botV = nil
                self.tufuh_botV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H),
                                                     superView: self.view,
                                                     bgColor: TUOKOUXIUSwiftZTClr7A)

                let botV = UIView.tukou_bjView(CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H - 150, width: TUOKOUXIUSwiftSCRE_W, height: 150),
                                               superView: self.tufuh_botV!,
                                               bgColor: TUOKOUXIUSwiftheiseC)

                let tufuh_mArr = self.tufuh_dataArr[indexPath.row]
                let tufuh_tit: String
                if tufuh_mArr.count > 9, let title = tufuh_mArr[9] as? String {
                    tufuh_tit = title
                } else if tufuh_mArr.count > 3, let title = tufuh_mArr[3] as? String {
                    tufuh_tit = title
                } else {
                    tufuh_tit = ""
                }

                UILabel.tukou_bjLabel(CGRect(x: 10, y: 0, width: TUOKOUXIUSwiftSCRE_W - 54, height: 50),
                                      text: tufuh_tit,
                                      superView: botV,
                                      textAlignment: .left,
                                      font: TUOKOUXIUSwiftFont.semibold(24),
                                      textColor: TUOKOUXIUSwiftZTClr3)

                UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W - 34, y: 15, width: 24, height: 24),
                                      target: self,
                                      image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_his_gb", andIsOne: false),
                                      superView: botV,
                                      action: #selector(self.tukou_closeV))

                UIImageView.tukou_bjImageV(CGRect(x: 10, y: 63, width: 24, height: 24),
                                           superView: botV,
                                           image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_his_info", andIsOne: false))

                let tufuh_titL = UILabel.tukou_bjLabel(CGRect(x: 44, y: 50, width: TUOKOUXIUSwiftSCRE_W - 44, height: 50),
                                                       text: "More Info",
                                                       superView: botV,
                                                       textAlignment: .left,
                                                       font: TUOKOUXIUSwiftFont.semibold(15),
                                                       textColor: TUOKOUXIUSwiftbaiseC)
                tufuh_titL.isUserInteractionEnabled = true
                tufuh_titL.tukou_addTapGesture(target: self, action: #selector(tukou_goToMore))

                UIImageView.tukou_bjImageV(CGRect(x: 10, y: 113, width: 24, height: 24),
                                           superView: botV,
                                           image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_his_delect", andIsOne: false))

                let tufuh_titL2 = UILabel.tukou_bjLabel(CGRect(x: 44, y: 100, width: TUOKOUXIUSwiftSCRE_W - 44, height: 50),
                                                        text: "Remove From List",
                                                        superView: botV,
                                                        textAlignment: .left,
                                                        font: TUOKOUXIUSwiftFont.semibold(15),
                                                        textColor: TUOKOUXIUSwiftbaiseC)
                tufuh_titL2.isUserInteractionEnabled = true
                tufuh_titL2.tukou_addTapGesture(target: self, action: #selector(tukou_goToRemove))
            }

            cell.TUOKOUXIUclickSelectBlock = { [weak self] isSelect in
                guard let self = self else { return }
                if isSelect {
                    self.tufuh_deleArr.append(self.tufuh_dataArr[indexPath.row])
                    if self.tufuh_deleArr.count == self.tufuh_dataArr.count {
                        self.tufuh_selBtn!.isSelected = true
                        self.tufuh_isSelectAll = true
                    }
                } else {
                    self.tufuh_selBtn!.isSelected = false
                    self.tufuh_deleArr.removeAll { $0 as AnyObject === self.tufuh_dataArr[indexPath.row] as AnyObject }
                    self.tufuh_isSelectAll = false
                }
            }

            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if tufuh_isEdit {
            if let cell = collectionView.cellForItem(at: indexPath) as? TUOKOUXIUSwiftHisCell {
                cell.tukou_goToSelect(cell.tufuh_botSelectBtn)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard !tufuh_dataArr.isEmpty else { return CGSize(width: 0, height: 0) }
        return CGSize(width: 112 * TUOKOUXIUDeviceInfo.scaleX,
                      height: 160 * TUOKOUXIUDeviceInfo.scaleX + 34)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        guard !tufuh_dataArr.isEmpty else { return CGSize(width: 0, height: 0) }
        return CGSize(width: TUOKOUXIUSwiftSCRE_W, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: "TUOKOUXIUHHHSubTypeCollReusaVId",
                for: indexPath
            ) as! TUOKOUXIUSwiftHHHSubCollReuV
            return footView
        } else {
            let defaultView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "TUOKOUXIUHHHHisSubTypeDefSuppVId",
                for: indexPath
            )
            return defaultView
        }
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tufuh_dataArr.count
    }

}
