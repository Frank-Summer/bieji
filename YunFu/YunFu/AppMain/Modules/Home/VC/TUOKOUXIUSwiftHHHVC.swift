
import Foundation
import UIKit
import Kingfisher
import Toast
import Combine

class TUOKOUXIUSwiftHHHVC: TUOKOUXIUSwiftBaseVC, TUOKOUXIUSwiftPagTitVDelegate, TUOKOUXIUSwiftPagContScrVDelegate {
    func tukou_pageContScrV(_ pageContentScrollView: TUOKOUXIUSwiftPagContScrV, index: Int) {
        
    }
    var tufuh_topV: UIView?
    var tufuh_noNetV: UIView?
    var tufuh_tabN: Int = 0
    var tufuh_updaW: TUOKOUXIUAppUpdW?
//    var tufuh_isFirWil: Bool = false

    private var cancellables = Set<AnyCancellable>()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
//        if self.tufuh_isFirWil {
//            NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUHHHWillAppear"), object: nil)
//        }
//        self.tufuh_isFirWil = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShoTabb"), object: nil)
    }

    func tufuh_updaWScroll(_ noti: Notification) {
        guard let info = noti.userInfo,
              let progress = info["progress"] as? CGFloat,
              let updaW = self.tufuh_updaW else { return }
        
        // 非线性曲线（苹果弹性 + ease-out 混合）
        // 更丝滑：前面非常慢，后面变快
        let smoothP = pow(progress, 1.8)

        // 计算动画参数
        let moveY = smoothP * 82                               // 下移距离
        let scale = 1 - smoothP * 0.06                         // 1 → 0.94（苹果浮层）
        let alphaV = 1 - smoothP                               // 透明度
        let shadowAlpha = max(0, 0.3 - smoothP * 0.3)          // 阴影淡出
        let blurAlpha = 1 - smoothP                            // blur 透明度

        let views = updaW.subviews

        for v in views {

            // transform：位移 + 缩放（丝滑核心）
            let t = CGAffineTransform(translationX: 0, y: moveY)
                .scaledBy(x: scale, y: scale)
            v.transform = t

            // alpha
            v.alpha = alphaV

            // 阴影动态变化
            v.layer.shadowOpacity = Float(shadowAlpha)

            // 如果是毛玻璃视图，调整其 alpha
            if let blur = v as? UIVisualEffectView {
                blur.alpha = blurAlpha
            }
        }

        updaW.isHidden = (progress >= 0.999)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tufuh_tabN = 0
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jzGFV(TUOKOUXIUSwiftKeyWinRoV)
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUUpdaWScroll"))
            .sink { [weak self] notification in self?.tufuh_updaWScroll(notification) }
            .store(in: &cancellables)
        
//        self.view.backgroundColor = .orange
        
        if TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() == 0 {
            tukou_noNetwV()
            return
        }
        
        tukou_clickRefresh2()
//        TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
            self.tufuh_updaW = TUOKOUXIUAppUpdW(frame: self.view.bounds)
            let titleV = UIView.tukou_bjView(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-314/2, y: 0, width: 314, height: 40), superView: self.tufuh_updaW!, bgColor: TUOKOUXIUSwiftZTClr5A)
            titleV.layer.cornerRadius = 20
            
            let musicBtn = UIButton.tukou_bjBtn(CGRect(x: 8, y: 8, width: 24, height: 24), target: self, image: UIImage(named: "home_music"), superView: titleV, action: #selector(clickReplay))
            musicBtn.backgroundColor = TUOKOUXIUSwiftZTClr5A
            musicBtn.layer.cornerRadius = 12
            
            let musicL = UILabel.tukou_bjLabel(CGRect(x: musicBtn.frame.maxX + 8, y: 8, width: 120, height: 24), text: "东方禅境的艺术", superView: titleV, textAlignment: .left, font: TUOKOUXIUSwiftFont.medium(16), textColor: .white)
            
            let lineV = UIView.tukou_bjView(CGRect(x: musicL.frame.maxX + 8, y: 14, width: 1, height: 12), superView: titleV, bgColor: TUOKOUXIUSwiftZTClr3A)
            
            let nameL = UILabel.tukou_bjLabel(CGRect(x: lineV.frame.maxX + 14, y: 8, width: 120, height: 24), text: "艺术家：包玉树", superView: titleV, textAlignment: .left, font: TUOKOUXIUSwiftFont.regular(14), textColor: TUOKOUXIUSwiftZTClr3A)
            
            let contentV = UIView.tukou_bjView(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-335/2, y: 40, width: 335, height: 80), superView: self.tufuh_updaW!, bgColor: .clear)
            
            let collectionBtn = UIButton.tukou_bjBtn(CGRect(x: 10, y: 20, width: 40, height: 40), target: self, image: UIImage(named: "home_collection_default"), superView: contentV, action: #selector(clickCollect))
            collectionBtn.setImage(UIImage(named: "home_collection_selected"), for: .selected)
            collectionBtn.backgroundColor = TUOKOUXIUSwiftZTClr5A
            collectionBtn.layer.cornerRadius = 20
            
            let replayBtn = UIButton.tukou_bjBtn(CGRect(x: 10+40+15, y: 20, width: 40, height: 40), target: self, image: UIImage(named: "home_replay"), superView: contentV, action: #selector(clickReplay))
            replayBtn.backgroundColor = TUOKOUXIUSwiftZTClr5A
            replayBtn.layer.cornerRadius = 20
            
            let timerBtn = UIButton.tukou_bjBtn(CGRect(x: 335/2-105/2, y: 20, width: 105, height: 40), target: self, image: UIImage(named: "home_timer_default"), superView: contentV, action: #selector(clickTime))
            timerBtn.backgroundColor = TUOKOUXIUSwiftZTClr5A
            timerBtn.layer.cornerRadius = 20
            timerBtn.titleLabel?.textColor = .white
            timerBtn.setTitle("4:00:20", for: .normal)
            timerBtn.titleLabel?.font = TUOKOUXIUSwiftFont.regular(14)
            
            let blockingBtn = UIButton.tukou_bjBtn(CGRect(x: 335-10-40-15-40, y: 20, width: 40, height: 40), target: self, image: UIImage(named: "home_blocking"), superView: contentV, action: #selector(clickTiming))
            blockingBtn.backgroundColor = TUOKOUXIUSwiftZTClr5A
            blockingBtn.layer.cornerRadius = 20
            
            let shareBtn = UIButton.tukou_bjBtn(CGRect(x: 335-10-40, y: 20, width: 40, height: 40), target: self, image: UIImage(named: "home_share"), superView: contentV, action: #selector(clickShare))
            shareBtn.backgroundColor = TUOKOUXIUSwiftZTClr5A
            shareBtn.layer.cornerRadius = 20
            
            self.view.addSubview(self.tufuh_updaW!)
        }
    }
    
    //点击音乐
    @objc func clickMusic() {
        print("点击音乐")
    }
    
    //点击收藏
    @objc func clickCollect() {
        print("点击收藏")
    }
    
    //点击重载
    @objc func clickReplay() {
        print("点击重载")
    }
    
    //点击时间
    @objc func clickTime() {
        print("点击时间")
    }
    
    //点击定时
    @objc func clickTiming() {
        print("点击定时")
    }
    
    //点击分享
    @objc func clickShare() {
        print("点击分享")
    }
    
//    func tukou_clickRefresh() {
//        TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jzGFV(TUOKOUXIUSwiftKeyWinRoV)
//        tukou_reqTK()
//        
//        self.tufuh_block = { [weak self] isSuccess in
//            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
//            guard let self = self else { return }
//            if isSuccess {
//                self.tukou_clickRefresh2()
//            }
//        }
//    }

    @objc func tukou_clickRefresh2() {
        if TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() == 0 { return }
        
        if let noNetV = self.tufuh_noNetV {
            noNetV.removeFromSuperview()
            self.tufuh_noNetV = nil
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
//        let tufuh_titArr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_hhTabsArr
        var tufuh_arr: [String] = ["瑜伽0","瑜伽1","瑜伽2","瑜伽3","瑜伽4","瑜伽5","瑜伽6","瑜伽7","瑜伽8"]
//        for item in tufuh_titArr {
//            if let dict = item as? [String: Any], let name = dict["name"] as? String {
//                tufuh_arr.append(name)
//            }
//        }
        
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
            CGRect(x: 15, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight, width: TUOKOUXIUSwiftSCRE_W - 75, height: 44),
            delegate: self,
            titleNames: tufuh_arr,
            configure: tufuh_conf
        )
        
        pageTitV.backgroundColor = TUOKOUXIUSwiftwuseC
        return pageTitV
    }()
    
    lazy var tufuh_pageContScrV: TUOKOUXIUSwiftPagContScrV = {
        var childVCs: [UIViewController] = []
        let tabsArr = [["name": "瑜伽0", "key":"0"],["name": "瑜伽1", "key":"1"],["name": "瑜伽2", "key":"2"],["name": "瑜伽3", "key":"3"],["name": "瑜伽4", "key":"4"],["name": "瑜伽5", "key":"5"],["name": "瑜伽6", "key":"6"],["name": "瑜伽7", "key":"7"],["name": "瑜伽8", "key":"8"]]

        for (i, item) in tabsArr.enumerated() {
            let v1 = TUOKOUXIUSwiftHHHHSubVC()
            v1.tufuh_num = i
            childVCs.append(v1)
        }

        let pageContScrV = TUOKOUXIUSwiftPagContScrV(
            frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H),
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
        self.tufuh_topV = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 44))
        self.tufuh_topV!.backgroundColor = TUOKOUXIUSwiftwuseC
        self.view.addSubview(self.tufuh_topV!)
        
        UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W-52, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight+6, width: 32, height: 32), target: self, image: UIImage(named: "home_scene"), superView: self.tufuh_topV!, action: #selector(tukou_zhankai))
    }
    
    @objc func tukou_zhankai() {
        
    }

    func tukou_noNetwV() {
        guard self.tufuh_noNetV == nil else { return }

        let height = TUOKOUXIUSwiftSCRE_H - TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight - 56 - TUOKOUXIUDeviceInfo.tukou_tabBarHeight
        self.tufuh_noNetV = UIView.tukou_bjView(CGRect(x: 0, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60, width: TUOKOUXIUSwiftSCRE_W, height: height), superView: self.view, bgColor: TUOKOUXIUSwiftheiseC)

        let label1 = UILabel.tukou_bjLabel(CGRect(x: 0, y: height/2-12, width: TUOKOUXIUSwiftSCRE_W, height: 20),
                                            text: "网络连接失败",
                                           superView: self.tufuh_noNetV!,
                                            textAlignment: .center,
                                           font: TUOKOUXIUSwiftFont.medium(16),
                                            textColor: TUOKOUXIUSwiftbaiseC)
        
        let label2 = UILabel.tukou_bjLabel(CGRect(x: 0, y: label1.frame.maxY + 6, width: TUOKOUXIUSwiftSCRE_W, height: 20),
                                            text: "别急，好饭不怕晚，请检查当前网络状态后再试试",
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
                             title: "重试",
                             color: TUOKOUXIUSwiftbaiseC,
                             bgColor: TUOKOUXIUSwiftZTClr,
                             cornerRadius: 5)
    }

}
