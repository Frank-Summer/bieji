
import Foundation
import UIKit
import Kingfisher
import Toast
import Combine

class TUOKOUXIUSwiftHHHVC: TUOKOUXIUSwiftBaseVC, TUOKOUXIUSwiftPagTitVDelegate, TUOKOUXIUSwiftPagContScrVDelegate, TUOKOUXIUSwiftCycPagVDataSource, TUOKOUXIUSwiftCycPagVDeleg {
    func tukou_pageContScrV(_ pageContentScrollView: TUOKOUXIUSwiftPagContScrV, index: Int) {
        
    }
    func pagerView(_ pageView: TUOKOUXIUSwiftCycPagV, didSelectedItemCell cell: UICollectionViewCell, atIndex: Int) {
        
    }


    var tufuh_timer: Timer?
    var tufuh_topV: UIView?
    var tufuh_topSearL: UILabel?
    var tufuh_hotTN: Int = 0
    var tufuh_noNetV: UIView?
    var tufuh_topSearIV: UIImageView?
    
    var tufuh_subDict: [String: Any]?
    var tufuh_loadProV: UIView?
    var tufuh_loadProLV: UIView?
    var tufuh_loadSubScrV: UIScrollView?
    var tufuh_loadTZV: UIView?
    var tufuh_isVpType: Int = 0

    var tufuh_souT: DispatchSourceTimer?
    var tufuh_timeN: Int = 0
    var tufuh_tabN: Int = 0
    var tufuh_subLBArr: [Any]?
    var tufuh_pagerV: TUOKOUXIUSwiftCycPagV?
    var tufuh_pageCon: TUOKOUXIUSwiftPageControl?
    var tufuh_isFirWil: Bool = false
    var tufuh_isTrial: Bool = false
    var tufuh_isHHHFCVpClick: Bool = false
    var tufuh_subPriStr: String?
    var tufuh_subTStr: String?
    private var cancellables = Set<AnyCancellable>()

    func fuhan_mainBar() -> UIViewController {
        var vc: UIViewController = self
        while let parent = vc.parent {
            vc = parent
        }
        return vc
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        if self.tufuh_isFirWil {
            NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUHHHWillAppear"), object: nil)
        }
        self.tufuh_isFirWil = true
    }
    
    func tukou_addPagV(_ IV: UIImageView) {
        var tufuh_pagerVY: CGFloat = 0
        if TUOKOUXIUSSApp.tukou_isPad() {
            tufuh_pagerVY = IV.frame.minY + 30 + 15
        } else {
            tufuh_pagerVY = IV.frame.minY + 15
        }
        let pagerV = TUOKOUXIUSwiftCycPagV()
        pagerV.frame = CGRect(x: TUOKOUXIUSwiftSCRE_W/2 - 149.5, y: tufuh_pagerVY, width: 299, height: 248)
        pagerV.dataSource = self
        pagerV.delegate = self
        pagerV.registerClass(TUOKOUXIUSwiftCycleDYCell.self, forCellWithReuseIdentifier: "TUOKOUXIUCycleDYCellId")
        
        self.tufuh_loadSubScrV?.addSubview(pagerV)
        self.tufuh_pagerV = pagerV
        
        let pageCon = TUOKOUXIUSwiftPageControl()
        pageCon.tufuh_currPagIndSi = CGSize(width: 6, height: 6)
        pageCon.tufuh_pagIndSi = CGSize(width: 12, height: 6)
        pageCon.tufuh_pagIndImg = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_cel_dia_n", andIsOne: false)
        pageCon.tufuh_currPagIndImg = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_cel_dia_s", andIsOne: false)
        pageCon.tufuh_pagIndSpa = 0
        pageCon.tufuh_numbOfPag = self.tufuh_subLBArr!.count
        
        self.tufuh_loadSubScrV?.addSubview(pageCon)
        pageCon.frame = CGRect(x: TUOKOUXIUSwiftSCRE_W/2 - 20, y: pagerV.frame.maxY + 20, width: 40, height: 20)
        
        self.tufuh_pageCon = pageCon
        self.tufuh_pagerV?.reloadData()
    }
    
    func numberOfItemsInPagerView(_ pageView: TUOKOUXIUSwiftCycPagV) -> Int {
        return self.tufuh_subLBArr!.count
    }
    
    func pagerView(_ pagerView: TUOKOUXIUSwiftCycPagV, cellForItemAtIndex index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUCycleDYCellId", forIndex: index) as! TUOKOUXIUSwiftCycleDYCell
        cell.tukou_resData(self.tufuh_subLBArr![index] as! String)
        return cell
    }
    
    func layoutForPagerView(_ pageView: TUOKOUXIUSwiftCycPagV) -> TUOKOUXIUSwiftCycPagVLayout {
        let layout = TUOKOUXIUSwiftCycPagVLayout()
        layout.itemSize = CGSize(width: pageView.frame.width, height: pageView.frame.height)
        layout.tufuh_itemSpac = 0
        layout.tufuh_itemHorCen = true
        return layout
    }
    
    func pagerView(_ pageView: TUOKOUXIUSwiftCycPagV, didScrollFromIndex fromIndex: Int, toIndex: Int) {
        self.tufuh_pageCon!.tufuh_currPag = toIndex
    }


    func tukou_gotoBFV(_ notify: Notification) {
        

    }

    @objc func tukou_clickClosedTZV() {
        if let loadTZV = self.tufuh_loadTZV {
            loadTZV.removeFromSuperview()
            self.tufuh_loadTZV = nil
        }
    }

    func fuhan_creaDispT() {
        self.tufuh_timeN = 0
        let queue = DispatchQueue.global(qos: .default)
        
        self.tufuh_souT = DispatchSource.makeTimerSource(queue: queue)
        let delayTime: TimeInterval = 1.0
        let interval: TimeInterval = 1.0
        self.tufuh_souT?.schedule(deadline: .now() + delayTime, repeating: interval, leeway: .milliseconds(100))
        
        self.tufuh_souT?.setEventHandler { [weak self] in
            guard let self = self else { return }
            self.tufuh_timeN += 1
        }
        
        self.tufuh_souT?.resume()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.tukou_guanbiTime()
        
        if let souT = self.tufuh_souT {
            souT.cancel()
            self.tufuh_souT = nil
        }
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        
    }

    func tukou_appDidBecoAct() {
        if self.tufuh_loadSubScrV != nil || self.tufuh_subDict != nil {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShoTabb"), object: nil)
        
        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { [weak self] notif in self?.tukou_appDidBecoAct() }
            .store(in: &cancellables)

        self.tukou_qidongTime()

        self.tukou_entForegr()
        
        NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
            .sink { [weak self] notif in self?.tukou_entBackG() }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] notif in self?.tukou_entForegr() }
            .store(in: &cancellables)

    }

    private func tukou_entForegr() {
        self.tukou_qidongTime()
        if let souT = self.tufuh_souT {
            souT.cancel()
        }
        self.fuhan_creaDispT()
    }

    func tukou_entBackG() {
        self.tukou_guanbiTime()
        if let souT = self.tufuh_souT {
            souT.cancel()
        }
    }

    func tukou_topVBianSe(_ notify: Notification) {
        guard let tufuh_string = notify.object as? String else { return }

        if tufuh_string == "yes" {
            self.tufuh_topV!.backgroundColor = TUOKOUXIUSwiftheiseC
            self.tufuh_pageTitV.backgroundColor = TUOKOUXIUSwiftheiseC
        } else {
            self.tufuh_topV!.backgroundColor = TUOKOUXIUSwiftwuseC
            self.tufuh_pageTitV.backgroundColor = TUOKOUXIUSwiftwuseC
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tufuh_tabN = 0

        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUGotoBFV"))
            .sink { [weak self] notification in
                self?.tukou_gotoBFV(notification)
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUQiDongLabel"))
            .sink { [weak self] _ in self?.tukou_qidongTime()}
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUTopVBianSe"))
            .sink { [weak self] notification in self?.tukou_topVBianSe(notification) }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUHHHTopSearchIV"))
            .sink { [weak self] _ in self?.tukou_topSearchIV() }
            .store(in: &cancellables)
        
        self.view.backgroundColor = TUOKOUXIUSwiftheiseC
        
        if TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() == 0 {
            tukou_noNetwV()
            return
        }
        
        tukou_clickRefresh()
    }

    func tukou_topSearchIV() {
        if self.tufuh_topSearIV!.image == nil {
            self.tufuh_topSearIV!.image = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_sea_top", andIsOne: false)
        }
    }
    
    func tukou_clickRefresh() {
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jzGFV(TUOKOUXIUSwiftKeyWinRoV)
        tukou_reqTK()
        
        self.tufuh_block = { [weak self] isSuccess in
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            guard let self = self else { return }
            if isSuccess {
                self.tukou_clickRefresh2()
            }
        }
    }

    @objc func tukou_clickRefresh2() {
        if TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() == 0 { return }
        
        if let noNetV = self.tufuh_noNetV {
            noNetV.removeFromSuperview()
            self.tufuh_noNetV = nil
        }
        
        tukou_guanbiTime()
        
        if let topSearL = self.tufuh_topSearL {
            topSearL.removeFromSuperview()
            self.tufuh_topSearL = nil
        }
        
        if let topV = self.tufuh_topV {
            topV.removeFromSuperview()
            self.tufuh_topV = nil
        }
        
        tufuh_pageTitV.removeFromSuperview()
        tufuh_pageContScrV.removeFromSuperview()

        self.view.addSubview(self.tufuh_pageContScrV)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tufuh_topV?.addSubview(self.tufuh_pageTitV)
        }
        
        tukou_topVi()
    }

    lazy var tufuh_pageTitV: TUOKOUXIUSwiftPagTitV = {
        let tufuh_titArr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_hhTabsArr
        var tufuh_arr: [String] = []
        for item in tufuh_titArr {
            if let dict = item as? [String: Any], let name = dict["name"] as? String {
                tufuh_arr.append(name)
            }
        }
        
        let tufuh_conf = TUOKOUXIUSwiftPagTitVConf.tukou_pageTitVCon()
//        tufuh_conf.tufuh_titGradiEffe = true
        tufuh_conf.tufuh_titClr = TUOKOUXIUSwiftZTClr2A
        tufuh_conf.tufuh_titSeleClr = TUOKOUXIUSwiftbaiseC
        tufuh_conf.tufuh_indicClr = TUOKOUXIUSwiftwuseC
        tufuh_conf.tufuh_indicHei = 0.1
        tufuh_conf.tufuh_indicToBotDist = 0
        tufuh_conf.tufuh_indiCorRadi = 0
        tufuh_conf.tufuh_indiFixW = 40.0
        tufuh_conf.tufuh_indicaSty = .dyn
        tufuh_conf.tufuh_titTexZoo = true
        tufuh_conf.tufuh_shoBotSeparator = true
        tufuh_conf.tufuh_botSeparClr = TUOKOUXIUSwiftwuseC
        
        let pageTitV: TUOKOUXIUSwiftPagTitV
        if TUOKOUXIUSSApp.tukou_isPad() {
            tufuh_conf.tufuh_titFont = TUOKOUXIUSwiftFont.medium(15)
            tufuh_conf.tufuh_titSeleFon = TUOKOUXIUSwiftFont.semibold(19)
            pageTitV = TUOKOUXIUSwiftPagTitV.tukou_pageTitVWithFra(frame:
                CGRect(x: 15, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 8, width: 250, height: 44),
                delegate: self,
                titleNames: tufuh_arr,
                configure: tufuh_conf
            )
        } else {
            tufuh_conf.tufuh_titFont = TUOKOUXIUSwiftFont.medium(15)
            tufuh_conf.tufuh_titSeleFon = TUOKOUXIUSwiftFont.semibold(19)
            pageTitV = TUOKOUXIUSwiftPagTitV.tukou_pageTitVWithFra(frame:
                CGRect(x: 15, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60, width: TUOKOUXIUSwiftSCRE_W - 25, height: 44),
                delegate: self,
                titleNames: tufuh_arr,
                configure: tufuh_conf
            )
        }
        
        pageTitV.backgroundColor = TUOKOUXIUSwiftwuseC
        return pageTitV
    }()
    
    lazy var tufuh_pageContScrV: TUOKOUXIUSwiftPagContScrV = {
        var childVCs: [UIViewController] = []
        let tabsArr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_hhTabsArr

        for (i, item) in tabsArr.enumerated() {
            if i == 0 {
                let v1 = TUOKOUXIUSwiftHHHHSubVC()
                childVCs.append(v1)
            } else {
                let v2 = TUOKOUXIUHHHSwiftSubDepVC()
                v2.tufuh_num = i
                if let dict = item as? [String: Any], let key = dict["key"] {
                    v2.tufuh_kvd = "\(key)"
                } else {
                    v2.tufuh_kvd = ""
                }
                childVCs.append(v2)
            }
        }

        let pageContScrV = TUOKOUXIUSwiftPagContScrV(
            frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H - TUOKOUXIUDeviceInfo.tukou_tabBarHeight),
            parentVC: self,
            childVCs: childVCs
        )
        pageContScrV.tufuh_pageContScrVDele = self
        return pageContScrV
    }()

    func tukou_pageTitV(_ pageTitleView: TUOKOUXIUSwiftPagTitV, selectedIndex: Int) {
        self.tufuh_tabN = selectedIndex
        self.tufuh_pageContScrV.tukou_pageContScrVCurrInd(selectedIndex)
    }

    func tukou_pageContScrV(_ pageContentScrollView: TUOKOUXIUSwiftPagContScrV, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.tufuh_tabN = targetIndex
        self.tufuh_pageTitV.tukou_pageTitVWithPro(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }

    func tukou_topVi() {
        var topHeight: CGFloat = 44
        if TUOKOUXIUSSApp.tukou_isPad() {
            topHeight = 0
        }
        
        self.tufuh_topV = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60 + topHeight))
        self.tufuh_topV!.backgroundColor = TUOKOUXIUSwiftwuseC
        self.view.addSubview(self.tufuh_topV!)
        
        let searchV: UIView
        if TUOKOUXIUSSApp.tukou_isPad() {
            searchV = UIView.tukou_bjView(
                CGRect(x: 255 + 12, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 10, width: TUOKOUXIUSwiftSCRE_W - 12 - 56 - 255, height: 40),
                superView: self.tufuh_topV!,
                bgColor: TUOKOUXIUSwiftZTClr5A,
                cornerRadius: 20,
                borderWidth: 1,
                borderColor: TUOKOUXIUSwiftZTClr
            )
        } else {
            searchV = UIView.tukou_bjView(
                CGRect(x: 12, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 10, width: TUOKOUXIUSwiftSCRE_W - 12 - 56, height: 40),
                superView: self.tufuh_topV!,
                bgColor: TUOKOUXIUSwiftZTClr5A,
                cornerRadius: 20,
                borderWidth: 1,
                borderColor: TUOKOUXIUSwiftZTClr
            )
        }
        
        self.tufuh_topSearL = UILabel.tukou_bjLabel(
            CGRect(x: 20, y: 0, width: TUOKOUXIUSwiftSCRE_W - 32 - 110, height: 40),
            text: "Search \(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[36]) & \(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[37])",
            superView: searchV,
            textAlignment: .left,
            font: TUOKOUXIUSwiftFont.regular(12),
            textColor: TUOKOUXIUSwiftZTClr1A
        )
        
        let searchBtnFrame = TUOKOUXIUSSApp.tukou_isPad() ?
            CGRect(x: TUOKOUXIUSwiftSCRE_W - 12 - 56 - 54 - 255, y: 0, width: 54, height: 40) :
            CGRect(x: TUOKOUXIUSwiftSCRE_W - 12 - 56 - 54, y: 0, width: 54, height: 40)
        
        let searchBtn = UIView.tukou_bjView(searchBtnFrame, superView: searchV, bgColor: TUOKOUXIUSwiftwuseC)
        
        searchBtn.tukou_addTapGesture(target: self, action: #selector(tukou_goToSearSS))
        
        self.tufuh_topSearIV = UIImageView.tukou_bjImageV(
            CGRect(x: 14, y: 8, width: 24, height: 24),
            superView: searchBtn,
            image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_sea_top", andIsOne: false)
        )
        
        searchV.tukou_addTapGesture(target: self, action: #selector(tukou_goToSearch))
        

    }

    func tukou_qidongTime() {
        tukou_guanbiTime()
        guard TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_hotArr.count > 0 else { return }
        
        tufuh_timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(tukou_timFir), userInfo: nil, repeats: true)
        RunLoop.main.add(tufuh_timer!, forMode: .common)
    }

    func tukou_guanbiTime() {
        tufuh_timer?.invalidate()
        tufuh_timer = nil
    }
    
    @objc func tukou_timFir() {
        guard TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_hotArr.count > 0 else { return }

        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_hotArr.count <= self.tufuh_hotTN {
            self.tufuh_hotTN = 0
        }

        self.tufuh_topSearL!.frame = CGRect(x: 20, y: 30, width: TUOKOUXIUSwiftSCRE_W - 142, height: 10)
        self.tufuh_topSearL!.text = ""

        UIView.animate(withDuration: 0.25, animations: {
            self.tufuh_topSearL!.frame = CGRect(x: 20, y: 0, width: TUOKOUXIUSwiftSCRE_W - 142, height: 40)
            self.tufuh_topSearL!.text = (TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_hotArr[self.tufuh_hotTN] as! String)
        }) { _ in
            self.tufuh_hotTN += 1
            if self.tufuh_hotTN >= TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_hotArr.count {
                self.tufuh_hotTN = 0
            }
        }
    }

    @objc func tukou_goToSearSS() {
        let targetVC = TUOKOUXIUSwiftSSSVC()
        targetVC.tufuh_gotoSS = true
        targetVC.tufuh_searchStr = self.tufuh_topSearL!.text ?? " "
        targetVC.tufuh_source = "2"
        targetVC.tufuh_isTS = true
        self.navigationController?.pushViewController(targetVC, animated: true)
    }

    func tukou_noNetwV() {
        guard self.tufuh_noNetV == nil else { return }

        let height = TUOKOUXIUSwiftSCRE_H - TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight - 56 - TUOKOUXIUDeviceInfo.tukou_tabBarHeight
        self.tufuh_noNetV = UIView.tukou_bjView(CGRect(x: 0, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60, width: TUOKOUXIUSwiftSCRE_W, height: height), superView: self.view, bgColor: TUOKOUXIUSwiftheiseC)

        let label1 = UILabel.tukou_bjLabel(CGRect(x: 0, y: height/2-12, width: TUOKOUXIUSwiftSCRE_W, height: 20),
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
        
        UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-45, y: label2.frame.maxY + 24, width: 90, height: 36),
                             target: self,
                             imageName: "",
                             superView: self.tufuh_noNetV!,
                             action: #selector(tukou_clickRefresh2),
                             font: TUOKOUXIUSwiftFont.semibold(14),
                             title: "Retry",
                             color: TUOKOUXIUSwiftbaiseC,
                             bgColor: TUOKOUXIUSwiftZTClr,
                             cornerRadius: 5)
    }

    @objc func tukou_goToSearch() {
        
        let targetVC = TUOKOUXIUSwiftSSSVC()
        targetVC.tufuh_source = "1"
        targetVC.tufuh_isHHH = true
        self.navigationController?.pushViewController(targetVC, animated: true)
    }

}
