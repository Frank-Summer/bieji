
import Foundation
import UIKit

class TUOKOUXIUSwiftHHHCateDepVC: TUOKOUXIUSwiftBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    var tufuh_dataTreArr: [[String: Any]] = []
    
    private var tufuh_topV: UIView?
    private var tufuh_tNavV: UIView?
    private var tufuh_tabV: UITableView?
    private var tufuh_noNetV: UIView?
    private var tufuh_toTopBtn: UIButton?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TUOKOUXIUSwiftheiseC
        tukou_topVi()
        
        if TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() == 0 {
            tukou_noNetwV()
            return
        }
        tukou_creTabV()
    }
    
    func tukou_topVi() {
        tufuh_topV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight),
                                         superView: view,
                                         bgColor: TUOKOUXIUSwiftheiseC)
        
        tufuh_tNavV = UIView.tukou_bjView(CGRect(x: 0, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight,
                                                 width: TUOKOUXIUSwiftSCRE_W, height: 56),
                                          superView: view,
                                          bgColor: TUOKOUXIUSwiftheiseC)
        
        let tufuh_iV = UIImageView.tukou_bjImageV(CGRect(x: 10, y: 16, width: 24, height: 24),
                                                  superView: tufuh_tNavV!,
                                                  image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_nav_top_left", andIsOne: false))
        tufuh_iV.isUserInteractionEnabled = true
        
        tufuh_iV.tukou_addTapGesture(target: self, action: #selector(tukou_goBack))
        
        UILabel.tukou_bjLabel(CGRect(x: 44, y: 17, width: TUOKOUXIUSwiftSCRE_W - 88, height: 22),
                              text: "Part of the \(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[38]) Collection",
                              superView: tufuh_tNavV!,
                              textAlignment: .center,
                              font: TUOKOUXIUSwiftFont.semibold(18),
                              textColor: TUOKOUXIUSwiftZTClr3)
        
        let tufuh_sV = UIImageView.tukou_bjImageV(CGRect(x: TUOKOUXIUSwiftSCRE_W - 34, y: 16, width: 24, height: 24),
                                                  superView: tufuh_tNavV!,
                                                  image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_sub_vie_sear", andIsOne: false))
        tufuh_sV.isUserInteractionEnabled = true
        
        tufuh_sV.tukou_addTapGesture(target: self, action: #selector(tukou_goToSearch))
    }
    
    func tukou_creTabV() {
        if (tufuh_noNetV != nil) {
            tufuh_noNetV!.removeFromSuperview()
            tufuh_noNetV = nil
        }

        if let table = tufuh_tabV {
            table.reloadData()
            return
        }
        
        let table = self.tufuh_tabV ?? UITableView(frame: .zero, style: .grouped)
        table.frame = CGRect(x: 0,
                             y: tufuh_tNavV?.frame.maxY ?? 0,
                             width: TUOKOUXIUSwiftSCRE_W,
                             height: TUOKOUXIUSwiftSCRE_H - (tufuh_tNavV?.frame.maxY ?? 0))
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = TUOKOUXIUSwiftheiseC
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        } else {
            if table.contentOffset.y == 0 {
                table.contentInset = UIEdgeInsets(top: -34, left: 0, bottom: 0, right: 0)
            }
        }
        table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
        table.estimatedRowHeight = 0
        table.estimatedSectionHeaderHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUHHHTbVVDefCelId")
        table.register(TUOKOUXIUSwiftHHHTabVCell.self, forCellReuseIdentifier: "TUOKOUXIUHHHTbVVCelId")
        view.addSubview(table)
        tufuh_tabV = table
        table.reloadData()
    }
    func tukou_noNetwV() {
        if (tufuh_tabV != nil) {
            tufuh_tabV!.removeFromSuperview()
            tufuh_tabV = nil
        }

        if tufuh_noNetV != nil { return }
        
        let tufuh_h = TUOKOUXIUSwiftSCRE_H - TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight - 60 - TUOKOUXIUDeviceInfo.tukou_tabBarHeight
        let noNetView = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: tufuh_h),
                                            superView: view,
                                            bgColor: TUOKOUXIUSwiftheiseC)
        tufuh_noNetV = noNetView
        
        let l1 = UILabel.tukou_bjLabel(CGRect(x: 0, y: tufuh_h/2 - 12, width: TUOKOUXIUSwiftSCRE_W, height: 20),
                                       text: "The current network status is abnormal,",
                                       superView: noNetView,
                                       textAlignment: .center,
                                       font: TUOKOUXIUSwiftFont.medium(16),
                                       textColor: TUOKOUXIUSwiftbaiseC)
        UILabel.tukou_bjLabel(CGRect(x: 0, y: l1.frame.maxY + 6, width: TUOKOUXIUSwiftSCRE_W, height: 20),
                              text: "please try again later.",
                              superView: noNetView,
                              textAlignment: .center,
                              font: TUOKOUXIUSwiftFont.medium(16),
                              textColor: TUOKOUXIUSwiftbaiseC)
        UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W/2 - 45, y: l1.frame.maxY + 30, width: 90, height: 36),
                             target: self,
                             imageName: "",
                             superView: noNetView,
                             action: #selector(tukou_testNet),
                             font: TUOKOUXIUSwiftFont.semibold(14),
                             title: "Retry",
                             color: TUOKOUXIUSwiftbaiseC,
                             bgColor: TUOKOUXIUSwiftZTClr,
                             cornerRadius: 5)
    }
    
    @objc func tukou_testNet() {
        if TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0 {
            tukou_creTabV()
        } else {
            tukou_noNetwV()
        }
    }
    @objc func tukou_goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tukou_goToSearch() {
        let tarVC = TUOKOUXIUSwiftSSSVC()
        tarVC.tufuh_source = "3"
        tarVC.tufuh_isHHH = false
        navigationController?.pushViewController(tarVC, animated: true)
    }
    @objc func tukou_toTop() {
        tufuh_tabV?.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    func tukou_shoTopBtn() {
        tufuh_toTopBtn = UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W - 60, y: TUOKOUXIUSwiftSCRE_H - 90, width: 40, height: 40),
                                              target: self,
                                              image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_totop", andIsOne: false),
                                              superView: view,
                                              action: #selector(tukou_toTop))
    }
    func tukou_hidTopBt() {
        if (tufuh_toTopBtn != nil) {
            tufuh_toTopBtn!.removeFromSuperview()
            tufuh_toTopBtn = nil
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == tufuh_tabV else { return }
        let y = scrollView.contentOffset.y
        if y >= TUOKOUXIUSwiftSCRE_H / 2, !tufuh_dataTreArr.isEmpty {
            if tufuh_toTopBtn == nil { tukou_shoTopBtn() }
        } else {
            if tufuh_toTopBtn != nil { tukou_hidTopBt() }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return tufuh_dataTreArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160 * TUOKOUXIUDeviceInfo.scaleX + 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tufuh_dataTreArr.isEmpty ? 0 : 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !tufuh_dataTreArr.isEmpty else { return UIView() }
        let v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 50))
        let d = tufuh_dataTreArr[section]
        let title = d["name"] as? String ?? ""
        var genre = d["genre"] as? String ?? ""
        if genre.contains(",") {
            genre = genre.replacingOccurrences(of: ",", with: " · ")
        }
        UILabel.tukou_bjLabel(CGRect(x: 10, y: 5, width: TUOKOUXIUSwiftSCRE_W - 20, height: 20),
                              text: title,
                              superView: v,
                              textAlignment: .left,
                              font: TUOKOUXIUSwiftFont.medium(16),
                              textColor: TUOKOUXIUSwiftbaiseC)
        UILabel.tukou_bjLabel(CGRect(x: 10, y: 30, width: TUOKOUXIUSwiftSCRE_W - 20, height: 14),
                              text: genre,
                              superView: v,
                              textAlignment: .left,
                              font: TUOKOUXIUSwiftFont.light(10),
                              textColor: TUOKOUXIUSwiftbaiseC)
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 13
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 13))
        v.backgroundColor = TUOKOUXIUSwiftheiseC
        return v
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !tufuh_dataTreArr.isEmpty else {
            let c = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUHHHTbVVDefCelId", for: indexPath)
            c.backgroundColor = TUOKOUXIUSwiftheiseC
            return c
        }
        
        let c = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUHHHTbVVCelId", for: indexPath) as! TUOKOUXIUSwiftHHHTabVCell
        c.tufuh_isZhanShiAd = false
        c.backgroundColor = TUOKOUXIUSwiftheiseC
        c.tufuh_isHis = false
        let dict = tufuh_dataTreArr[indexPath.section]
        if let arr = dict["value"] as? [[String: Any]] {
            c.tukou_resData(arr)
        }
        c.tufuh_clkItemBlk = { model in


        }
        return c
    }

}
