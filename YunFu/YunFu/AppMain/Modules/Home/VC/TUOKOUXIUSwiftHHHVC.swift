
import Foundation
import UIKit
import Kingfisher
import Toast
import Combine

class TUOKOUXIUSwiftHHHVC: TUOKOUXIUSwiftBaseVC, TUOKOUXIUSwiftPagTitVDelegate, TUOKOUXIUSwiftPagContScrVDelegate {
    func tukou_pageContScrV(_ pageContentScrollView: TUOKOUXIUSwiftPagContScrV, index: Int) {
        
    }
    var tufuh_topV: UIView?
    var tufuh_selectTypeV: TUOKOUXIUselectTypeW?
    var tufuh_scrV = UIScrollView()
    var tufuh_homeSceneBtn: UIButton?
    var tufuh_noNetV: UIView?
    var tufuh_tabN: Int = 0
    var tufuh_musicW: TUOKOUXIUMusicW?
    var tufuh_ttitleV: UIView?
    var tufuh_topTypeV: TUOKOUXIUTopTypeViewW?
    var tufuh_toolsW: TUOKOUXIUToolsW?
//    var tufuh_isFirWil: Bool = false
    var tufuh_isMusicOpen: Bool = false
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
              let updaW = self.tufuh_toolsW else { return }
        
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
        let updaW2 = self.tufuh_musicW
        let views2 = updaW2!.subviews
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
        for v in views2 {

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
        updaW2!.isHidden = (progress >= 0.999)
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
            self.tufuh_musicW = TUOKOUXIUMusicW(frame: self.view.bounds)
            self.tufuh_toolsW = TUOKOUXIUToolsW(frame: self.view.bounds)
            let titleV = UIView.tukou_bjView(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-314/2, y: 0, width: 314, height: 40), superView: self.tufuh_musicW!, bgColor: TUOKOUXIUSwiftZTClr5A)
            titleV.layer.cornerRadius = 20
            titleV.tukou_addTapGesture(target: self, action: #selector(clickMusic))
            tufuh_ttitleV = titleV
            let musicIV = UIImageView.tukou_bjImageV(CGRect(x: 8, y: 8, width: 24, height: 24), superView: titleV, image: UIImage(named: "home_music"))
            musicIV.backgroundColor = TUOKOUXIUSwiftZTClr5A
            musicIV.layer.cornerRadius = 12
            musicIV.layer.masksToBounds = true
            
            let musicL = UILabel.tukou_bjLabel(CGRect(x: musicIV.frame.maxX + 8, y: 8, width: 120, height: 24), text: "东方禅境的艺术", superView: titleV, textAlignment: .left, font: TUOKOUXIUSwiftFont.medium(16), textColor: .white)
            
            let lineV = UIView.tukou_bjView(CGRect(x: musicL.frame.maxX + 8, y: 14, width: 1, height: 12), superView: titleV, bgColor: TUOKOUXIUSwiftZTClr3A)
            
            let nameL = UILabel.tukou_bjLabel(CGRect(x: lineV.frame.maxX + 14, y: 8, width: 120, height: 24), text: "艺术家：包玉树", superView: titleV, textAlignment: .left, font: TUOKOUXIUSwiftFont.regular(14), textColor: TUOKOUXIUSwiftZTClr3A)
            
            let contentV = UIView.tukou_bjView(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-335/2, y: 0, width: 335, height: 80), superView: self.tufuh_toolsW!, bgColor: .clear)
            
            let collectionBtn = UIButton.tukou_bjBtn(CGRect(x: 10, y: 20, width: 40, height: 40), target: self, image: UIImage(named: "home_collection_default"), superView: contentV, action: #selector(clickCollect(_:)))
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
            timerBtn.setImageTitleSpacing(4, shiftLeft: 1)
            timerBtn.titleLabel?.font = TUOKOUXIUSwiftFont.regular(14)
            
            let blockingBtn = UIButton.tukou_bjBtn(CGRect(x: 335-10-40-15-40, y: 20, width: 40, height: 40), target: self, image: UIImage(named: "home_blocking"), superView: contentV, action: #selector(clickTiming))
            blockingBtn.backgroundColor = TUOKOUXIUSwiftZTClr5A
            blockingBtn.layer.cornerRadius = 20
            
            let shareBtn = UIButton.tukou_bjBtn(CGRect(x: 335-10-40, y: 20, width: 40, height: 40), target: self, image: UIImage(named: "home_share"), superView: contentV, action: #selector(clickShare))
            shareBtn.backgroundColor = TUOKOUXIUSwiftZTClr5A
            shareBtn.layer.cornerRadius = 20
            self.view.addSubview(self.tufuh_musicW!)
            self.view.addSubview(self.tufuh_toolsW!)
        }
    }
    
    //点击音乐
    @objc func clickMusic() {
        print("点击音乐")
        self.tufuh_musicW!.tukou_updateUI()
        tufuh_isMusicOpen = true
        self.tufuh_musicW!.tuks_spx = TUOKOUXIUSwiftSCRE_W/2-256/2
        self.tufuh_musicW!.tuks_spy = TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 44 + 32 + 10
        self.tufuh_musicW!.tuks_spwidth = 256
        self.tufuh_musicW!.tuks_spheight = 72
        tufuh_ttitleV?.removeFromSuperview()
        tufuh_ttitleV = nil
        tufuh_ttitleV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: 256, height: 72), superView: self.tufuh_musicW!, bgColor: TUOKOUXIUSwiftZTClr5A)
        tufuh_ttitleV?.layer.cornerRadius = 20
        let musicTitleL = UILabel.tukou_bjLabel(CGRect(x: 0, y: 0, width: 256, height: 40), text: "东方禅境", superView: tufuh_ttitleV!, textAlignment: .center, font: TUOKOUXIUSwiftFont.semibold(24), textColor: .white)
        let musicSubTitleL = UILabel.tukou_bjLabel(CGRect(x: 0, y: 40, width: 256, height: 32), text: "空灵东方之声，抚平内在涟漪", superView: tufuh_ttitleV!, textAlignment: .center, font: TUOKOUXIUSwiftFont.regular(14), textColor: TUOKOUXIUSwiftZTClr3A)
        tufuh_pageTitV.isHidden = true
        tufuh_homeSceneBtn?.isHidden = true
        
        //禁止横向滑动
        tufuh_pageContScrV.tufuh_scrV.isScrollEnabled = false
        
        self.tufuh_topTypeV = TUOKOUXIUTopTypeViewW(frame: self.view.bounds)
        let titleV = UIView.tukou_bjView(CGRect(x: 6, y: 0, width: 86, height: 32), superView: self.tufuh_topTypeV!, bgColor: TUOKOUXIUSwiftZTClr9A)
        titleV.layer.cornerRadius = 16
        titleV.layer.borderColor = TUOKOUXIUSwiftZTClr10A.cgColor
        titleV.layer.borderWidth = 1
        titleV.tukou_addTapGesture(target: self, action: #selector(clickBackType))
        
        let titleIV = UIImageView.tukou_bjImageV(CGRect(x: 8, y: 4, width: 24, height: 24), superView: titleV, image: UIImage(named: "sleep"))
        
        let musicL = UILabel.tukou_bjLabel(CGRect(x: titleIV.frame.maxX + 6, y: 4, width: 42, height: 24), text: "瑜伽0", superView: titleV, textAlignment: .left, font: TUOKOUXIUSwiftFont.regular(14), textColor: .white)
        
        let moreBtn = UIButton.tukou_bjBtn(CGRect(x: titleV.frame.maxX + 8, y: 0, width: 32, height: 32), target: self, image: UIImage(named: "home_scene_x"), superView: self.tufuh_topTypeV!, action: #selector(clickTypeVOpen))
//        moreBtn.backgroundColor = TUOKOUXIUSwiftZTClr5A
        moreBtn.layer.cornerRadius = 16
        moreBtn.layer.borderColor = TUOKOUXIUSwiftZTClr10A.cgColor
        moreBtn.layer.borderWidth = 1
        
        self.view.addSubview(self.tufuh_topTypeV!)
    }
    
    //点击返回之前类型页面
    @objc func clickBackType() {
        print("点击返回之前类型页面")
        tufuh_isMusicOpen = false
        self.tufuh_topTypeV?.isHidden = true
        self.tufuh_topTypeV?.removeFromSuperview()
        self.tufuh_topTypeV = nil
        self.tufuh_musicW?.isHidden = true
        self.tufuh_musicW?.removeFromSuperview()
        self.tufuh_musicW = nil

        tufuh_pageTitV.isHidden = false
        tufuh_homeSceneBtn?.isHidden = false
        tufuh_pageContScrV.tufuh_scrV.isScrollEnabled = true
        
        self.tufuh_musicW = TUOKOUXIUMusicW(frame: self.view.bounds)
        let titleV = UIView.tukou_bjView(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-314/2, y: 0, width: 314, height: 40), superView: self.tufuh_musicW!, bgColor: TUOKOUXIUSwiftZTClr5A)
        titleV.layer.cornerRadius = 20
        titleV.tukou_addTapGesture(target: self, action: #selector(clickMusic))
        tufuh_ttitleV = titleV
        let musicIV = UIImageView.tukou_bjImageV(CGRect(x: 8, y: 8, width: 24, height: 24), superView: titleV, image: UIImage(named: "home_music"))
        musicIV.backgroundColor = TUOKOUXIUSwiftZTClr5A
        musicIV.layer.cornerRadius = 12
        musicIV.layer.masksToBounds = true
        
        let musicL = UILabel.tukou_bjLabel(CGRect(x: musicIV.frame.maxX + 8, y: 8, width: 120, height: 24), text: "东方禅境的艺术", superView: titleV, textAlignment: .left, font: TUOKOUXIUSwiftFont.medium(16), textColor: .white)
        
        let lineV = UIView.tukou_bjView(CGRect(x: musicL.frame.maxX + 8, y: 14, width: 1, height: 12), superView: titleV, bgColor: TUOKOUXIUSwiftZTClr3A)
        
        let nameL = UILabel.tukou_bjLabel(CGRect(x: lineV.frame.maxX + 14, y: 8, width: 120, height: 24), text: "艺术家：包玉树", superView: titleV, textAlignment: .left, font: TUOKOUXIUSwiftFont.regular(14), textColor: TUOKOUXIUSwiftZTClr3A)
        
        self.view.addSubview(self.tufuh_musicW!)
    }
    
    //点击展开类型
    @objc func clickTypeVOpen() {
        print("点击展开类型")

        tufuh_selectTypeV = TUOKOUXIUselectTypeW(frame: self.view.bounds)
        self.view.addSubview(self.tufuh_selectTypeV!)
        self.tufuh_scrV = UIScrollView.tukou_bjScrollV(
            CGRect(x: 0, y: 16, width: 152, height: 164),
            superView: tufuh_selectTypeV!,
            bgColor: .clear
        )
        self.tufuh_scrV.showsVerticalScrollIndicator = false
        
        let tufuh_arr: [String] = ["瑜伽0","瑜伽1","瑜伽2","瑜伽3","瑜伽4","瑜伽5","瑜伽6","瑜伽7","瑜伽8"]
            
        for i in 0...tufuh_arr.count - 1 {
            let tufuh_string = tufuh_arr[i]
            let btnY = i * (32 + 12)
            let typeBtn = UIButton.tukou_bjBtn(CGRect(x: 16, y: btnY, width: 120, height: 32), target: self, image: UIImage(named: "sleep"), superView: self.tufuh_scrV, action: #selector(clickTypeUpdate(_:)))
            typeBtn.layer.cornerRadius = 16
            typeBtn.setImageTitleSpacing(4, shiftLeft: 16)
            typeBtn.titleLabel?.textColor = .white
            typeBtn.setTitle(tufuh_string, for: .normal)
            typeBtn.titleLabel?.font = TUOKOUXIUSwiftFont.regular(14)
            typeBtn.tag = i
            if tufuh_string == "瑜伽0" {
                typeBtn.backgroundColor = TUOKOUXIUSwiftZTClr10A
            }
            if i == tufuh_arr.count - 1 {
                self.tufuh_scrV.contentSize = CGSize(width: 152, height: btnY + 32)
            }
        }

    }
    //点击更新类型
    @objc func clickTypeUpdate(_ btn: UIButton) {
        tufuh_selectTypeV?.isHidden = true
        tufuh_selectTypeV?.removeFromSuperview()
        tufuh_selectTypeV = nil
    }
    
    
    //点击收藏
    @objc func clickCollect(_ btn: UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            print("收藏")
//            NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUHidTabb"), object: nil)
        } else {
            print("取消收藏")
//            NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShoTabb"), object: nil)
        }
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
            CGRect(x: 15, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight+20, width: TUOKOUXIUSwiftSCRE_W - 75, height: 44),
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
        
        tufuh_homeSceneBtn = UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W-52, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight+26, width: 32, height: 32), target: self, image: UIImage(named: "home_scene"), superView: self.tufuh_topV!, action: #selector(tukou_zhankai))
    }
    
    @objc func tukou_zhankai() {
        print("点击展开 头标题类型")
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
