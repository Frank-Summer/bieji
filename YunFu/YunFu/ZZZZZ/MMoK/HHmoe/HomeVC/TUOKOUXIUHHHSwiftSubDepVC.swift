
import Kingfisher
import Foundation
import UIKit

class TUOKOUXIUHHHSwiftSubDepVC: TUOKOUXIUSwiftBaseVC {
    
    var tufuh_kvd: String?
    var tufuh_num: Int = 0
    
    private var tufuh_noNetV: UIView?
    private var tufuh_refrV: TUOKOUXIUSSPullDRefV?
    private var tufuh_dataTreArr: [[String: Any]] = []
    private var tufuh_toTopBtn: UIButton?
    
    var refrV: TUOKOUXIUSSPullDRefV {
        if tufuh_refrV == nil {
            tufuh_refrV = TUOKOUXIUSSPullDRefV(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 50))
        }
        return tufuh_refrV!
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func tukou_testNet() {
        if (TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0) {
            tukou_creTabV()
        } else {
            tukou_noNetwV()
        }
    }
    
    func tukou_creTabV() {
        if let noNetV = tufuh_noNetV {
            noNetV.removeFromSuperview()
            tufuh_noNetV = nil
        }

        tukou_loadData()

        view.addSubview(tufuh_tabV)

        let topOffset: CGFloat = TUOKOUXIUSSApp.tukou_isPad() ? 60 : 104
        let height = TUOKOUXIUSwiftSCRE_H - TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight - TUOKOUXIUDeviceInfo.tukou_tabBarHeight - topOffset
        tufuh_tabV.frame = CGRect(x: 0,
                                  y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + topOffset,
                                  width: TUOKOUXIUSwiftSCRE_W,
                                  height: height)
        refrV.fuhan_setup(owner: tufuh_tabV, delegate: self)
        tufuh_tabV.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUHHHTbVVDefCelId")
        tufuh_tabV.register(TUOKOUXIUSwiftHHHTabVCell.self, forCellReuseIdentifier: "TUOKOUXIUHHHTbVVCelId")
    }
    
    func tukou_stoo() {
        tufuh_refrV?.fuhan_stoLoadi()
        
        if #available(iOS 15.0, *) {

        } else {
            if tufuh_tabV.contentOffset.y == 0 {
                tufuh_tabV.contentInset = UIEdgeInsets(top: -34, left: 0, bottom: 0, right: 0)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tufuh_refrV?.scrollViewDidScroll(scrollView)
        
        guard scrollView == tufuh_tabV else { return }
        let offsetY = scrollView.contentOffset.y
        
        if offsetY >= (TUOKOUXIUSwiftSCRE_H / 2), !tufuh_dataTreArr.isEmpty {
            if tufuh_toTopBtn == nil {
                tukou_shoTopBtn()
            }
        } else {
            if tufuh_toTopBtn != nil {
                tukou_hidTopBt()
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        tufuh_refrV?.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tufuh_refrV?.scrollViewWillBeginDragging(scrollView)
    }

    func tukou_shoTopBtn() {
        guard let superView = self.view else { return }
        let button = UIButton.tukou_bjBtn(
            CGRect(x: TUOKOUXIUSwiftSCRE_W - 40 - 20,
                   y: TUOKOUXIUSwiftSCRE_H - TUOKOUXIUDeviceInfo.tukou_tabBarHeight - 60,
                   width: 40,
                   height: 40),
            target: self,
            image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_totop", andIsOne: false),
            superView: superView,
            action: #selector(tukou_toTop)
        )
        tufuh_toTopBtn = button
    }

    @objc func tukou_toTop() {
        tufuh_tabV.setContentOffset(.zero, animated: true)
    }

    func tukou_hidTopBt() {
        if (tufuh_toTopBtn != nil) {
            tufuh_toTopBtn!.removeFromSuperview()
            tufuh_toTopBtn = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tufuh_dataTreArr = []
        self.view.backgroundColor = TUOKOUXIUSwiftheiseC
        
        if TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() == 0 {
            tukou_noNetwV()
            return
        }
        
        tukou_creTabV()
    }
    
    func tukou_loadData() {
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jzGFV(TUOKOUXIUSwiftKeyWinRoV)
        let tufuh_arr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_routesArr
        guard tufuh_arr.count >= 2 else {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }
        
        let tufuh_url: String
        if let dict = tufuh_arr[1] as? [String: Any],
           let cd = dict["cd"] as? String {
            tufuh_url = cd
        } else {
            tufuh_url = ""
        }
        let tufuh_ba64Str = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_shuJJM([
            "cd": tufuh_url,
            "ps": [["kv": self.tufuh_kvd ?? ""]]
        ])
        
        guard !TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_ba64Str) else {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }
        
        
        TUOKOUXIUSwiftWWWL.tukou_shared.tukou_requWithURL(TUOKOUXIUSwiftConst.TUOKOUXIUjkzx,
                                                           pars: [tufuh_ba64Str]) { dataDict, isSuccess in
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            
            if isSuccess {
                if let dataStr = dataDict as? String {
                    self.tukou_checkCode(dataStr) { isSuccess2 in
                        if isSuccess2 {
                            self.tukou_loadData()
                        }
                    }
                    return
                }
                
                guard let dataDict = dataDict as? [String: Any],
                      let resArr = dataDict["mainList"] as? [[String: Any]] else {
                    TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
                    return
                }
                

                
                if resArr.isEmpty {

                    TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
                    return
                }
                
                self.tufuh_dataTreArr.removeAll()

                self.tufuh_dataTreArr = resArr
                self.tufuh_tabV.reloadData()
                
            }
        }
    }

    func tukou_noNetwV() {
        tufuh_tabV.removeFromSuperview()
        tufuh_tabV.delegate = nil
        tufuh_tabV.dataSource = nil

        if (tufuh_refrV != nil) {
            tufuh_refrV!.removeFromSuperview()
            tufuh_refrV = nil
        }
        
        if self.tufuh_noNetV != nil { return }
        
        let height = TUOKOUXIUSwiftSCRE_H - (TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60) - TUOKOUXIUDeviceInfo.tukou_tabBarHeight
        self.tufuh_noNetV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: height),
                                                superView: self.view,
                                                bgColor: TUOKOUXIUSwiftheiseC)
        
        let label1 = UILabel.tukou_bjLabel(CGRect(x: 0, y: height / 2 - 12, width: TUOKOUXIUSwiftSCRE_W, height: 20),
                                            text: "The current network status is abnormal,",
                                           superView: self.tufuh_noNetV!,
                                            textAlignment: .center,
                                            font: TUOKOUXIUSwiftFont.medium(16),
                                            textColor: TUOKOUXIUSwiftbaiseC)
        
        let label2 = UILabel.tukou_bjLabel(CGRect(x: 0, y: label1.frame.maxY + 6, width: TUOKOUXIUSwiftSCRE_W, height: 20),
                                            text: "please try again later.",
                                           superView: self.tufuh_noNetV!,
                                            textAlignment: .center,
                                            font: TUOKOUXIUSwiftFont.medium(16),
                                            textColor: TUOKOUXIUSwiftbaiseC)
        
        UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W / 2 - 90 / 2, y: label2.frame.maxY + 24, width: 90, height: 36),
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
    
    private lazy var tufuh_tabV: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            if tableView.contentOffset.y == 0 {
                tableView.contentInset = UIEdgeInsets(top: -34, left: 0, bottom: 0, right: 0)
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = TUOKOUXIUSwiftheiseC
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01)

        return tableView
    }()

    func tukou_currVC() -> UIViewController? {
        var nextView: UIView? = self.view.superview
        while let view = nextView {
            if let responder = view.next, responder is UIViewController {
                return responder as? UIViewController
            }
            nextView = view.superview
        }
        return nil
    }
}

extension TUOKOUXIUHHHSwiftSubDepVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tufuh_dataTreArr.isEmpty ? 0 : self.tufuh_dataTreArr.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tufuh_dataTreArr.isEmpty ? 0 : 160 * TUOKOUXIUDeviceInfo.scaleX + 40
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard !self.tufuh_dataTreArr.isEmpty else { return 0 }
        return section == 0 ? 42 : 32
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !self.tufuh_dataTreArr.isEmpty else { return UIView() }

        let headerView = TUOKOUXIUSwiftTabHeadV()
        headerView.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: section == 0 ? 42 : 32)
        headerView.backgroundColor = TUOKOUXIUSwiftheiseC
        let sectionDict = self.tufuh_dataTreArr[section]
        let moduleName = sectionDict["module"] as? String ?? ""
        
        headerView.tufuh_secN = section

        headerView.didSelectBlock = { [weak self] sectionNum in
            guard let self = self else { return }
            let sectionDict = self.tufuh_dataTreArr[sectionNum]
            guard let allTypeArr = sectionDict["data"] as? [[String: Any]], !allTypeArr.isEmpty else {
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
                return
            }

            let targetVC = TUOKOUXIUSwiftHHHTypeAllVC()
            targetVC.tukou_resTAllDat(sectionDict)
            self.tukou_currVC()?.navigationController?.pushViewController(targetVC, animated: true)
        }

        if !moduleName.isEmpty {
            let iconIV = UIImageView(frame: CGRect(x: 10, y: 0, width: 24, height: 24))
            headerView.addSubview(iconIV)
            if let urlStr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_ic_hh_titPl, let url = URL(string: urlStr) {
                iconIV.kf.setImage(with: url, options: [.transition(.fade(0.3))])
            }

            UILabel.tukou_bjLabel(CGRect(x: 40, y: 0, width: TUOKOUXIUSwiftSCRE_W - 10 - 30 - 60 - 10, height: 24),
                                  text: moduleName,
                                  superView: headerView,
                                  textAlignment: .left,
                                  font: TUOKOUXIUSwiftFont.medium(16),
                                  textColor: TUOKOUXIUSwiftbaiseC)

            UILabel.tukou_bjLabel(CGRect(x: TUOKOUXIUSwiftSCRE_W - 12 - 60, y: 0, width: 60, height: 24),
                                  text: "See All",
                                  superView: headerView,
                                  textAlignment: .right,
                                  font: TUOKOUXIUSwiftFont.medium(14),
                                  textColor: TUOKOUXIUSwiftZTClr3A)
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 13
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 13))
        footerView.backgroundColor = TUOKOUXIUSwiftheiseC
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.tufuh_dataTreArr.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUHHHTbVVDefCelId", for: indexPath)
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUHHHTbVVCelId", for: indexPath) as? TUOKOUXIUSwiftHHHTabVCell else {
            return UITableViewCell()
        }

        cell.tufuh_isZhanShiAd = false
        cell.backgroundColor = TUOKOUXIUSwiftheiseC
        cell.tufuh_isHis = false

        let sectionData = tufuh_dataTreArr[indexPath.section]
        let dataArr = sectionData["data"] as? [Any] ?? []
        cell.tukou_resData(dataArr)

        cell.tufuh_clkItemBlk = { model in

        }

        return cell
    }
}

extension TUOKOUXIUHHHSwiftSubDepVC: TUOKOUXIUSSPullDRefVDelegate {
    func tukou_pullDRefDidFin() {
        if !tufuh_dataTreArr.isEmpty {
            let tableView = tufuh_tabV
            for case let cell as TUOKOUXIUSwiftHHHTabVCell in tableView.visibleCells {
                if let indexPath = tableView.indexPath(for: cell), indexPath.section > 0 {
                    cell.tufuh_collcV.setContentOffset(.zero, animated: false)
                }
            }
        }

        tukou_testNet()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tukou_stoo()
        }
    }
}
