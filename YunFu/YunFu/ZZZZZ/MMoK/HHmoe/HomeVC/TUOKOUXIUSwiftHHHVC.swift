
import Foundation
import UIKit
import Kingfisher
import Toast
import Combine

class TUOKOUXIUSwiftHHHVC: TUOKOUXIUSwiftBaseVC, TUOKOUXIUSwiftPagTitVDelegate, TUOKOUXIUSwiftPagContScrVDelegate {
    func tukou_pageContScrV(_ pageContentScrollView: TUOKOUXIUSwiftPagContScrV, index: Int) {
        
    }
    
    var tufuh_topV: UIView?
    var tufuh_topSearL: UILabel?
    var tufuh_hotTN: Int = 0
    var tufuh_noNetV: UIView?
    var tufuh_topSearIV: UIImageView?
    
    var tufuh_subDict: [String: Any]?
    var tufuh_loadProV: UIView?
    var tufuh_loadProLV: UIView?
    
    var tufuh_loadTZV: UIView?
    var tufuh_isVpType: Int = 0

    
    var tufuh_tabN: Int = 0

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

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShoTabb"), object: nil)
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


        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUTopVBianSe"))
            .sink { [weak self] notification in self?.tukou_topVBianSe(notification) }
            .store(in: &cancellables)
        
        self.view.backgroundColor = TUOKOUXIUSwiftheiseC
        
        if TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() == 0 {
            tukou_noNetwV()
            return
        }
        
        tukou_clickRefresh()
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

            tufuh_conf.tufuh_titFont = TUOKOUXIUSwiftFont.medium(15)
            tufuh_conf.tufuh_titSeleFon = TUOKOUXIUSwiftFont.semibold(19)
            pageTitV = TUOKOUXIUSwiftPagTitV.tukou_pageTitVWithFra(frame:
                CGRect(x: 15, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60, width: TUOKOUXIUSwiftSCRE_W - 25, height: 44),
                delegate: self,
                titleNames: tufuh_arr,
                configure: tufuh_conf
            )
        
        
        pageTitV.backgroundColor = TUOKOUXIUSwiftwuseC
        return pageTitV
    }()
    
    lazy var tufuh_pageContScrV: TUOKOUXIUSwiftPagContScrV = {
        var childVCs: [UIViewController] = []
        let tabsArr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_hhTabsArr

        for (i, item) in tabsArr.enumerated() {
            let v1 = TUOKOUXIUSwiftHHHHSubVC()
            v1.tufuh_num = i
            childVCs.append(v1)
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
        
        self.tufuh_topV = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60 + topHeight))
        self.tufuh_topV!.backgroundColor = TUOKOUXIUSwiftwuseC
        self.view.addSubview(self.tufuh_topV!)
        

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

}
