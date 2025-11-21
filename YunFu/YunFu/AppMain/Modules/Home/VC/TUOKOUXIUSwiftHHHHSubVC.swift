
import UIKit
import Foundation
import Combine

class TUOKOUXIUSwiftHHHHSubVC: TUOKOUXIUSwiftBaseVC, UITableViewDelegate, UITableViewDataSource {

    var tufuh_noNetV: UIView?
    var tufuh_dataTreArr: [Any] = []
    
    var tufuh_ZTArr: [Any] = []
    var tufuh_subDict: [String: Any] = [:]
    var tufuh_num: Int = 0
    
//    var tufuh_xuYSX: Bool = false
//    var tufuh_tzNum: Int = 0
    
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
        
        tableView.sectionHeaderTopPadding = 0

        tableView.backgroundColor = .red
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01)
        
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//    func tukou_shuaXinHHH() {
//        self.tufuh_xuYSX = true
//    }
    
//    func tukou_homeWillAppear() {
//        if self.tufuh_xuYSX {
//            self.tufuh_xuYSX = false
//            let tufuh_aniEna = UIView.areAnimationsEnabled
//            UIView.setAnimationsEnabled(false)
//            self.tufuh_tabV.reloadData()
//            UIView.setAnimationsEnabled(tufuh_aniEna)
//        } else {
//            if self.tufuh_dataTreArr.count > 0 {
//                let tufuh_aniEna = UIView.areAnimationsEnabled
//                UIView.setAnimationsEnabled(false)
//                if self.tufuh_tabV.numberOfSections > 1 {
//                    let indexSet = IndexSet(integer: 1)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        self.tufuh_tabV.reloadSections(indexSet, with: .none)
//                    }
//                } else {
//                    self.tufuh_tabV.reloadData()
//                }
//                UIView.setAnimationsEnabled(tufuh_aniEna)
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUHHHWillAppear"))
//            .sink { [weak self] notif in self?.tukou_homeWillAppear() }
//            .store(in: &cancellables)
        
        self.tufuh_dataTreArr = []
        
        self.tufuh_ZTArr = []
        
        self.view.backgroundColor = .orange
        
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
        
//        self.tukou_loadData()
        
        self.tufuh_tabV.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H)
        self.view.addSubview(self.tufuh_tabV)
        
        self.tufuh_tabV.delegate = self
        self.tufuh_tabV.dataSource = self
        
        self.tufuh_tabV.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUHHHTabVVDefCellId")
        self.tufuh_tabV.register(TUOKOUXIUSwiftHomeTopCell.self, forCellReuseIdentifier: "TUOKOUXIUSwiftHomeTopCellId")
        self.tufuh_tabV.register(TUOKOUXIUSwiftHomeContentCell1.self, forCellReuseIdentifier: "TUOKOUXIUSwiftHomeContentCell1Id")
        self.tufuh_tabV.register(TUOKOUXIUSwiftHomeContentCell2.self, forCellReuseIdentifier: "TUOKOUXIUSwiftHomeContentCell2Id")
        self.tufuh_tabV.register(TUOKOUXIUSwiftHomeContentCell3.self, forCellReuseIdentifier: "TUOKOUXIUSwiftHomeContentCell3Id")
        self.tufuh_tabV.register(TUOKOUXIUSwiftHomeContentCell4.self, forCellReuseIdentifier: "TUOKOUXIUSwiftHomeContentCell4Id")
        self.tufuh_tabV.register(TUOKOUXIUSwiftHomeContentCell5.self, forCellReuseIdentifier: "TUOKOUXIUSwiftHomeContentCell5Id")
        self.tufuh_tabV.register(TUOKOUXIUSwiftHomeContentCell6.self, forCellReuseIdentifier: "TUOKOUXIUSwiftHomeContentCell6Id")
        self.tufuh_tabV.register(TUOKOUXIUSwiftHomeContentCell7.self, forCellReuseIdentifier: "TUOKOUXIUSwiftHomeContentCell7Id")
        self.tufuh_tabV.register(TUOKOUXIUSwiftHomeContentCell8.self, forCellReuseIdentifier: "TUOKOUXIUSwiftHomeContentCell8Id")
        self.tufuh_tabV.reloadData()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        guard scrollView == self.tufuh_tabV else { return }
//        
//        let tufuh_yy = self.tufuh_tabV.contentOffset.y
//        
//        if tufuh_yy > 20 {
//            if self.tufuh_tzNum < 1 {
//                self.tufuh_tzNum += 1
//                NotificationCenter.default.post(name: NSNotification.Name("TUOKOUXIUTopVBianSe"), object: "yes")
//            }
//        } else {
//            if self.tufuh_tzNum > 0 {
//                self.tufuh_tzNum -= 1
//                NotificationCenter.default.post(name: NSNotification.Name("TUOKOUXIUTopVBianSe"), object: "no")
//            }
//        }
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
                let tufuh_subArr = dataDict["subGuide"] as? [[String: Any]] ?? []
                if let tufuh_randomN = tufuh_subArr.indices.randomElement() {
                    self.tufuh_subDict = tufuh_subArr[tufuh_randomN]
                }
                
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr = (dataDict["exploreConfig"] as? [[String: Any]]) ?? []
                self.tufuh_ZTArr = (dataDict["collections"] as? [[String: Any]]) ?? []
                if tufuh_resArr.isEmpty {
                    TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
                    return
                }
                if !self.tufuh_dataTreArr.isEmpty {
                    self.tufuh_dataTreArr.removeAll()
                }
                NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShuaXinTabb"), object: nil)
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

        if self.tufuh_noNetV != nil { return }

        let tufuh_h = TUOKOUXIUSwiftSCRE_H - (TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60) - TUOKOUXIUDeviceInfo.tukou_tabBarHeight
        self.tufuh_noNetV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: tufuh_h),
                                                 superView: self.view,
                                                 bgColor: TUOKOUXIUSwiftheiseC)

        let tufuh_lL = UILabel.tukou_bjLabel(CGRect(x: 0, y: tufuh_h/2 - 12, width: TUOKOUXIUSwiftSCRE_W, height: 20),
                                              text: "网络连接失败",
                                              superView: self.tufuh_noNetV!,
                                              textAlignment: .center,
                                              font: TUOKOUXIUSwiftFont.medium(16),
                                              textColor: TUOKOUXIUSwiftbaiseC)
        let tufuh_lL2 = UILabel.tukou_bjLabel(CGRect(x: 0, y: tufuh_lL.frame.maxY + 6, width: TUOKOUXIUSwiftSCRE_W, height: 20),
                                               text: "别急，好饭不怕晚，请检查当前网络状态后再试试",
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
                             title: "重试",
                             color: TUOKOUXIUSwiftbaiseC,
                             bgColor: TUOKOUXIUSwiftZTClr,
                             cornerRadius: 5)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
//        if self.tufuh_dataTreArr.isEmpty { return 0 }
//        return self.tufuh_dataTreArr.count + 2 + 1
        return 2
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return TUOKOUXIUSwiftSCRE_H
        } else {
            if indexPath.row == 0 {
                return 400
            } else if indexPath.row == 1 {
                return 200
            } else if indexPath.row == 2 {
                return 200
            } else if indexPath.row == 3 {
                return 200
            } else if indexPath.row == 4 {
                return 200
            } else if indexPath.row == 5 {
                return 200
            } else if indexPath.row == 6 {
                return 200
            } else if indexPath.row == 7 {
                return 200
            }
        }
        return 0.01
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tufuh_v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
        tufuh_v.backgroundColor = TUOKOUXIUSwiftheiseC
        return tufuh_v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }
        return 100
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var height: CGFloat = 0.0
        if section == 0 {
            height = 0.01
        }
        height = 100.0
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: height))
        footerView.backgroundColor = TUOKOUXIUSwiftheiseC
        return footerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUSwiftHomeTopCellId", for: indexPath) as! TUOKOUXIUSwiftHomeTopCell
//            cell.pdduo_contStr((pddds_dataArr[indexPath.row] as! String))
            return cell
        } else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUSwiftHomeContentCell1Id", for: indexPath) as! TUOKOUXIUSwiftHomeContentCell1
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUSwiftHomeContentCell2Id", for: indexPath) as! TUOKOUXIUSwiftHomeContentCell2
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUSwiftHomeContentCell3Id", for: indexPath) as! TUOKOUXIUSwiftHomeContentCell3
                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUSwiftHomeContentCell4Id", for: indexPath) as! TUOKOUXIUSwiftHomeContentCell4
                return cell
            } else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUSwiftHomeContentCell5Id", for: indexPath) as! TUOKOUXIUSwiftHomeContentCell5
                return cell
            } else if indexPath.row == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUSwiftHomeContentCell6Id", for: indexPath) as! TUOKOUXIUSwiftHomeContentCell6
                return cell
            } else if indexPath.row == 6 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUSwiftHomeContentCell7Id", for: indexPath) as! TUOKOUXIUSwiftHomeContentCell7
                return cell
            } else if indexPath.row == 7 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUSwiftHomeContentCell8Id", for: indexPath) as! TUOKOUXIUSwiftHomeContentCell8
                return cell
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUHHHTabVVDefCellId", for: indexPath)
        cell.backgroundColor = TUOKOUXIUSwiftheiseC
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
