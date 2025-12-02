
import UIKit
import Foundation
import Toast
import Combine

class XiaoHongShuHeaderDemoVC: TUOKOUXIUSwiftBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    var tufuh_topV: UIView?
    var tufuh_noNetV: UIView?
    var tufuh_dataTreArr: [[String: Any]] = []
    var tufuh_dataTDict: [String: Any] = [:]
//    var tufuh_headOpen: Bool = false
    private var headerHeight: CGFloat = 112 + TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 76
    private let headerMinH: CGFloat = 112 + TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 76
    private let headerMaxH: CGFloat = 524 + TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 76
    private let damping: CGFloat = 1.0      // 阻尼系数
    private let headerView = UIView()
//    private var buttons: [UIButton] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    lazy var tufuh_tabV: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .black
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
//        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = headerMaxH
        tableView.estimatedSectionFooterHeight = 0
//        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01)
        
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
        
        tukou_testNet()
        
        UIImageView.tukou_bjImageV(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-72/2, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 29, width: 72, height: 18), superView: self.view, image: UIImage(named: "Explore-title"))
        UIImageView.tukou_bjImageV(CGRect(x: 0, y: 0, width: Int(TUOKOUXIUSwiftSCRE_W), height: Int(TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight) + 76), superView: self.view, image: UIImage(named: "home_top_shadow"))
        
    }
    
    private func setupHeader() {
        headerView.backgroundColor = TUOKOUXIUWhiteA5
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: headerHeight)

        let tufuh_arr: [String] = ["通勤","深睡眠","婴儿安睡","睡午觉","图书馆","健身","瑜伽","跑步","深夜专注","专注","工作","阅读","减压","胎教","宠物陪伴","放松","经期舒展","冥想","打游戏","深夜EMO"]
        let tufuh_arr2: [String] = ["commute","sleep","baby-sleep","siesta","book","gym","yoga","run","latenight-focus","focus","work","read","stress-relief","prenatal-education","pet","relax","period","meditation","game","emo"]
        let staY: CGFloat = TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 76.0
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
            let btnY = Int(staY) + row * (itemH + rowSpacing) + 1

            let btnV = UIButton.tukou_bjBtnNoImage(
                CGRect(x: btnX, y: btnY, width: itemW, height: itemH),
                target: self,
                superView: headerView,
                action: #selector(clickTypeUpdate(_:))
            )
            btnV.layer.cornerRadius = 20
            btnV.tag = i

            // 默认选中第 2 个
            if i == 2 {
                btnV.isSelected = true
            }

            if btnV.isSelected {
                btnV.backgroundColor = TUOKOUXIUWhiteA10
                btnV.layer.borderColor = TUOKOUXIUWhiteA60.cgColor
                btnV.layer.borderWidth = 1
            } else {
                btnV.backgroundColor = TUOKOUXIUSwiftwuseC
                btnV.layer.borderColor = TUOKOUXIUSwiftwuseC.cgColor
                btnV.layer.borderWidth = 0
            }

            let typeIconIV = UIImageView.tukou_bjImageV(
                CGRect(x: itemW/2-32/2, y: 12, width: 32, height: 32),
                superView: btnV,
                image: UIImage(named: tufuh_arr2[i])
            )

            let _ = UILabel.tukou_bjLabel(
                CGRect(x: 0, y: Int(typeIconIV.frame.maxY) + 10, width: itemW, height: 17),
                text: tufuh_arr[i],
                superView: btnV,
                textAlignment: .center,
                font: TUOKOUXIUSwiftFont.regular(12),
                textColor: TUOKOUXIUSwiftbaiseC
            )
        }

        // 底部小条按钮
        UIView.tukou_bjView(CGRect(x: 0, y: staY, width: TUOKOUXIUSwiftSCRE_W, height: 1), superView: headerView, bgColor: .red)
//        UIView.tukou_bjView(CGRect(x: 0, y: staY, width: 1, height: headerHeight), superView: headerView, bgColor: .black)
//        UIView.tukou_bjView(CGRect(x: TUOKOUXIUSwiftSCRE_W-1, y: staY, width: 1, height: headerHeight), superView: headerView, bgColor: .black)
        let botBtn = UIButton.tukou_bjBtnNoImage(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-36/2, y: headerMaxH-16, width: 36, height: 6), target: self, superView: headerView, action: #selector(clickOpenHeadView))
        botBtn.backgroundColor = TUOKOUXIUWhiteA30
        botBtn.layer.cornerRadius = 3
        botBtn.tukou_setEnlargeEdge(9)

        tufuh_tabV.tableHeaderView = headerView
    }
    
    @objc func tukou_testNet() {
        if (TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0) {
            self.tukou_creTabV()
        } else {
            self.tukou_noNetwV()
        }
    }
    
    @objc func tukou_creTabV() {
        if (tufuh_noNetV != nil) {
            tufuh_noNetV!.removeFromSuperview()
            tufuh_noNetV = nil
        }
        
        self.tufuh_tabV.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H)
        self.view.addSubview(self.tufuh_tabV)
        self.tufuh_tabV.delegate = self
        self.tufuh_tabV.dataSource = self
        self.tufuh_tabV.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUExploreTabVVDefCellId")
        self.tufuh_tabV.register(TUOKOUXIUExploreCell1.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell1Id")
        self.tufuh_tabV.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell2Id")
        self.tufuh_tabV.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell3Id")
        self.tufuh_tabV.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell4Id")
        self.tufuh_tabV.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell5Id")
        
        setupHeader()
    }

    func tukou_noNetwV() {
        guard self.tufuh_noNetV == nil else { return }
        if !self.tufuh_dataTreArr.isEmpty {
            self.tufuh_dataTreArr.removeAll()
        }
        self.tufuh_noNetV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H), superView: self.view, bgColor: TUOKOUXIUSwiftheiseC)

        UIImageView.tukou_bjImageV(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-30, y: TUOKOUXIUSwiftSCRE_H/2-12-16-60, width: 60, height: 60), superView: self.tufuh_noNetV!, image: UIImage(named: "net"))
        
        let label1 = UILabel.tukou_bjLabel(CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H/2-12, width: TUOKOUXIUSwiftSCRE_W, height: 24),
                                            text: "网络连接失败",
                                           superView: self.tufuh_noNetV!,
                                            textAlignment: .center,
                                           font: TUOKOUXIUSwiftFont.semibold(16),
                                            textColor: TUOKOUXIUSwiftbaiseC)
        
        let label2 = UILabel.tukou_bjLabel(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-110, y: label1.frame.maxY, width: 220, height: 50),
                                            text: "别急，好饭不怕晚，请检查当前网络状态后再试试",
                                           superView: self.tufuh_noNetV!,
                                            textAlignment: .center,
                                           font: TUOKOUXIUSwiftFont.regular(14),
                                            textColor: TUOKOUXIUWhiteA60)
        label2.numberOfLines = 0
        
        UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-30, y: label2.frame.maxY + 24, width: 60, height: 40),
                             target: self,
                             imageName: "",
                             superView: self.tufuh_noNetV!,
                             action: #selector(tukou_testNet),
                             font: TUOKOUXIUSwiftFont.semibold(14),
                             title: "重试",
                             color: TUOKOUXIUSwiftbaiseC,
                             bgColor: TUOKOUXIUWhiteA10,
                             cornerRadius: 12)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 172
        }
        return 265
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tufuh_tabV.tableHeaderView else { return }

        let offsetY = scrollView.contentOffset.y
        var newHeight = header.frame.height - offsetY * damping
        newHeight = max(headerMinH, min(headerMaxH, newHeight))

        if newHeight != header.frame.height {
            header.frame.size.height = newHeight
            tufuh_tabV.tableHeaderView = header // 必须重新赋值
            scrollView.contentOffset.y = 0      // 保持滚动平滑
        }
    }

//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if tufuh_headOpen {
//            return 524 + TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 76
//        } else {
//            return 112 + TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 76
//        }
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        var height: CGFloat = 0.0
//        if tufuh_headOpen {
//            height = 524
//        } else {
//            height = 112
//        }
//        let staY: CGFloat = TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 76.0
//        let tufuh_v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: height))
//        tufuh_v.backgroundColor = TUOKOUXIUWhiteA5
//
//        tufuh_v.tukou_setViewCorners(
//            [.bottomLeft, .bottomRight],
//            radius: 32,
//            borderColor: TUOKOUXIUWhiteA10,
//            borderWidth: 1
//        )
//        if tufuh_headOpen {
//            let tufuh_arr: [String] = ["通勤","深睡眠","婴儿安睡","睡午觉","图书馆","健身","瑜伽","跑步","深夜专注","专注","工作","阅读","减压","胎教","宠物陪伴","放松","经期舒展","冥想","打游戏","深夜EMO"]
//
//            let tufuh_arr2: [String] = ["commute","sleep","baby-sleep","siesta","book","gym","yoga","run","latenight-focus","focus","work","read","stress-relief","prenatal-education","pet","relax","period","meditation","game","emo"]
//
//            // 布局参数
//            let itemW = 76
//            let itemH = 87
//            let columnCount = 4        // 每行最多 4 个
//            let rowSpacing = 12
//            let columnSpacing = 10
//            let leftPadding = 20
//
//            for i in 0 ..< tufuh_arr.count {
//
//                let row = i / columnCount
//                let col = i % columnCount
//
//                let btnX = leftPadding + col * (itemW + columnSpacing)
//                let btnY = Int(staY) + row * (itemH + rowSpacing) + 1
//
//                let btnV = UIButton.tukou_bjBtnNoImage(
//                    CGRect(x: btnX, y: btnY, width: itemW, height: itemH),
//                    target: self,
//                    superView: tufuh_v,
//                    action: #selector(clickTypeUpdate(_:))
//                )
//                btnV.layer.cornerRadius = 20
//                btnV.tag = i
//
//                // 默认选中第 2 个
//                if i == 2 {
//                    btnV.isSelected = true
//                }
//
//                if btnV.isSelected {
//                    btnV.backgroundColor = TUOKOUXIUWhiteA10
//                    btnV.layer.borderColor = TUOKOUXIUWhiteA60.cgColor
//                    btnV.layer.borderWidth = 1
//                } else {
//                    btnV.backgroundColor = TUOKOUXIUSwiftwuseC
//                    btnV.layer.borderColor = TUOKOUXIUSwiftwuseC.cgColor
//                    btnV.layer.borderWidth = 0
//                }
//
//                let typeIconIV = UIImageView.tukou_bjImageV(
//                    CGRect(x: itemW/2-32/2, y: 12, width: 32, height: 32),
//                    superView: btnV,
//                    image: UIImage(named: tufuh_arr2[i])
//                )
//
//                let _ = UILabel.tukou_bjLabel(
//                    CGRect(x: 0, y: Int(typeIconIV.frame.maxY) + 10, width: itemW, height: 17),
//                    text: tufuh_arr[i],
//                    superView: btnV,
//                    textAlignment: .center,
//                    font: TUOKOUXIUSwiftFont.regular(12),
//                    textColor: TUOKOUXIUSwiftbaiseC
//                )
//            }
//        } else {
//            let tufuh_arr: [String] = ["通勤","深睡眠","婴儿安睡","睡午觉"]
//            let tufuh_arr2: [String] = ["commute","sleep","baby-sleep","siesta"]
//
//            for i in 0...tufuh_arr.count - 1 {
//                let tufuh_string = tufuh_arr[i]
//                let tufuh_string2 = tufuh_arr2[i]
//                let btnX = 20 + i * (76 + 10)
//                let btnV = UIButton.tukou_bjBtnNoImage(CGRect(x: btnX, y: Int(staY) + 1, width: 76, height: 87), target: self, superView: tufuh_v, action: #selector(clickTypeUpdate(_:)))
//                btnV.layer.cornerRadius = 20
//                btnV.tag = i
//                if i == 2 {
//                    btnV.isSelected = true
//                }
//                if btnV.isSelected {
//                    btnV.backgroundColor = TUOKOUXIUWhiteA10
//                    btnV.layer.borderColor = TUOKOUXIUWhiteA60.cgColor
//                    btnV.layer.borderWidth = 1
//                } else {
//                    btnV.backgroundColor = TUOKOUXIUSwiftwuseC
//                    btnV.layer.borderColor = TUOKOUXIUSwiftwuseC.cgColor
//                    btnV.layer.borderWidth = 0
//                }
//
//                let typeIconIV = UIImageView.tukou_bjImageV(CGRect(x: 76/2-32/2, y: 12, width: 32, height: 32), superView: btnV, image: UIImage(named: tufuh_string2))
//
//                let _ = UILabel.tukou_bjLabel(CGRect(x: 0, y: typeIconIV.frame.maxY + 10, width: 76, height: 17), text: tufuh_string, superView: btnV, textAlignment: .center, font: TUOKOUXIUSwiftFont.regular(12), textColor: TUOKOUXIUSwiftbaiseC)
//            }
//        }
//        UIView.tukou_bjView(CGRect(x: 0, y: staY, width: TUOKOUXIUSwiftSCRE_W, height: 1), superView: tufuh_v, bgColor: .black)
//        UIView.tukou_bjView(CGRect(x: 0, y: staY, width: 1, height: height), superView: tufuh_v, bgColor: .black)
//        UIView.tukou_bjView(CGRect(x: TUOKOUXIUSwiftSCRE_W-1, y: staY, width: 1, height: height), superView: tufuh_v, bgColor: .black)
//        let botBtn = UIButton.tukou_bjBtnNoImage(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-36/2, y: staY+height-16, width: 36, height: 6), target: self, superView: tufuh_v, action: #selector(clickOpenHeadView))
//        botBtn.backgroundColor = TUOKOUXIUWhiteA30
//        botBtn.layer.cornerRadius = 3
//        botBtn.tukou_setEnlargeEdge(9)
//        return tufuh_v
//    }
//
    @objc func clickOpenHeadView() {
//        tufuh_headOpen = !tufuh_headOpen
//        tufuh_tabV.reloadData()
    }
                                             
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
            cell.backgroundColor = .black
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell2Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.backgroundColor = .black
            cell.tufuh_isLock = false
            cell.tukou_nameString("活跃")
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell3Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.backgroundColor = .black
            cell.tufuh_isLock = false
            cell.tukou_nameString("助眠")
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell4Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.backgroundColor = .black
            cell.tufuh_isLock = false
            cell.tukou_nameString("放松")
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell5Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.backgroundColor = .black
            cell.tufuh_isLock = true
            cell.tukou_nameString("专注")
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreTabVVDefCellId", for: indexPath)
        cell.backgroundColor = TUOKOUXIUSwiftheiseC
        return cell
    }
}
