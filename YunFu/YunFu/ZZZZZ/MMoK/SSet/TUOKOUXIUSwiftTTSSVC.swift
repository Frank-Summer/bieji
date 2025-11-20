
import UIKit
import Foundation
import ESPullToRefresh
import Toast
import Combine

class TUOKOUXIUSwiftTTSSVC: TUOKOUXIUSwiftBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TUOKOUXIUSSPullDRefVDelegate {
    
    var tufuh_topV: UIView?
    var tufuh_topSearL: UILabel?
    var tufuh_topTV: UIView?
    var tufuh_noNetV: UIView?
    var tufuh_toTopBtn: UIButton?
    var tufuh_dataTreArr: [[String: Any]] = []
    var tufuh_dataTDict: [String: Any] = [:]
    var tufuh_dataTDictOri: [String: Any] = [:]
    var tufuh_currPaN: Int = 0
    var tufuh_isRecover: Bool = false
    var tufuh_headV: TUOKOUXIUSwiftTTSSCollReusV?
    var tufuh_souT: DispatchSourceTimer?
    var tufuh_timeNum: Int = 0
    var tufuh_timer: Timer?
    var tufuh_hotTN: Int = 0
    var tufuh_toTopVpBtn: UIButton?
    var tufuh_isToD: Bool = false
    var tufuh_collcV: UICollectionView?
    private var cancellables = Set<AnyCancellable>()

    lazy var tufuh_refrV: TUOKOUXIUSSPullDRefV = {
        return TUOKOUXIUSSPullDRefV(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 50))
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        if !tufuh_dataTreArr.isEmpty {
            tufuh_isRecover = true
            let tufuh_aniEna = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            tufuh_collcV!.reloadData()
            UIView.setAnimationsEnabled(tufuh_aniEna)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tufuh_dataTreArr = []
        tufuh_dataTDict = [:]
        tufuh_dataTDictOri = [:]
        view.backgroundColor = TUOKOUXIUSwiftheiseC
        tukou_topVi()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let souT = tufuh_souT {
            souT.cancel()
        }
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShoTabb"), object: nil)
        if tufuh_toTopVpBtn?.image(for: .normal) == nil {
            let img = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_vp_b", andIsOne: false)
            tufuh_toTopVpBtn?.setImage(img, for: .normal)
        }
        
        tukou_qidongTime()

        tukou_entForegr()
        
        NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
            .sink { [weak self] _ in self?.tukou_entBackG() }
            .store(in: &cancellables)
        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in self?.tukou_entForegr() }
            .store(in: &cancellables)

        
        if !TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr.isEmpty {
            tufuh_currPaN = 1
            tukou_testNet()
        } else {
            tukou_noNetwV()
        }
    }
    
    func tukou_qidongTime() {
        tukou_guanbiTime()
        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_hotArr.count == 0 { return }
        tufuh_timer = Timer.scheduledTimer(timeInterval: 5.0,
                                           target: self,
                                           selector: #selector(tukou_timFir),
                                           userInfo: nil,
                                           repeats: true)
        RunLoop.main.add(tufuh_timer!, forMode: .common)
    }
    
    func tukou_guanbiTime() {
        if let timer = tufuh_timer {
            timer.invalidate()
            tufuh_timer = nil
        }
    }
    
    @objc func tukou_timFir() {
        let hotArr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_hotArr
        if hotArr.count == 0 { return }
        
        if hotArr.count > tufuh_hotTN {

        } else {
            tufuh_hotTN = 0
        }
        
        guard let topLabel = tufuh_topSearL else { return }
        topLabel.frame = CGRect(x: 20, y: 30, width: TUOKOUXIUSwiftSCRE_W - 142, height: 10)
        topLabel.text = ""
        
        UIView.animate(withDuration: 0.25, animations: {
            topLabel.frame = CGRect(x: 20, y: 0, width: TUOKOUXIUSwiftSCRE_W - 142, height: 40)
            topLabel.text = (hotArr[self.tufuh_hotTN] as! String)
        }, completion: { _ in
            self.tufuh_hotTN += 1
            if self.tufuh_hotTN >= hotArr.count {
                self.tufuh_hotTN = 0
            }
        })
    }
    
    func tukou_creDisSourT() {
        tufuh_timeNum = 0
        let queue = DispatchQueue.global(qos: .default)
        let timer = DispatchSource.makeTimerSource(queue: queue)
        let delayTime: TimeInterval = 1.0
        let timeInterval: TimeInterval = 1.0
        
        timer.schedule(deadline: .now() + delayTime,
                       repeating: timeInterval,
                       leeway: .milliseconds(100))
        
        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            self.tufuh_timeNum += 1
        }
        tufuh_souT = timer
        timer.resume()
    }
    
    private func tukou_entForegr() {
        tukou_qidongTime()
        
        if !tufuh_dataTreArr.isEmpty {
            tufuh_isRecover = true
            let tufuh_aniEna = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            tufuh_collcV!.reloadData()
            UIView.setAnimationsEnabled(tufuh_aniEna)
        }
        
        if let souT = tufuh_souT {
            souT.cancel()
        }
        tukou_creDisSourT()
    }
    
    func tukou_entBackG() {
        if let souT = tufuh_souT {
            souT.cancel()
        }
    }
    
    func tukou_topVi() {
        tufuh_topV = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: TUOKOUXIUSwiftSCRE_W,
                                          height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60))
        tufuh_topV?.backgroundColor = TUOKOUXIUSwiftwuseC
        view.addSubview(tufuh_topV!)

        let tufuh_searchV = UIView.tukou_bjView(CGRect(x: 12,
                                                       y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 10,
                                                       width: TUOKOUXIUSwiftSCRE_W - 68,
                                                       height: 40),
                                                superView: tufuh_topV!,
                                                bgColor: TUOKOUXIUSwiftZTClr5A,
                                                cornerRadius: 20,
                                                borderWidth: 1,
                                                borderColor: TUOKOUXIUSwiftZTClr)

        tufuh_topSearL = UILabel.tukou_bjLabel(CGRect(x: 20,
                                                      y: 0,
                                                      width: TUOKOUXIUSwiftSCRE_W - 142,
                                                      height: 40),
                                               text: "Search Movies & TVShows",
                                               superView: tufuh_searchV,
                                               textAlignment: .left,
                                               font: TUOKOUXIUSwiftFont.regular(12),
                                               textColor: TUOKOUXIUSwiftZTClr1A)

        let tufuh_searchBtn = UIView.tukou_bjView(CGRect(x: TUOKOUXIUSwiftSCRE_W - 122,
                                                         y: 0,
                                                         width: 54,
                                                         height: 40),
                                                  superView: tufuh_searchV,
                                                  bgColor: TUOKOUXIUSwiftwuseC)

        tufuh_searchBtn.tukou_addTapGesture(target: self, action: #selector(tukou_goToSearSS))

        UIImageView.tukou_bjImageV(CGRect(x: 14, y: 8, width: 24, height: 24),
                                   superView: tufuh_searchBtn,
                                   image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_sea_top", andIsOne: false))

        tufuh_searchV.tukou_addTapGesture(target: self, action: #selector(tukou_goToSearch))

    }
    @objc func tukou_goToSearSS() {
        let tufuh_tarVC = TUOKOUXIUSwiftSSSVC()
        tufuh_tarVC.tufuh_gotoSS = true
        tufuh_tarVC.tufuh_searchStr = tufuh_topSearL?.text ?? " "
        tufuh_tarVC.tufuh_source = "2"
        tufuh_tarVC.tufuh_isTS = true
        navigationController?.pushViewController(tufuh_tarVC, animated: true)
    }

    @objc func tukou_testNet() {
        if (TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0) {
            tukou_creTabV()
        } else {
            tukou_noNetwV()
        }
    }
    
    func tukou_creTabV() {
        if !tufuh_dataTreArr.isEmpty {
            return
        }
        if (tufuh_noNetV != nil) {
            tufuh_noNetV!.removeFromSuperview()
            tufuh_noNetV = nil
        }
        
        if (tufuh_headV != nil) {
            tufuh_headV!.removeFromSuperview()
            tufuh_headV = nil
        }
        
        tufuh_refrV.removeFromSuperview()
        tufuh_refrV.delegate = nil
        
        
        if (tufuh_collcV != nil) {
            tufuh_collcV!.subviews.forEach { $0.removeFromSuperview() }
            tufuh_collcV!.removeFromSuperview()
            tufuh_collcV = nil
        }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        tufuh_collcV = UICollectionView(frame: CGRect(x: 10, y: tufuh_topV!.frame.maxY, width: TUOKOUXIUSwiftSCRE_W - 20, height: TUOKOUXIUSwiftSCRE_H - tufuh_topV!.frame.maxY - TUOKOUXIUDeviceInfo.tukou_tabBarHeight), collectionViewLayout: layout)
        tufuh_collcV!.delegate = self
        tufuh_collcV!.dataSource = self
        tufuh_collcV!.backgroundColor = TUOKOUXIUSwiftheiseC
        tufuh_collcV!.showsVerticalScrollIndicator = false

        tufuh_collcV!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TUOKOUXIUTTSSCoVDefCelId")
        tufuh_collcV!.register(TUOKOUXIUSwiftHHHCollVCell.self, forCellWithReuseIdentifier: "TUOKOUXIUTTSSCoVCelId")

        tufuh_collcV!.register(
            TUOKOUXIUSwiftTTSSCollReusV.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "TUOKOUXIUTTSSCoHeReuVId"
        )
        tufuh_collcV!.register(
            TUOKOUXIUSSSSwiftCollReuV.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "TUOKOUXIUTTSSColFoReuVId"
        )
        tufuh_collcV!.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "TUOKOUXIUTTSSCoVDefSupVId"
        )
        tufuh_collcV!.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "TUOKOUXIUTTSSCoVDefSupVId"
        )
        view.addSubview(tufuh_collcV!)
        
        self.tufuh_refrV.fuhan_setup(owner: tufuh_collcV!, delegate: self)
        
        tufuh_collcV!.es.addInfiniteScrolling { [weak self] in
            guard let self = self else { return }
            self.tukou_reqSouSuo(isPull: false)
        }
    }
    
    func tukou_reqSouSuo(isPull: Bool) {
        guard TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0 else {
            TUOKOUXIUSwiftKeyWindow()!.makeToast("The network is abnormal. Please check the network link!", duration: 2.0, position: .center)
            return
        }
        
        if isPull {
            self.tufuh_currPaN = 1
            if !self.tufuh_dataTreArr.isEmpty {
                self.tufuh_dataTreArr.removeAll()
            }
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
        tufuh_psDict["page"] = "\(self.tufuh_currPaN)"

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
                
                if !tufuh_resArr.isEmpty {
                    self.tufuh_collcV!.es.stopLoadingMore()
                    self.tufuh_collcV!.es.resetNoMoreData()
                    self.tufuh_currPaN += 1
                    self.tufuh_dataTreArr.append(contentsOf: tufuh_resArr)
                    self.tufuh_collcV!.reloadData()

                } else {

                    self.tufuh_collcV!.es.noticeNoMoreData()
                    TUOKOUXIUSwiftKeyWindow()!.makeToast("No more data!", duration: 2.0, position: .center)
                    self.tufuh_collcV!.reloadData()
                }
            } else {
        

                self.tufuh_collcV!.es.noticeNoMoreData()
                TUOKOUXIUSwiftKeyWindow()!.makeToast("No more data!", duration: 2.0, position: .center)
                self.tufuh_collcV!.reloadData()
            }
        }
    }

    func tukou_pullDRefDidFin() {
        self.tufuh_dataTDict.removeAll()
        self.tufuh_collcV!.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.tukou_stoo()
        }
    }

    func tukou_stoo() {
        self.tufuh_refrV.fuhan_stoLoadi()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tufuh_refrV.scrollViewDidScroll(scrollView)
        
        if scrollView == self.tufuh_collcV {
            let tufuh_yy = self.tufuh_collcV!.contentOffset.y
            let expCount = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr.count
            if tufuh_yy >= CGFloat(expCount) * 40, !self.tufuh_dataTreArr.isEmpty {
                if self.tufuh_topTV == nil {
                    self.tukou_shoTypeV()
                }
            } else {
                if self.tufuh_topTV != nil {
                    self.tukou_hidTypeV()
                }
            }
        }
    }

    func tukou_shoTypeV() {
        let tufuh_arr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr
        guard !tufuh_arr.isEmpty else { return }
        
        self.tufuh_topTV = UIView.tukou_bjView(
            CGRect(x: 0, y: self.tufuh_topV?.frame.maxY ?? 0, width: TUOKOUXIUSwiftSCRE_W, height: 50),
            superView: self.view,
            bgColor: TUOKOUXIUSwiftheiseC
        )
        
        var tufuh_str = ""
        let names = [
            self.tufuh_headV?.tufuh_name1,
            self.tufuh_headV?.tufuh_name2,
            self.tufuh_headV?.tufuh_name3,
            self.tufuh_headV?.tufuh_name4,
            self.tufuh_headV?.tufuh_name5,
            self.tufuh_headV?.tufuh_name6
        ]
        
        for name in names {
            if let n = name, !n.isEmpty {
                if !tufuh_str.isEmpty {
                    tufuh_str += " · "
                }
                tufuh_str += n
            }
        }
        
        let tufuh_titL = UILabel.tukou_bjLabel(
            CGRect(x: 10, y: 0, width: TUOKOUXIUSwiftSCRE_W - 20, height: 44),
            text: tufuh_str,
            superView: self.tufuh_topTV!,
            textAlignment: .left,
            font: TUOKOUXIUSwiftFont.medium(15),
            textColor: TUOKOUXIUSwiftZTClr
        )
        tufuh_titL.numberOfLines = 0
        
        self.tufuh_toTopBtn = UIButton.tukou_bjBtn(
            CGRect(x: TUOKOUXIUSwiftSCRE_W - 60, y: TUOKOUXIUSwiftSCRE_H - TUOKOUXIUDeviceInfo.tukou_tabBarHeight - 60, width: 40, height: 40),
            target: self,
            image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_totop", andIsOne: false),
            superView: self.view,
            action: #selector(tukou_toTop)
        )
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        guard !self.tufuh_isToD else { return }
        
        self.tufuh_collcV!.setContentOffset(.zero, animated: true)
        self.tufuh_isToD = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.tufuh_isToD = false
        }
    }

    @objc func tukou_toTop() {
        self.tufuh_collcV!.setContentOffset(.zero, animated: true)
    }

    func tukou_hidTypeV() {
        if let topTV = self.tufuh_topTV {
            topTV.removeFromSuperview()
            self.tufuh_topTV = nil
        }
        if let toTopBtn = self.tufuh_toTopBtn {
            toTopBtn.removeFromSuperview()
            self.tufuh_toTopBtn = nil
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.tufuh_refrV.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.tufuh_refrV.scrollViewWillBeginDragging(scrollView)
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
            action: #selector(tukou_testNet),
            font: TUOKOUXIUSwiftFont.semibold(14),
            title: "Retry",
            color: TUOKOUXIUSwiftbaiseC,
            bgColor: TUOKOUXIUSwiftZTClr,
            cornerRadius: 5
        )
    }

    @objc func tukou_goToSearch() {
        let tufuh_tarVC = TUOKOUXIUSwiftSSSVC()
        tufuh_tarVC.tufuh_source = "2"
        tufuh_tarVC.tufuh_isTS = true
        self.navigationController?.pushViewController(tufuh_tarVC, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tufuh_dataTreArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.tufuh_dataTreArr.isEmpty {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUTTSSCoVDefCelId", for: indexPath)
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUTTSSCoVCelId", for: indexPath) as? TUOKOUXIUSwiftHHHCollVCell else {
            return UICollectionViewCell()
        }
        cell.tukou_resModel(self.tufuh_dataTreArr[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.tufuh_dataTreArr.isEmpty { return .zero }
        return CGSize(width: 112 * TUOKOUXIUDeviceInfo.scaleX, height: 160 * TUOKOUXIUDeviceInfo.scaleX + 34)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.tufuh_dataTreArr.isEmpty { return .zero }
        return CGSize(width: TUOKOUXIUSwiftSCRE_W, height: 0.1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: TUOKOUXIUSwiftSCRE_W, height: CGFloat(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr.count) * 40)
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "TUOKOUXIUTTSSColFoReuVId",
                for: indexPath
            ) as! TUOKOUXIUSSSSwiftCollReuV
        }
        if kind == UICollectionView.elementKindSectionHeader {
            if self.tufuh_headV != nil && self.tufuh_dataTDict.keys.count>0 {
                if self.tufuh_isRecover {
                    self.tufuh_isRecover = false
                    self.tufuh_headV?.tukou_recoverV(self.tufuh_dataTDict)
                }
                self.tufuh_headV = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "TUOKOUXIUTTSSCoHeReuVId",
                    for: indexPath
                ) as? TUOKOUXIUSwiftTTSSCollReusV
                return self.tufuh_headV!
            }
            self.tufuh_headV = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "TUOKOUXIUTTSSCoHeReuVId",
                for: indexPath
            ) as? TUOKOUXIUSwiftTTSSCollReusV
            self.tufuh_headV!.tufuh_clkItemBlk = { [weak self] string, type in
                guard let self = self else { return }
                self.tufuh_dataTDict[type] = string
                if self.tufuh_dataTDict.values.count ==
                    TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr.count {
                    self.tufuh_currPaN = 1
                    self.tukou_reqSouSuo(isPull: true)
                }
            }
            self.tufuh_headV!.tukou_creatrV()
            return self.tufuh_headV!
        }
        return collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "TUOKOUXIUTTSSCoVDefSupVId",
            for: indexPath
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < self.tufuh_dataTreArr.count else { return }
        

    }
}
