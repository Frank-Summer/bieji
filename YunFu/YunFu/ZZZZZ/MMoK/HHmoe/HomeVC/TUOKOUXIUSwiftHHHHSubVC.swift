
import UIKit
import Foundation
import StoreKit
import Combine

class TUOKOUXIUSwiftHHHHSubVC: TUOKOUXIUSwiftBaseVC, UITableViewDelegate, UITableViewDataSource, TUOKOUXIUSSPullDRefVDelegate {

    var tufuh_noNetV: UIView?
    var tufuh_dataTreArr: [Any] = []
    var tufuh_bannArr: [Any] = []
    var tufuh_ZTArr: [Any] = []
    var tufuh_subDict: [String: Any] = [:]
    
    var tufuh_toTopBtn: UIButton?
    var tufuh_xuYSX: Bool = false
    var tufuh_tzNum: Int = 0
    var tufuh_collNum: Int = 0
    private var cancellables = Set<AnyCancellable>()

    lazy var tufuh_tabV: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            if tableView.contentOffset.y == 0 {
                tableView.contentInset = UIEdgeInsets(top: -34, left: 0, bottom: 0, right: 0)
            }
        }
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        tableView.backgroundColor = TUOKOUXIUSwiftheiseC
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01)
        
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var tufuh_refrV: TUOKOUXIUSSPullDRefV = {
        return TUOKOUXIUSSPullDRefV(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 50))
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func tukou_shuaXinHHH() {
        self.tufuh_xuYSX = true
    }
    
    func tukou_homeWillAppear() {
        if self.tufuh_xuYSX {
            self.tufuh_xuYSX = false
            let tufuh_aniEna = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.tufuh_tabV.reloadData()
            UIView.setAnimationsEnabled(tufuh_aniEna)
        } else {
            if self.tufuh_dataTreArr.count > 0 {
                let tufuh_aniEna = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                if self.tufuh_tabV.numberOfSections > 1 {
                    let indexSet = IndexSet(integer: 1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.tufuh_tabV.reloadSections(indexSet, with: .none)
                    }
                } else {
                    self.tufuh_tabV.reloadData()
                }
                UIView.setAnimationsEnabled(tufuh_aniEna)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUHHHWillAppear"))
            .sink { [weak self] notif in self?.tukou_homeWillAppear() }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUShuaXinHHH"))
            .sink { [weak self] notif in self?.tukou_shuaXinHHH() }
            .store(in: &cancellables)

        
        self.tufuh_dataTreArr = []
        self.tufuh_bannArr = []
        self.tufuh_ZTArr = []
        
        self.view.backgroundColor = TUOKOUXIUSwiftheiseC
        
        if TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() == 0 {
            self.tukou_noNetwV()
            return
        }
        self.tukou_testNet()
    }
    
    @objc func tukou_testNet() {
        if (TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0) {
            self.tukou_creTabV()
        } else {
            self.tukou_noNetwV()
        }
    }

    func tukou_creTabV() {
        if let noNetV = self.tufuh_noNetV {
            noNetV.removeFromSuperview()
            self.tufuh_noNetV = nil
        }
        
        self.tukou_loadData()
        
        self.tufuh_tabV.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H - TUOKOUXIUDeviceInfo.tukou_tabBarHeight)
        self.view.addSubview(self.tufuh_tabV)
        
        self.tufuh_tabV.delegate = self
        self.tufuh_tabV.dataSource = self
        
        self.tufuh_refrV.fuhan_setup(owner: self.tufuh_tabV, delegate: self)
        
        self.tufuh_tabV.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUHHHTabVVDefCellId")
        self.tufuh_tabV.register(TUOKOUXIUSwiftLBTCell.self, forCellReuseIdentifier: "TUOKOUXIULBTCellId")
        self.tufuh_tabV.register(TUOKOUXIUSwiftHHHBigCell.self, forCellReuseIdentifier: "TUOKOUXIUHHHBigCellId")
        self.tufuh_tabV.register(TUOKOUXIUSwiftHHHTabVCell.self, forCellReuseIdentifier: "TUOKOUXIUHHHTabVVCellId")
    }

    func tukou_pullDRefDidFin() {
        guard !self.tufuh_dataTreArr.isEmpty else { return }
        
        for cell in tufuh_tabV.visibleCells {
            guard let tufuh_c = cell as? TUOKOUXIUSwiftHHHTabVCell,
                  let indexPath = tufuh_tabV.indexPath(for: tufuh_c) else { continue }
            
            if indexPath.section > 0 {
                if indexPath.section == 1 {
                    if (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr) != nil) {
                        tufuh_c.tufuh_collcV?.setContentOffset(.zero, animated: false)
                    }
                } else {
                    tufuh_c.tufuh_collcV?.setContentOffset(.zero, animated: false)
                }
            }
        }
        
        self.tukou_testNet()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tukou_stoo()
        }
    }
    
    func tukou_stoo() {
        tufuh_refrV.fuhan_stoLoadi()
        
        if #available(iOS 15.0, *) {

        } else {
            if self.tufuh_tabV.contentOffset.y == 0 {
                self.tufuh_tabV.contentInset = UIEdgeInsets(top: -34, left: 0, bottom: 0, right: 0)
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tufuh_refrV.scrollViewDidScroll(scrollView)
        
        guard scrollView == self.tufuh_tabV else { return }
        
        let tufuh_yy = self.tufuh_tabV.contentOffset.y
        
        if tufuh_yy >= (TUOKOUXIUSwiftSCRE_H / 2), !self.tufuh_dataTreArr.isEmpty {
            if self.tufuh_toTopBtn == nil {
                self.tukou_shoTopBtn()
            }
        } else {
            if self.tufuh_toTopBtn != nil {
                self.tukou_hidTopBt()
            }
        }
        
        if tufuh_yy > 20 {
            if self.tufuh_tzNum < 1 {
                self.tufuh_tzNum += 1
                NotificationCenter.default.post(name: NSNotification.Name("TUOKOUXIUTopVBianSe"), object: "yes")
            }
        } else {
            if self.tufuh_tzNum > 0 {
                self.tufuh_tzNum -= 1
                NotificationCenter.default.post(name: NSNotification.Name("TUOKOUXIUTopVBianSe"), object: "no")
            }
        }
    }

    func tukou_shoTopBtn() {
        let buttonFrame = CGRect(x: TUOKOUXIUSwiftSCRE_W - 40 - 20,
                                 y: TUOKOUXIUSwiftSCRE_H - TUOKOUXIUDeviceInfo.tukou_tabBarHeight - 60,
                                 width: 40, height: 40)
        
        let buttonImage = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_totop", andIsOne: false)
        
        self.tufuh_toTopBtn = UIButton.tukou_bjBtn(buttonFrame, target: self, image: buttonImage, superView: self.view, action: #selector(tukou_toTop))
    }

    @objc func tukou_toTop() {
        self.tufuh_tabV.setContentOffset(.zero, animated: true)
    }

    func tukou_hidTopBt() {
        if (tufuh_toTopBtn != nil) {
            self.tufuh_toTopBtn!.removeFromSuperview()
            self.tufuh_toTopBtn = nil
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.tufuh_refrV.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.tufuh_refrV.scrollViewWillBeginDragging(scrollView)
    }
    
    func tukou_loadData() {
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jzGFV(TUOKOUXIUSwiftKeyWinRoV)
        
        let tufuh_arr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_routesArr
        guard tufuh_arr.count >= 2 else {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }
        
        guard let tufuhDict = tufuh_arr[1] as? [String: Any],
              let tufuh_url = tufuhDict["cd"] as? String else {
            return
        }
        
        let tufuh_ba64Str = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_shuJJM([
            "cd": tufuh_url,
            "ps": [["kv": "0"]]
        ])
        
        if TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_ba64Str) {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }

        
        TUOKOUXIUSwiftWWWL.tukou_shared.tukou_requWithURL(TUOKOUXIUSwiftConst.TUOKOUXIUjkzx, pars: [tufuh_ba64Str]) { dataDict, isSuccess in
            
            if isSuccess {
                if let strData = dataDict as? String {
                    self.tukou_checkCode(strData) { isSuccess2 in
                        if isSuccess2 {
                            self.tukou_loadData()
                        }
                    }
                    return
                }
                
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
                
                guard let dataDict = dataDict as? [String: Any] else { return }
                
                let tufuh_resArr = dataDict["mainList"] as? [[String: Any]] ?? []
                self.tufuh_bannArr = (dataDict["mainBanner"] as? [[String: Any]]) ?? []
                let tufuh_subArr = dataDict["subGuide"] as? [[String: Any]] ?? []
                
                if let tufuh_randomN = tufuh_subArr.indices.randomElement() {
                    self.tufuh_subDict = tufuh_subArr[tufuh_randomN]
                }
    
                
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr = (dataDict["exploreConfig"] as? [[String: Any]]) ?? []
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_phArr = (dataDict["hotsearch"] as? [[String: Any]]) ?? []
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_hotArr = (dataDict["hotsearchkeys"] as? [String]) ?? []
                self.tufuh_ZTArr = (dataDict["collections"] as? [[String: Any]]) ?? []
                self.tufuh_collNum = Int("\(dataDict["collection_sort"] ?? 2)") ?? 2
                if self.tufuh_collNum < 2 { self.tufuh_collNum = 2 }
            
                
                if tufuh_resArr.isEmpty {

                    TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
                    return
                }
                
                if !self.tufuh_dataTreArr.isEmpty {
                    self.tufuh_dataTreArr.removeAll()
                }
                
                NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUHHHTopSearchIV"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShuaXinTabb"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUQiDongLabel"), object: nil)
                
                self.tufuh_dataTreArr = tufuh_resArr
                self.tufuh_tabV.reloadData()
                
            } else {
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            }
        }
    }
    
    func tukou_noNetwV() {
        tufuh_tabV.removeFromSuperview()
        tufuh_tabV.delegate = nil
        tufuh_tabV.dataSource = nil
        tufuh_refrV.removeFromSuperview()
        tufuh_refrV.delegate = nil

        if self.tufuh_noNetV != nil { return }

        let tufuh_h = TUOKOUXIUSwiftSCRE_H - (TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60) - TUOKOUXIUDeviceInfo.tukou_tabBarHeight
        self.tufuh_noNetV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: tufuh_h),
                                                 superView: self.view,
                                                 bgColor: TUOKOUXIUSwiftheiseC)

        let tufuh_lL = UILabel.tukou_bjLabel(CGRect(x: 0, y: tufuh_h/2 - 12, width: TUOKOUXIUSwiftSCRE_W, height: 20),
                                              text: "The current network status is abnormal,",
                                              superView: self.tufuh_noNetV!,
                                              textAlignment: .center,
                                              font: TUOKOUXIUSwiftFont.medium(16),
                                              textColor: TUOKOUXIUSwiftbaiseC)
        let tufuh_lL2 = UILabel.tukou_bjLabel(CGRect(x: 0, y: tufuh_lL.frame.maxY + 6, width: TUOKOUXIUSwiftSCRE_W, height: 20),
                                               text: "please try again later.",
                                               superView: self.tufuh_noNetV!,
                                               textAlignment: .center,
                                               font: TUOKOUXIUSwiftFont.medium(16),
                                               textColor: TUOKOUXIUSwiftbaiseC)
        
        UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W/2 - 90/2, y: tufuh_lL2.frame.maxY + 24, width: 90, height: 36),
                             target: self,
                             imageName: "",
                             superView: self.tufuh_noNetV!,
                             action: #selector(tukou_testNet),
                             font: TUOKOUXIUSwiftFont.semibold(14),
                             title: "Retry",
                             color: TUOKOUXIUSwiftbaiseC,
                             bgColor: TUOKOUXIUSwiftZTClr,
                             cornerRadius: 5)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if self.tufuh_dataTreArr.isEmpty { return 0 }
        return self.tufuh_dataTreArr.count + 2 + 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return (TUOKOUXIUSwiftSCRE_W / 16) * 9 + TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60
        } else if indexPath.section == 1 {
            if (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr) != nil) {
                return 160 * TUOKOUXIUDeviceInfo.scaleX + 40
            } else {
                return 0.01
            }
        } else {
            if self.tufuh_dataTreArr.isEmpty { return 0 }

            if indexPath.section == self.tufuh_collNum {
                return 3 * (50.0 / 9.0) * 16.0 * TUOKOUXIUDeviceInfo.scaleX + 79 + 6
            }
            return 160 * TUOKOUXIUDeviceInfo.scaleX + 40
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        } else if section == 1 {
            if (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr) != nil) {
                return 32
            } else {
                return 0.01
            }
        } else {
            if self.tufuh_dataTreArr.isEmpty { return 0 }
            return 32
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let tufuh_v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
            tufuh_v.backgroundColor = TUOKOUXIUSwiftheiseC
            return tufuh_v
        }

        if section == 1 {
            if (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr) != nil) {
                let tufuh_headV = TUOKOUXIUSwiftTabHeadV(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 32))
                tufuh_headV.backgroundColor = TUOKOUXIUSwiftheiseC
                let tufuh_titS = "History"
                tufuh_headV.tufuh_secN = 0

                tufuh_headV.didSelectBlock = { [weak self] sectionNum in
                    guard let self = self else { return }

                    let tufuh_tarVC = TUOKOUXIUSwiftHHHHisVC()
                    tufuh_tarVC.tufuh_isList = false
                    self.tukou_currVC()?.navigationController?.pushViewController(tufuh_tarVC, animated: true)
                }

                if !tufuh_titS.isEmpty {
                    let tufuh_iv = UIImageView(frame: CGRect(x: 10, y: 0, width: 24, height: 24))
                    tufuh_headV.addSubview(tufuh_iv)

                    tufuh_iv.kf.setImage(with: URL(string: TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_ic_hh_titPl!), options: [.transition(.fade(0.3))])
                    UILabel.tukou_bjLabel(CGRect(x: 40, y: 0, width: TUOKOUXIUSwiftSCRE_W - 10 - 30 - 60 - 10, height: 24),
                                          text: tufuh_titS,
                                          superView: tufuh_headV,
                                          textAlignment: .left,
                                          font: TUOKOUXIUSwiftFont.medium(16),
                                          textColor: TUOKOUXIUSwiftbaiseC)

                    UILabel.tukou_bjLabel(CGRect(x: TUOKOUXIUSwiftSCRE_W - 12 - 60, y: 0, width: 60, height: 24),
                                          text: "See All",
                                          superView: tufuh_headV,
                                          textAlignment: .right,
                                          font: TUOKOUXIUSwiftFont.medium(14),
                                          textColor: TUOKOUXIUSwiftZTClr3A)
                }
                return tufuh_headV
            } else {
                let tufuh_v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
                tufuh_v.backgroundColor = TUOKOUXIUSwiftheiseC
                return tufuh_v
            }
        } else {
            if self.tufuh_dataTreArr.isEmpty { return UIView() }

            if section == self.tufuh_collNum {
                let tufuh_headV = TUOKOUXIUSwiftTabHeadV(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 32))
                tufuh_headV.backgroundColor = TUOKOUXIUSwiftheiseC
                let tufuh_titS = "Part of the \(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[38]) Collection"

                tufuh_headV.didSelectBlock = { [weak self] sectionNum in
                    guard let self = self else { return }

                    if let dataTreArr = self.tufuh_ZTArr as? [[String: Any]] {
                        let tufuh_tarVC = TUOKOUXIUSwiftHHHCateDepVC()
                        tufuh_tarVC.tufuh_dataTreArr = dataTreArr
                        self.tukou_currVC()?.navigationController?.pushViewController(tufuh_tarVC, animated: true)
                    }
                }

                if !tufuh_titS.isEmpty {
                    let tufuh_iv = UIImageView(frame: CGRect(x: 10, y: 0, width: 24, height: 24))
                    tufuh_headV.addSubview(tufuh_iv)
                    
                    tufuh_iv.kf.setImage(with: URL(string: TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_ic_hh_titPl!), options: [.transition(.fade(0.3))])
                    UILabel.tukou_bjLabel(CGRect(x: 40, y: 0, width: TUOKOUXIUSwiftSCRE_W - 10 - 30 - 60 - 10, height: 24),
                                          text: tufuh_titS,
                                          superView: tufuh_headV,
                                          textAlignment: .left,
                                          font: TUOKOUXIUSwiftFont.medium(16),
                                          textColor: TUOKOUXIUSwiftbaiseC)

                    UILabel.tukou_bjLabel(CGRect(x: TUOKOUXIUSwiftSCRE_W - 12 - 60, y: 0, width: 60, height: 24),
                                          text: "See All",
                                          superView: tufuh_headV,
                                          textAlignment: .right,
                                          font: TUOKOUXIUSwiftFont.medium(14),
                                          textColor: TUOKOUXIUSwiftZTClr3A)
                }
                return tufuh_headV
            }

            let tufuh_headV = TUOKOUXIUSwiftTabHeadV(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 32))
            tufuh_headV.backgroundColor = TUOKOUXIUSwiftheiseC

            var tufuh_titN = section - 2
            if section > self.tufuh_collNum { tufuh_titN -= 1 }

            var tufuh_titS = ""
            if let dict = self.tufuh_dataTreArr[tufuh_titN] as? [String: Any] {
                tufuh_titS = dict["module"] as? String ?? ""
            }
            
            tufuh_headV.tufuh_secN = tufuh_titN

            tufuh_headV.didSelectBlock = { [weak self] sectionNum in
                guard let self = self else { return }
                guard
                    let dict = self.tufuh_dataTreArr[tufuh_titN] as? [String: Any],
                    let tufuh_allTypeArr = dict["data"] as? [Any],
                    !tufuh_allTypeArr.isEmpty
                else {
                    TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
                    return
                }

                let tufuh_tarVC = TUOKOUXIUSwiftHHHTypeAllVC()
                tufuh_tarVC.tukou_resTAllDat(self.tufuh_dataTreArr[tufuh_titN] as! [String : Any])
                self.tukou_currVC()?.navigationController?.pushViewController(tufuh_tarVC, animated: true)
            }

            if !tufuh_titS.isEmpty {
                let tufuh_iv = UIImageView(frame: CGRect(x: 10, y: 0, width: 24, height: 24))
                tufuh_headV.addSubview(tufuh_iv)
                
                tufuh_iv.kf.setImage(with: URL(string: TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_ic_hh_titPl!), options: [.transition(.fade(0.3))])
                UILabel.tukou_bjLabel(CGRect(x: 40, y: 0, width: TUOKOUXIUSwiftSCRE_W - 10 - 30 - 60 - 10, height: 24),
                                      text: tufuh_titS,
                                      superView: tufuh_headV,
                                      textAlignment: .left,
                                      font: TUOKOUXIUSwiftFont.medium(16),
                                      textColor: TUOKOUXIUSwiftbaiseC)

                UILabel.tukou_bjLabel(CGRect(x: TUOKOUXIUSwiftSCRE_W - 12 - 60, y: 0, width: 60, height: 24),
                                      text: "See All",
                                      superView: tufuh_headV,
                                      textAlignment: .right,
                                      font: TUOKOUXIUSwiftFont.medium(14),
                                      textColor: TUOKOUXIUSwiftZTClr3A)
            }

            return tufuh_headV
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            if (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr) != nil) {
                return 13
            } else {
                return 0.01
            }
        }
        return 13
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let height: CGFloat
        if section == 1 {
            if (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr) != nil) {
                height = 13
            } else {
                height = 0.01
            }
        } else {
            height = 13
        }
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: height))
        footerView.backgroundColor = TUOKOUXIUSwiftheiseC
        return footerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if tufuh_bannArr.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUHHHTabVVDefCellId", for: indexPath)
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                return cell
            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIULBTCellId", for: indexPath) as? TUOKOUXIUSwiftLBTCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            cell.tukou_resData(tufuh_bannArr)
            
            cell.tufuh_clkItemBlk = { model in
                
            }
            
            return cell
        }
        
        if indexPath.section == 1 {
            if let hisArray = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr), !hisArray.isEmpty {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUHHHTabVVCellId", for: indexPath) as? TUOKOUXIUSwiftHHHTabVCell else {
                    return UITableViewCell()
                }
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                cell.tufuh_isZhanShiAd = false
                cell.tufuh_isHis = true
                cell.tukou_resData(hisArray)
                
                cell.tufuh_clkItemArrBlk = { modelArr in
                    
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUHHHTabVVDefCellId", for: indexPath)
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                return cell
            }
        }
        
        if tufuh_dataTreArr.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUHHHTabVVDefCellId", for: indexPath)
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            return cell
        }
        
        if indexPath.section == tufuh_collNum {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUHHHBigCellId", for: indexPath) as? TUOKOUXIUSwiftHHHBigCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            cell.tukou_resData(tufuh_ZTArr as! [[String: Any]])
            
            cell.tufuh_clkItemBlk = { model in
                
            }
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUHHHTabVVCellId", for: indexPath) as? TUOKOUXIUSwiftHHHTabVCell else {
            return UITableViewCell()
        }
        
        cell.tufuh_isTop = (indexPath.section == 2)


        cell.tufuh_isZhanShiAd = false
        
        
        var tufuh_dataNum = indexPath.section - 2
        if indexPath.section > tufuh_collNum {
            tufuh_dataNum -= 1
        }
        
        cell.backgroundColor = TUOKOUXIUSwiftheiseC
        cell.tufuh_isHis = false

        if let tufuh_d = tufuh_dataTreArr[tufuh_dataNum] as? [String: Any],
           let tufuh_arr = tufuh_d["data"] as? [[String: Any]] {
            cell.tukou_resData(tufuh_arr)
        }
        
        cell.tufuh_clkItemBlk = { model in

        }
        
        return cell
    }

    func tukou_currVC() -> UIViewController? {
        var next: UIView? = self.view.superview
        while let current = next {
            if let responder = current.next as? UIViewController {
                return responder
            }
            next = current.superview
        }
        return nil
    }

}
