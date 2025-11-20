
import UIKit
import Foundation
import Kingfisher

class TUOKOUXIUSwiftSSZVC: TUOKOUXIUSwiftBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    private var tufuh_setV: UIView?
    
    lazy var tufuh_tabV: UITableView = {
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
        
        tableView.backgroundColor = TUOKOUXIUSwiftheiseC
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
        
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TUOKOUXIUSwiftHHHTabVCell.self, forCellReuseIdentifier: "TUOKOUXIUMeTbVVCelId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUMeTbVDefCelId")
        
        return tableView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        let tufuh_aniEna = UIView.areAnimationsEnabled
        UIView.setAnimationsEnabled(false)
        tufuh_tabV.reloadData()
        UIView.setAnimationsEnabled(tufuh_aniEna)
        
    }
    
    @objc func tukou_xianShSetV() {
        if tufuh_setV == nil {
            let tufuh_yy = tufuh_tabV.contentOffset.y
            tufuh_setV = UIView.tukou_bjView(
                CGRect(x: TUOKOUXIUSwiftSCRE_W - 24,
                       y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 22 - tufuh_yy,
                       width: 1,
                       height: 1),
                superView: self.view,
                bgColor: UIColor(red: 84/255.0, green: 84/255.0, blue: 84/255.0, alpha: 1.0)
            )
            tufuh_setV?.layer.cornerRadius = 8
            tufuh_setV?.clipsToBounds = true
            
            let tufuh_v1 = UIView.tukou_bjView(
                CGRect(x: 0, y: 0, width: 240, height: 44),
                superView: tufuh_setV!,
                bgColor: TUOKOUXIUSwiftwuseC
            )

            tufuh_v1.tukou_addTapGesture(target: self, action: #selector(tukou_clickV1))
            UILabel.tukou_bjLabel(CGRect(x: 0, y: 0, width: 180, height: 44),
                                  text: "   Privacy Policy",
                                  superView: tufuh_v1,
                                  textAlignment: .left,
                                  font: TUOKOUXIUSwiftFont.medium(16),
                                  textColor: TUOKOUXIUSwiftbaiseC)
            UIImageView.tukou_bjImageV(CGRect(x: 206, y: 9, width: 24, height: 24),
                                       superView: tufuh_v1,
                                       image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_pp", andIsOne: false))
            UIView.tukou_bjView(CGRect(x: 0, y: 43, width: 240, height: 1),
                                superView: tufuh_v1,
                                bgColor: TUOKOUXIUSwiftZTClr5)
            
            let tufuh_v2 = UIView.tukou_bjView(CGRect(x: 0, y: 44, width: 240, height: 44),
                                               superView: tufuh_setV!,
                                               bgColor: TUOKOUXIUSwiftwuseC)
            
            tufuh_v2.tukou_addTapGesture(target: self, action: #selector(tukou_clickV2))
            UILabel.tukou_bjLabel(CGRect(x: 0, y: 0, width: 180, height: 44),
                                  text: "   Terms of Service",
                                  superView: tufuh_v2,
                                  textAlignment: .left,
                                  font: TUOKOUXIUSwiftFont.medium(16),
                                  textColor: TUOKOUXIUSwiftbaiseC)
            UIImageView.tukou_bjImageV(CGRect(x: 206, y: 9, width: 24, height: 24),
                                       superView: tufuh_v2,
                                       image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_ts", andIsOne: false))
            UIView.tukou_bjView(CGRect(x: 0, y: 43, width: 240, height: 1),
                                superView: tufuh_v2,
                                bgColor: TUOKOUXIUSwiftZTClr5)
            
            let tufuh_v3 = UIView.tukou_bjView(CGRect(x: 0, y: 88, width: 240, height: 44),
                                               superView: tufuh_setV!,
                                               bgColor: TUOKOUXIUSwiftwuseC)
            
            tufuh_v3.tukou_addTapGesture(target: self, action: #selector(tukou_clickV3))
            UILabel.tukou_bjLabel(CGRect(x: 0, y: 0, width: 160, height: 44),
                                  text: "   Feedback",
                                  superView: tufuh_v3,
                                  textAlignment: .left,
                                  font: TUOKOUXIUSwiftFont.medium(16),
                                  textColor: TUOKOUXIUSwiftbaiseC)
            UIImageView.tukou_bjImageV(CGRect(x: 206, y: 9, width: 24, height: 24),
                                       superView: tufuh_v3,
                                       image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_fb", andIsOne: false))
            UIView.tukou_bjView(CGRect(x: 0, y: 43, width: 240, height: 1),
                                superView: tufuh_v3,
                                bgColor: TUOKOUXIUSwiftZTClr5)
            
            let tufuh_v4 = UIView.tukou_bjView(CGRect(x: 0, y: 132, width: 240, height: 44),
                                               superView: tufuh_setV!,
                                               bgColor: TUOKOUXIUSwiftwuseC)
            
            tufuh_v4.tukou_addTapGesture(target: self, action: #selector(tukou_clickV4))
            UILabel.tukou_bjLabel(CGRect(x: 0, y: 0, width: 160, height: 44),
                                  text: "   Share",
                                  superView: tufuh_v4,
                                  textAlignment: .left,
                                  font: TUOKOUXIUSwiftFont.medium(16),
                                  textColor: TUOKOUXIUSwiftbaiseC)
            UIImageView.tukou_bjImageV(CGRect(x: 206, y: 9, width: 24, height: 24),
                                       superView: tufuh_v4,
                                       image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_fx", andIsOne: false))
            UIView.tukou_bjView(CGRect(x: 0, y: 43, width: 240, height: 1),
                                superView: tufuh_v4,
                                bgColor: TUOKOUXIUSwiftZTClr5)
            
            let tufuh_v5 = UIView.tukou_bjView(CGRect(x: 0, y: 176, width: 240, height: 44),
                                               superView: tufuh_setV!,
                                               bgColor: TUOKOUXIUSwiftwuseC)
            UILabel.tukou_bjLabel(CGRect(x: 0, y: 0, width: 160, height: 44),
                                  text: "   About",
                                  superView: tufuh_v5,
                                  textAlignment: .left,
                                  font: TUOKOUXIUSwiftFont.medium(16),
                                  textColor: TUOKOUXIUSwiftbaiseC)
            
            let tufuh_ver = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
            let tufuh_abStr = "v\(tufuh_ver)"
            UILabel.tukou_bjLabel(CGRect(x: 170, y: 0, width: 60, height: 44),
                                  text: tufuh_abStr,
                                  superView: tufuh_v5,
                                  textAlignment: .right,
                                  font: TUOKOUXIUSwiftFont.regular(14),
                                  textColor: TUOKOUXIUSwiftZTClr3A)
            
            UIView.animate(withDuration: 0.25) {
                self.tufuh_setV?.frame = CGRect(x: TUOKOUXIUSwiftSCRE_W - 240 - 12,
                                                y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 44 - tufuh_yy,
                                                width: 240,
                                                height: 220)
            }
        } else {
            self.tukou_guanbiSetV()
        }
    }
    @objc func tukou_guanbiSetV() {
        if let setV = tufuh_setV {
            let tufuh_yy = tufuh_tabV.contentOffset.y
            UIView.animate(withDuration: 0.25) {
                setV.frame = CGRect(
                    x: TUOKOUXIUSwiftSCRE_W - 24,
                    y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 22 - tufuh_yy,
                    width: 1,
                    height: 1
                )
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                setV.removeFromSuperview()
                self.tufuh_setV = nil
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tukou_guanbiSetV()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShoTabb"), object: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = TUOKOUXIUSwiftheiseC
        tufuh_tabV.frame = CGRect(
            x: 0,
            y: 0,
            width: TUOKOUXIUSwiftSCRE_W,
            height: TUOKOUXIUSwiftSCRE_H - TUOKOUXIUDeviceInfo.tukou_tabBarHeight
        )

        view.addSubview(tufuh_tabV)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tukou_guanbiSetV()
    }
    @objc func tukou_clickV4() {
        tukou_guanbiSetV()
        
        let tufuh_name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
        let tufuh_urlStr = "\(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[32])://apps.apple.com/app/\(tufuh_name)/id\(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftAppId)"
        guard let tufuh_url = URL(string: tufuh_urlStr) else { return }
        
        guard let tufuh_image = UIImage(named: "icon_tukou_logo") else { return }
        
        let tufuh_actArr: [Any] = [tufuh_image, tufuh_url, tufuh_name]
        let tufuh_actVC = UIActivityViewController(activityItems: tufuh_actArr, applicationActivities: nil)
        
        tufuh_actVC.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
            if completed {
                TUOKOUXIUSwiftKeyWindow()!.makeToast("Share Success!", duration: 2.0, position: .center)
            } else {
                TUOKOUXIUSwiftKeyWindow()!.makeToast("Share Cancel!", duration: 2.0, position: .center)
            }
        }
        present(tufuh_actVC, animated: true, completion: nil)
    }
    @objc func tukou_clickV1() {
        tukou_guanbiSetV()
        
        var tufuh_ppD: [String: Any]?
        var tufuh_k: String?
        
        if let tufuh_arr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_staSArr as? [[String: Any]] {
            for tufuh_d in tufuh_arr {
                if let tufuh_currK = tufuh_d["key"] as? String, tufuh_currK == "Privacy Policy" {
                    tufuh_ppD = tufuh_d
                    tufuh_k = tufuh_currK
                    break
                }
            }
        }
        
        guard let tufuh_ppD = tufuh_ppD,
              let tufuh_k = tufuh_k,
              !TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_k) else {
            return
        }
        
        guard let tufuh_PP = tufuh_ppD["value"] as? String,
              !TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_PP) else {
            return
        }
        
        let tufuh_tarVC = TUOKOUXIUSSWWAVC()
        tufuh_tarVC.tufuh_titS = tufuh_k
        tufuh_tarVC.tufuh_conS = tufuh_PP
        navigationController?.pushViewController(tufuh_tarVC, animated: true)
    }
    @objc func tukou_clickV2() {
        tukou_guanbiSetV()
        
        var tufuh_tsD: [String: Any]?
        var tufuh_k: String?
        
        if let tufuh_arr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_staSArr as? [[String: Any]] {
            for tufuh_d in tufuh_arr {
                if let tufuh_currK = tufuh_d["key"] as? String, tufuh_currK == "Terms of Service" {
                    tufuh_tsD = tufuh_d
                    tufuh_k = tufuh_currK
                    break
                }
            }
        }
        
        guard let tufuh_tsD = tufuh_tsD,
              let tufuh_k = tufuh_k,
              !TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_k) else {
            return
        }
        
        guard let tufuh_TS = tufuh_tsD["value"] as? String,
              !TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_TS) else {
            return
        }
        
        let tufuh_tarVC = TUOKOUXIUSSWWAVC()
        tufuh_tarVC.tufuh_titS = tufuh_k
        tufuh_tarVC.tufuh_conS = tufuh_TS
        navigationController?.pushViewController(tufuh_tarVC, animated: true)
    }
    
    @objc func tukou_clickV3() {
        tukou_guanbiSetV()
        let tufuh_tarVC = TUOKOUXIUSSFKVC()
        navigationController?.pushViewController(tufuh_tarVC, animated: true)
    }

    @objc func tukou_gotoheadImgaeV() {
        let tufuh_tarVC = TUOKOUXIUSSMMCVC()
        navigationController?.pushViewController(tufuh_tarVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 0.01
        } else if indexPath.section == 1 {
            if let tufuh_hisArr = (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr)) {
                if tufuh_hisArr.count == 0 {
                    return 0.01
                }
                return 160 * TUOKOUXIUDeviceInfo.scaleX + 40
            } else {
                return 0.01
            }
        } else {
            if let tufuh_myArr = (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftMYLISTArr)) {
                if tufuh_myArr.count == 0 {
                    return 0.01
                }
                return 160 * TUOKOUXIUDeviceInfo.scaleX + 40
            } else {
                return 0.01
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            if TUOKOUXIUSSApp.tukou_isPad() {
                return TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 215 + 30
            }
            return TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 215
        } else if section == 1 {
            if let tufuh_hisArr = (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr)) {
                if tufuh_hisArr.count == 0 {
                    return 0.01
                }
                return 32
            } else {
                return 0.01
            }
        } else {
            if let tufuh_myArr = (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftMYLISTArr)) {
                if tufuh_myArr.count == 0 {
                    return 0.01
                }
                return 32
            } else {
                return 0.01
            }
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            var tufuh_viewH: CGFloat = 0
            if TUOKOUXIUSSApp.tukou_isPad() {
                tufuh_viewH = 30
            }
            let tufuh_v = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: TUOKOUXIUSwiftSCRE_W,
                                               height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 215 + tufuh_viewH))
            tufuh_v.backgroundColor = TUOKOUXIUSwiftheiseC

            tufuh_v.tukou_addTapGesture(target: self, action: #selector(tukou_guanbiSetV))

            UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W - 37,
                                        y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 10,
                                        width: 24,
                                        height: 24),
                                 target: self,
                                 image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_image", andIsOne: false),
                                 superView: tufuh_v,
                                 action: #selector(tukou_xianShSetV))

            let tufuh_headV = UIView.tukou_bjView(CGRect(x: 0,
                                                         y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 44,
                                                         width: TUOKOUXIUSwiftSCRE_W,
                                                         height: 86),
                                                  superView: tufuh_v,
                                                  bgColor: TUOKOUXIUSwiftheiseC)
            tufuh_headV.tukou_addTapGesture(target: self, action: #selector(tukou_gotoheadImgaeV))

            UIImageView.tukou_bjImageV(CGRect(x: 18, y: 12, width: 58, height: 58),
                                       superView: tufuh_headV,
                                       image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_me", andIsOne: false))

            var tufuh_name = "Enter nickname"
            if let name = UserDefaults.standard.object(forKey: TUOKOUXIUSwiftConst.TUOKOUXIUSwiftYHMing) as? String {
                tufuh_name = name
            }
            UILabel.tukou_bjLabel(CGRect(x: 86, y: 12, width: 200, height: 58),
                                  text: tufuh_name,
                                  superView: tufuh_headV,
                                  textAlignment: .left,
                                  font: TUOKOUXIUSwiftFont.semibold(20),
                                  textColor: TUOKOUXIUSwiftbaiseC)

            UIImageView.tukou_bjImageV(CGRect(x: TUOKOUXIUSwiftSCRE_W - 37, y: 29, width: 24, height: 24),
                                       superView: tufuh_headV,
                                       image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_jin", andIsOne: false))

            return tufuh_v
        }

        if section == 1 {
            if let tufuh_hisArr = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr),
               !tufuh_hisArr.isEmpty {
                let tufuh_v = TUOKOUXIUSwiftTabHeadV(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 32))
                tufuh_v.backgroundColor = TUOKOUXIUSwiftheiseC
                let tufuh_titS = "Continue Watching"
                tufuh_v.tufuh_secN = 0
                tufuh_v.didSelectBlock = { [weak self] _ in
                    guard let self = self else { return }
                    let tufuh_tarVC = TUOKOUXIUSwiftHHHHisVC()
                    tufuh_tarVC.tufuh_isList = false
                    self.navigationController?.pushViewController(tufuh_tarVC, animated: true)
                }
                if !tufuh_titS.isEmpty {
                    let tufuh_iv = UIImageView(frame: CGRect(x: 10, y: 0, width: 24, height: 24))
                    tufuh_v.addSubview(tufuh_iv)
                    
                    tufuh_iv.kf.setImage(with: URL(string: TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_ic_hh_titPl!), options: [.transition(.fade(0.3))])
                    UILabel.tukou_bjLabel(CGRect(x: 40, y: 0, width: TUOKOUXIUSwiftSCRE_W - 110, height: 24),
                                          text: tufuh_titS,
                                          superView: tufuh_v,
                                          textAlignment: .left,
                                          font: TUOKOUXIUSwiftFont.medium(16),
                                          textColor: TUOKOUXIUSwiftbaiseC)
                    UILabel.tukou_bjLabel(CGRect(x: TUOKOUXIUSwiftSCRE_W - 72, y: 0, width: 60, height: 24),
                                          text: "See All",
                                          superView: tufuh_v,
                                          textAlignment: .right,
                                          font: TUOKOUXIUSwiftFont.medium(14),
                                          textColor: TUOKOUXIUSwiftZTClr3A)
                }
                return tufuh_v
            } else {
                let v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
                v.backgroundColor = TUOKOUXIUSwiftheiseC
                return v
            }
        }

        if let tufuh_myArr = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftMYLISTArr),
           !tufuh_myArr.isEmpty {
            let tufuh_v = TUOKOUXIUSwiftTabHeadV(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 32))
            tufuh_v.backgroundColor = TUOKOUXIUSwiftheiseC
            let tufuh_titS = "My List"
            tufuh_v.tufuh_secN = 0
            tufuh_v.didSelectBlock = { [weak self] _ in
                guard let self = self else { return }
                let tufuh_tarVC = TUOKOUXIUSwiftHHHHisVC()
                tufuh_tarVC.tufuh_isList = true
                self.navigationController?.pushViewController(tufuh_tarVC, animated: true)
            }
            if !tufuh_titS.isEmpty {
                let tufuh_iv = UIImageView(frame: CGRect(x: 10, y: 0, width: 24, height: 24))
                tufuh_v.addSubview(tufuh_iv)

                tufuh_iv.kf.setImage(with: URL(string: TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_ic_hh_titPl!), options: [.transition(.fade(0.3))])
                UILabel.tukou_bjLabel(CGRect(x: 40, y: 0, width: TUOKOUXIUSwiftSCRE_W - 110, height: 24),
                                      text: tufuh_titS,
                                      superView: tufuh_v,
                                      textAlignment: .left,
                                      font: TUOKOUXIUSwiftFont.medium(16),
                                      textColor: TUOKOUXIUSwiftbaiseC)
                UILabel.tukou_bjLabel(CGRect(x: TUOKOUXIUSwiftSCRE_W - 72, y: 0, width: 60, height: 24),
                                      text: "See All",
                                      superView: tufuh_v,
                                      textAlignment: .right,
                                      font: TUOKOUXIUSwiftFont.medium(14),
                                      textColor: TUOKOUXIUSwiftZTClr3A)
            }
            return tufuh_v
        } else {
            let v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
            v.backgroundColor = TUOKOUXIUSwiftheiseC
            return v
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            if let hisArr = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL
                .tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr) {
                if hisArr.count == 0 {
                    return 0.01
                }
                return 13
            } else {
                return 0.01
            }
        } else if section == 2 {
            if let myArr = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftMYLISTArr) {
                if myArr.count == 0 {
                    return 0.01
                }
                return 13
            } else {
                return 0.01
            }
        }
        return 13
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            if let hisArr = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr) {
                if hisArr.count == 0 {
                    let v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
                    v.backgroundColor = TUOKOUXIUSwiftheiseC
                    return v
                }
                let v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 13))
                v.backgroundColor = TUOKOUXIUSwiftheiseC
                return v
            } else {
                let v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
                v.backgroundColor = TUOKOUXIUSwiftheiseC
                return v
            }
        } else if section == 2 {
            if let myArr = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftMYLISTArr) {
                if myArr.count == 0 {
                    let v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
                    v.backgroundColor = TUOKOUXIUSwiftheiseC
                    return v
                }
                let v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 13))
                v.backgroundColor = TUOKOUXIUSwiftheiseC
                return v
            } else {
                let v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
                v.backgroundColor = TUOKOUXIUSwiftheiseC
                return v
            }
        }
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 13))
        v.backgroundColor = TUOKOUXIUSwiftheiseC
        return v
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUMeTbVDefCelId", for: indexPath)
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            return cell
        } else if indexPath.section == 1 {
            if let hisArr = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL
                .tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisArr) {
                
                if hisArr.isEmpty {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUMeTbVDefCelId", for: indexPath)
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                    return cell
                }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUMeTbVVCelId", for: indexPath) as! TUOKOUXIUSwiftHHHTabVCell
                cell.tufuh_isZhanShiAd = false
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                cell.tufuh_isHis = true
                cell.tukou_resData(hisArr)
                
                cell.tufuh_clkItemArrBlk = { model in

                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUMeTbVDefCelId", for: indexPath)
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                return cell
            }
        } else if indexPath.section == 2 {
            if let myArr = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL
                .tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftMYLISTArr) {
                
                if myArr.isEmpty {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUMeTbVDefCelId", for: indexPath)
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                    return cell
                }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUMeTbVVCelId", for: indexPath) as! TUOKOUXIUSwiftHHHTabVCell
                cell.tufuh_isZhanShiAd = false
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                cell.tufuh_isHis = true
                cell.tufuh_isAddList = true
                cell.tukou_resData(myArr)
                
                cell.tufuh_clkItemArrBlk = { model in

                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUMeTbVDefCelId", for: indexPath)
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUMeTbVDefCelId", for: indexPath)
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            return cell
        }
    }
    
}
