
import UIKit
import SwiftUI

class TUOKOUXIUExploreVC2: UIViewController {

    private let tableView = UITableView()
    private let headerView = HeaderView()
    var tufuh_noNetV: UIView?
//    private let bottomBarHeight: CGFloat = 56
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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
        
        setupTableView()
//        setupBottomBar()
        setupHeader()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TUOKOUXIUWhiteA5
        UIView.tukou_bjView(CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H-200, width: TUOKOUXIUSwiftSCRE_W, height: 200), superView: view, bgColor: TUOKOUXIUSwiftheiseC)
        tukou_testNet()
        UIImageView.tukou_bjImageV(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-72/2, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 15, width: 72, height: 18), superView: self.view, image: UIImage(named: "Explore-title"))
        UIImageView.tukou_bjImageV(CGRect(x: 0, y: 0, width: Int(TUOKOUXIUSwiftSCRE_W), height: Int(TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight) + 76), superView: self.view, image: UIImage(named: "home_top_shadow"))
    }

//    private func setupBottomBar() {
//        let bottomBar = UIView()
//        bottomBar.backgroundColor = TUOKOUXIUSwiftheiseC
//        view.addSubview(bottomBar)
//        bottomBar.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            bottomBar.heightAnchor.constraint(equalToConstant: bottomBarHeight)
//        ])
//    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUExploreTabVVDefCellId")
        tableView.register(TUOKOUXIUExploreCell1.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell1Id")
        tableView.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell2Id")
        tableView.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell3Id")
        tableView.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell4Id")
        tableView.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell5Id")
        tableView.backgroundColor = .clear
//        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.contentInset.top = 40
    }

    private func setupHeader() {
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: headerView.minHeight)
        tableView.tableHeaderView = headerView

        // Header 内部回调，联动 tableHeaderView 高度
        headerView.onHeightChange = { [weak self] newHeight in
            guard let self = self else { return }
            var frame = self.headerView.frame
            frame.size.height = newHeight
            self.headerView.frame = frame
            self.tableView.tableHeaderView = self.headerView
        }
//        headerView.layer.cornerRadius = 32
//        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        headerView.layer.masksToBounds = true
//
//        headerView.layer.borderColor = TUOKOUXIUWhiteA10.cgColor
//        headerView.layer.borderWidth = 0.5
    }
}

extension TUOKOUXIUExploreVC2: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 172
        }
        return 265
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
    func tukou_noNetwV() {
        guard self.tufuh_noNetV == nil else { return }
//        if !self.tufuh_dataTreArr.isEmpty {
//            self.tufuh_dataTreArr.removeAll()
//        }
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
