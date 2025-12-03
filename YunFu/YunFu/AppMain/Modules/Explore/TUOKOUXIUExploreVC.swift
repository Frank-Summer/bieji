
import UIKit
import Foundation
import Toast
import Combine

let HeadTitleSpacing: CGFloat = 60.0

class TUOKOUXIUExploreVC: TUOKOUXIUSwiftBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    var tufuh_topV: UIView?
    var tufuh_noNetV: UIView?
    var tufuh_dataTreArr: [[String: Any]] = []
    var tufuh_dataTDict: [String: Any] = [:]
    var tufuh_botBtn: UIButton?
    
    private let headerMinHeight: CGFloat = 112 + TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + HeadTitleSpacing
    private let headerMaxHeight: CGFloat = 524 + TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + HeadTitleSpacing

    private let headerView = UIView()
    private var tufuh_tabV = PassThroughTableView()

    private var cancellables = Set<AnyCancellable>()
    
//    lazy var tufuh_tabV: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.separatorStyle = .none
//        tableView.showsVerticalScrollIndicator = false
//        tableView.contentInsetAdjustmentBehavior = .never
//        tableView.sectionHeaderTopPadding = 0
//        tableView.backgroundColor = .black
//        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
//        tableView.estimatedRowHeight = 0
//        tableView.estimatedSectionHeaderHeight = 0
//        tableView.estimatedSectionFooterHeight = 0
//        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01)
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        return tableView
//    }()
    
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
        
        UIImageView.tukou_bjImageV(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-72/2, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 15, width: 72, height: 18), superView: self.view, image: UIImage(named: "Explore-title"))
        UIImageView.tukou_bjImageV(CGRect(x: 0, y: 0, width: Int(TUOKOUXIUSwiftSCRE_W), height: Int(TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight) + 76), superView: self.view, image: UIImage(named: "home_top_shadow"))
    }
    
    @objc func tukou_testNet() {
        if (TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0) {
            self.tukou_creTabV()
        } else {
            self.tukou_noNetwV()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 让 tableView 初始 offset 刚好显示 headerMinHeight
        tufuh_tabV.contentOffset.y = -headerMinHeight
        
        // 同步 header 初始 frame
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.bounds.width,
                                  height: headerMinHeight)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.insertSubview(tufuh_tabV, aboveSubview: headerView)
    }
    
    @objc func tukou_creTabV() {
        if (tufuh_noNetV != nil) {
            tufuh_noNetV!.removeFromSuperview()
            tufuh_noNetV = nil
        }
        tufuh_tabV = PassThroughTableView(frame: .zero, style: .plain)
        tufuh_tabV.delegate = self
        tufuh_tabV.dataSource = self
        tufuh_tabV.alwaysBounceVertical = true
        tufuh_tabV.backgroundColor = .clear
        tufuh_tabV.separatorStyle = .none
        tufuh_tabV.showsVerticalScrollIndicator = false
        tufuh_tabV.contentInsetAdjustmentBehavior = .never
        // tableView frame 固定
        tufuh_tabV.frame = view.bounds
        // 给 header 留出空间
        tufuh_tabV.contentInset = UIEdgeInsets(top: headerMaxHeight, left: 0, bottom: 0, right: 0)
        tufuh_tabV.scrollIndicatorInsets = tufuh_tabV.contentInset

        view.addSubview(tufuh_tabV)
        tufuh_tabV.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUExploreTabVVDefCellId")
        tufuh_tabV.register(TUOKOUXIUExploreCell1.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell1Id")
        tufuh_tabV.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell2Id")
        tufuh_tabV.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell3Id")
        tufuh_tabV.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell4Id")
        tufuh_tabV.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell5Id")
        
        headerView.backgroundColor = TUOKOUXIUWhiteA5

//        headerView.tukou_setViewCorners(
//            [.bottomLeft, .bottomRight],
//            radius: 32,
//            borderColor: TUOKOUXIUWhiteA10,
//            borderWidth: 1
//        )
        view.addSubview(headerView)
        // 初始位置在顶部，初始高度 headerMinHeight
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: headerMinHeight)
        let staY: CGFloat = TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + HeadTitleSpacing
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
        
        tufuh_botBtn = UIButton.tukou_bjBtnNoImage(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-36/2, y: staY+112-16, width: 36, height: 6), target: self, superView: headerView, action: #selector(clickOpenHeadView))
        tufuh_botBtn!.backgroundColor = TUOKOUXIUWhiteA30
        tufuh_botBtn!.layer.cornerRadius = 3
        headerView.layer.cornerRadius = 32
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = TUOKOUXIUWhiteA10.cgColor

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 172
        }
        return 265
    }
    
    @objc func clickOpenHeadView() {

    }
                                             
    @objc func clickTypeUpdate(_ btn: UIButton) {
        let _ = btn.tag
        print("\(btn.tag)")
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 100))
        footerView.backgroundColor = TUOKOUXIUSwiftwuseC
        return footerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell1Id", for: indexPath) as! TUOKOUXIUExploreCell1
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell2Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            cell.tufuh_isLock = false
            cell.tukou_nameString("活跃")
            cell.TUOKOUXIUclkItemBlk = { [weak self] model in
                self!.showDetail()
            }
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell3Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            cell.tufuh_isLock = false
            cell.tukou_nameString("助眠")
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell4Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            cell.tufuh_isLock = false
            cell.tukou_nameString("放松")
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell5Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            cell.tufuh_isLock = true
            cell.tukou_nameString("专注")
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreTabVVDefCellId", for: indexPath)
        cell.backgroundColor = TUOKOUXIUSwiftheiseC
        return cell
    }
    
    func showDetail() {
        print("点击显示详情")
        
        let picker = ExploreDetailView()
        picker.show(in: self.view)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
//        print("\(offsetY)")
        // 下拉到顶部
        if offsetY < -headerMinHeight {
            print("\(offsetY)")
            if headerView.frame.height != headerMaxHeight {
                if (tufuh_botBtn != nil) {
                    let y: CGFloat = (tufuh_botBtn?.frame.minY)!
                    if y < 300 {
                        let staY: CGFloat = TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + HeadTitleSpacing
                        tufuh_botBtn?.frame = CGRect(x: TUOKOUXIUSwiftSCRE_W/2-36/2, y: staY+524-16, width: 36, height: 6)
                    }
                }

                UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
                    self.headerView.frame = CGRect(x: 0,
                                                   y: 0,
                                                   width: self.view.bounds.width,
                                                   height: self.headerMaxHeight)
                }, completion: nil)
            }
            return
        } else {
            let y: CGFloat = (tufuh_botBtn?.frame.minY)!
            if y > 300 {
                let staY: CGFloat = TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + HeadTitleSpacing
                tufuh_botBtn?.frame = CGRect(x: TUOKOUXIUSwiftSCRE_W/2-36/2, y: staY+112-16, width: 36, height: 6)
            }
        }

        // 上滑逻辑
        // header 高度随滚动收回
        let newHeight = headerMinHeight

        // header y 坐标
        var headerY = 0
        if offsetY + headerMaxHeight - headerMinHeight > headerMaxHeight - headerMinHeight {
//            print("+++++++++++    \(offsetY + headerMaxHeight - headerMinHeight)")
            // 超过收回阶段，header 跟随 tableView 往上滚动
            headerY = Int(-((offsetY + headerMaxHeight - headerMinHeight) - (headerMaxHeight - headerMinHeight)))
        }
        headerView.frame = CGRect(x: 0, y: CGFloat(headerY), width: view.bounds.width, height: newHeight)
//        print("----------------    \(newHeight)")
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
}
