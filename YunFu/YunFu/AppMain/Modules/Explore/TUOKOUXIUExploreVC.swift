
import UIKit
import Foundation
import Toast
import Combine

class TUOKOUXIUExploreVC: TUOKOUXIUSwiftBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    var tufuh_topV: UIView?
    var tufuh_noNetV: UIView?
    var tufuh_dataTreArr: [[String: Any]] = []
    var tufuh_dataTDict: [String: Any] = [:]
    var tufuh_headOpen: Bool = false

    private var cancellables = Set<AnyCancellable>()
    
    lazy var tufuh_tabV: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.contentInsetAdjustmentBehavior = .never

        tableView.sectionHeaderTopPadding = 0

        tableView.backgroundColor = .black
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tufuh_dataTreArr = []
        tufuh_dataTDict = [:]
        
        view.backgroundColor = TUOKOUXIUSwiftheiseC
        tukou_topVi()
        if TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() == 0 {
            tukou_noNetwV()
            return
        }

        tukou_creTabV()
    }
    
    func tukou_topVi() {
        tufuh_topV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 76), superView: self.view, bgColor: TUOKOUXIUSwiftZTClr12A)
        UIImageView.tukou_bjImageV(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-72/2, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 29, width: 72, height: 18), superView: tufuh_topV!, image: UIImage(named: "Explore-title"))
        let preBtn = UIButton.tukou_bjBtn(CGRect(x: 20, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 18, width: 40, height: 40), target: self, image: UIImage(named: "Explore-present"), superView: tufuh_topV!, action: #selector(clickPresent))
        preBtn.backgroundColor = .black
        preBtn.layer.cornerRadius = 20
        preBtn.layer.borderWidth = 1
        preBtn.layer.borderColor = TUOKOUXIUSwiftZTClr11A.cgColor
        
        let vipBtn = UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W - 20 - 40, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 18, width: 40, height: 40), target: self, image: UIImage(named: "Explore-vip"), superView: tufuh_topV!, action: #selector(clickVip))
        vipBtn.backgroundColor = .black
        vipBtn.layer.cornerRadius = 20
        vipBtn.layer.borderWidth = 1
        vipBtn.layer.borderColor = TUOKOUXIUSwiftZTClr11A.cgColor
    }
    
    @objc func clickPresent() {
        print("点击赠送")
    }
    
    @objc func clickVip() {
        print("点击vip")
    }
    
    @objc func tukou_creTabV() {
//        if !tufuh_dataTreArr.isEmpty {
//            return
//        }
        if (tufuh_noNetV != nil) {
            tufuh_noNetV!.removeFromSuperview()
            tufuh_noNetV = nil
        }
        
        self.tufuh_tabV.frame = CGRect(x: 0, y: tufuh_topV!.frame.maxY, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H - tufuh_topV!.frame.maxY)
        self.view.addSubview(self.tufuh_tabV)
        
        self.tufuh_tabV.delegate = self
        self.tufuh_tabV.dataSource = self
        
        self.tufuh_tabV.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUExploreTabVVDefCellId")

        self.tufuh_tabV.register(TUOKOUXIUExploreCell1.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell1Id")
        self.tufuh_tabV.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell2Id")
        self.tufuh_tabV.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell3Id")
        self.tufuh_tabV.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell4Id")
        self.tufuh_tabV.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell5Id")

    }
    
    func tukou_reqSouSuo(isPull: Bool) {
        guard TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0 else {
            TUOKOUXIUSwiftKeyWindow()!.makeToast("The network is abnormal. Please check the network link!", duration: 2.0, position: .center)
            return
        }
        
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jzGFV(TUOKOUXIUSwiftKeyWinRoV)
        
        let tufuh_arr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_routesArr
        guard tufuh_arr.count >= 6 else {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }
        
        var tufuh_psDict = self.tufuh_dataTDict
        tufuh_psDict["bid"] = TUOKOUXIUSSApp.tukou_idfi()

        guard tufuh_arr.count > 5,
              let fifthItem = tufuh_arr[5] as? [String: Any],
              let tufuh_url = fifthItem["cd"] as? String else {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }

        let tufuh_ba64Str = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_shuJJM(["cd": tufuh_url, "ps": [tufuh_psDict]])
        if TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_ba64Str) {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }
        
        TUOKOUXIUSwiftWWWL.tukou_shared.tukou_requWithURL(TUOKOUXIUSwiftConst.TUOKOUXIUjkzx, pars: [tufuh_ba64Str]) { [weak self] dataDict, isSuccess in
            guard let self = self else { return }
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            
            if isSuccess {
                if let str = dataDict as? String {
                    self.tukou_checkCode(str) { success in
                        if success {
                            self.tukou_reqSouSuo(isPull: false)
                        }
                    }
                    return
                }
                
                guard let tufuh_resArr = dataDict as? [[String: Any]] else { return }
                
            } else {

            }
        }
    }

    func tukou_noNetwV() {
        guard self.tufuh_noNetV == nil else { return }
        if !self.tufuh_dataTreArr.isEmpty {
            self.tufuh_dataTreArr.removeAll()
        }
        let tufuh_h = TUOKOUXIUSwiftSCRE_H - TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight - 56 - TUOKOUXIUDeviceInfo.tukou_tabBarHeight
        self.tufuh_noNetV = UIView.tukou_bjView(
            CGRect(x: 0, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60, width: TUOKOUXIUSwiftSCRE_W, height: tufuh_h),
            superView: self.view,
            bgColor: TUOKOUXIUSwiftheiseC
        )
        
        let tufuh_lL = UILabel.tukou_bjLabel(
            CGRect(x: 0, y: tufuh_h/2 - 12, width: TUOKOUXIUSwiftSCRE_W, height: 20),
            text: "The current network status is abnormal,",
            superView: self.tufuh_noNetV!,
            textAlignment: .center,
            font: TUOKOUXIUSwiftFont.medium(16),
            textColor: TUOKOUXIUSwiftbaiseC
        )
        
        let tufuh_lL2 = UILabel.tukou_bjLabel(
            CGRect(x: 0, y: tufuh_lL.frame.maxY + 6, width: TUOKOUXIUSwiftSCRE_W, height: 20),
            text: "please try again later.",
            superView: self.tufuh_noNetV!,
            textAlignment: .center,
            font: TUOKOUXIUSwiftFont.medium(16),
            textColor: TUOKOUXIUSwiftbaiseC
        )
        
        UIButton.tukou_bjBtn(
            CGRect(x: TUOKOUXIUSwiftSCRE_W/2 - 45, y: tufuh_lL2.frame.maxY + 24, width: 90, height: 36),
            target: self,
            imageName: "",
            superView: self.tufuh_noNetV!,
            action: #selector(tukou_creTabV),
            font: TUOKOUXIUSwiftFont.semibold(14),
            title: "Retry",
            color: TUOKOUXIUSwiftbaiseC,
            bgColor: TUOKOUXIUSwiftZTClr,
            cornerRadius: 5
        )
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        if self.tufuh_dataTreArr.isEmpty { return 0 }
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 172
        }
        return 265
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tufuh_headOpen {
            return 524
        } else {
            return 112
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var height: CGFloat = 0.0
        if tufuh_headOpen {
            height = 524
        } else {
            height = 112
        }
        
        let tufuh_v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: height))
        tufuh_v.backgroundColor = TUOKOUXIUSwiftZTClr12A

        tufuh_v.tukou_setViewCorners(
            [.bottomLeft, .bottomRight],
            radius: 32,
            borderColor: TUOKOUXIUSwiftZTClr5A,
            borderWidth: 1
        )
        if tufuh_headOpen {
            let tufuh_arr: [String] = ["通勤","深睡眠","婴儿安睡","睡午觉","图书馆","健身","瑜伽","跑步","深夜专注","专注","工作","阅读","减压","胎教","宠物陪伴","放松","经期舒展","冥想","打游戏","深夜EMO"]

            let tufuh_arr2: [String] = ["commute","sleep","baby-sleep","siesta","book","gym","yoga","run","latenight-focus","focus","work","read","stress-relief","prenatal-education","pet","relax","period","meditation","game","emo"]

            // 布局参数
            let itemW = 76
            let itemH = 87
            let columnCount = 4        // 每行最多 4 个
            let rowSpacing = 12
            let columnSpacing = 10
            let leftPadding = 20

            for i in 0 ..< tufuh_arr.count {

                let row = i / columnCount
                let col = i % columnCount
                
                let btnX = leftPadding + col * (itemW + columnSpacing)
                let btnY = row * (itemH + rowSpacing) + 1

                let btnV = UIButton.tukou_bjBtnNoImage(
                    CGRect(x: btnX, y: btnY, width: itemW, height: itemH),
                    target: self,
                    superView: tufuh_v,
                    action: #selector(clickTypeUpdate(_:))
                )
                btnV.layer.cornerRadius = 20
                btnV.tag = i
                
                // 默认选中第 2 个
                if i == 2 {
                    btnV.isSelected = true
                }

                if btnV.isSelected {
                    btnV.backgroundColor = TUOKOUXIUSwiftZTClr5A
                    btnV.layer.borderColor = TUOKOUXIUSwiftZTClr3A.cgColor
                    btnV.layer.borderWidth = 1
                } else {
                    btnV.backgroundColor = TUOKOUXIUSwiftwuseC
                    btnV.layer.borderColor = TUOKOUXIUSwiftwuseC.cgColor
                    btnV.layer.borderWidth = 0
                }

                // 图标
                let typeIconIV = UIImageView.tukou_bjImageV(
                    CGRect(x: itemW/2-32/2, y: 12, width: 32, height: 32),
                    superView: btnV,
                    image: UIImage(named: tufuh_arr2[i])
                )

                // 文案
                let _ = UILabel.tukou_bjLabel(
                    CGRect(x: 0, y: Int(typeIconIV.frame.maxY) + 10, width: itemW, height: 17),
                    text: tufuh_arr[i],
                    superView: btnV,
                    textAlignment: .center,
                    font: TUOKOUXIUSwiftFont.regular(12),
                    textColor: TUOKOUXIUSwiftbaiseC
                )
            }
        } else {
            let tufuh_arr: [String] = ["通勤","深睡眠","婴儿安睡","睡午觉"]
            let tufuh_arr2: [String] = ["commute","sleep","baby-sleep","siesta"]
                
            for i in 0...tufuh_arr.count - 1 {
                let tufuh_string = tufuh_arr[i]
                let tufuh_string2 = tufuh_arr2[i]
                let btnX = 20 + i * (76 + 10)
                let btnV = UIButton.tukou_bjBtnNoImage(CGRect(x: btnX, y: 1, width: 76, height: 87), target: self, superView: tufuh_v, action: #selector(clickTypeUpdate(_:)))
                btnV.layer.cornerRadius = 20
                btnV.tag = i
                if i == 2 {
                    btnV.isSelected = true
                }
                if btnV.isSelected {
                    btnV.backgroundColor = TUOKOUXIUSwiftZTClr5A
                    btnV.layer.borderColor = TUOKOUXIUSwiftZTClr3A.cgColor
                    btnV.layer.borderWidth = 1
                } else {
                    btnV.backgroundColor = TUOKOUXIUSwiftwuseC
                    btnV.layer.borderColor = TUOKOUXIUSwiftwuseC.cgColor
                    btnV.layer.borderWidth = 0
                }

                let typeIconIV = UIImageView.tukou_bjImageV(CGRect(x: 76/2-32/2, y: 12, width: 32, height: 32), superView: btnV, image: UIImage(named: tufuh_string2))
                
                let _ = UILabel.tukou_bjLabel(CGRect(x: 0, y: typeIconIV.frame.maxY + 10, width: 76, height: 17), text: tufuh_string, superView: btnV, textAlignment: .center, font: TUOKOUXIUSwiftFont.regular(12), textColor: TUOKOUXIUSwiftbaiseC)
            }
        }
        UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 1), superView: tufuh_v, bgColor: .black)
        UIView.tukou_bjView(CGRect(x: 0, y: 0, width: 1, height: height), superView: tufuh_v, bgColor: .black)
        UIView.tukou_bjView(CGRect(x: TUOKOUXIUSwiftSCRE_W-1, y: 0, width: 1, height: height), superView: tufuh_v, bgColor: .black)
        let botBtn = UIButton.tukou_bjBtnNoImage(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-36/2, y: height-16, width: 36, height: 6), target: self, superView: tufuh_v, action: #selector(clickOpenHeadView))
        botBtn.backgroundColor = TUOKOUXIUSwiftZTClr4A
        botBtn.layer.cornerRadius = 3
        botBtn.tukou_setEnlargeEdge(9)
        return tufuh_v
    }
    
    @objc func clickOpenHeadView() {
        tufuh_headOpen = !tufuh_headOpen
        tufuh_tabV.reloadData()
    }
                                             
    //点击更新类型
    @objc func clickTypeUpdate(_ btn: UIButton) {
        let _ = btn.tag
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 100))
        footerView.backgroundColor = TUOKOUXIUSwiftheiseC
        return footerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell1Id", for: indexPath) as! TUOKOUXIUExploreCell1
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell2Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.tufuh_isLock = false
            cell.tukou_nameString("活跃")
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell3Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.tufuh_isLock = false
            cell.tukou_nameString("助眠")
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell4Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.tufuh_isLock = false
            cell.tukou_nameString("放松")
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell5Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.tufuh_isLock = true
            cell.tukou_nameString("专注")
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreTabVVDefCellId", for: indexPath)
        cell.backgroundColor = TUOKOUXIUSwiftheiseC
        return cell
    }

}
