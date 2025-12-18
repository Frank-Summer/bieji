
import Foundation
import UIKit
import Kingfisher
import Toast
import Combine

class HomeMainVC: TUOKOUXIUSwiftBaseVC, TUOKOUXIUSwiftPagTitVDelegate, TUOKOUXIUSwiftPagContScrVDelegate {
    func tukou_pageContScrV(_ pageContentScrollView: TUOKOUXIUSwiftPagContScrV, index: Int) {
        
    }
    var tufuh_topIV: UIImageView?
    var tufuh_botIV: UIImageView?
    var tufuh_topV: UIView?
    var tufuh_selectTypeV: TUOKOUXIUselectTypeW?
    var tufuh_scrV = UIScrollView()
    var tufuh_homeSceneBtn: UIButton?
    var tufuh_timerBtn: UIButton?
    var tufuh_replayBtn: UIButton?
    var tufuh_blockingBtn: UIButton?
    var tufuh_noNetV: UIView?
    
    var tufuh_musicW: TUOKOUXIUMusicW?
    var tufuh_ttitleV: UIView?
    var tufuh_topTypeV: TUOKOUXIUTopTypeViewW?
    var tufuh_topSelectTypeV: UIView?
    var tufuh_topSelectTimeV: TUOKOUXIUTopselectTypeW?
    var tufuh_toolsW: TUOKOUXIUToolsW?
    var countdownTimer: Timer?
    var countdownRemainingSeconds: Int = 0
    var tufuh_container: UIView?

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
        Task {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray = await AuthService.getlist()
            if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray.count>0 {
                await MainActor.run {
                    tukou_clickRefresh2()
                    tukou_clickRefresh3()
//                    TUOKOUXIUSwiftDelaBlk(0.25) {
//                        NotificationCenter.default.post(name: Notification.Name("TUOKOUXIURefreshData"), object: nil)
//                    }
                }
            }
        }
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_selectNum = 0
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jzGFV(TUOKOUXIUSwiftKeyWinRoV)
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUUpdaWScroll"))
            .sink { [weak self] notification in self?.tufuh_updaWScroll(notification) }
            .store(in: &cancellables)
        NotificationCenter.default.addObserver(self, selector: #selector(enterMainView),
                                               name: Notification.Name("TUOKOUXIUEnterMainView"), object: nil)
        if TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() == 0 {
            tukou_noNetwV()
            return
        }
//        TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()

        
//        }
    }
    
    func tukou_clickRefresh3() {
        self.tufuh_musicW = TUOKOUXIUMusicW(frame: self.view.bounds)
        self.tufuh_toolsW = TUOKOUXIUToolsW(frame: self.view.bounds)
        let titleV = UIView.tukou_bjView(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-314/2, y: 0, width: 314, height: 40), superView: self.tufuh_musicW!, bgColor: TUOKOUXIUWhiteA10)
        titleV.layer.cornerRadius = 20
        titleV.tukou_addTapGesture(target: self, action: #selector(clickMusic))
        tufuh_ttitleV = titleV
        let musicIV = UIImageView.tukou_bjImageV(CGRect(x: 8, y: 8, width: 24, height: 24), superView: titleV, image: UIImage(named: "home_music"))
        musicIV.backgroundColor = TUOKOUXIUWhiteA10
        musicIV.layer.cornerRadius = 12
        musicIV.layer.masksToBounds = true
        
        let musicL = UILabel.tukou_bjLabel(CGRect(x: musicIV.frame.maxX + 8, y: 8, width: 120, height: 24), text: "东方禅境的艺术", superView: titleV, textAlignment: .left, font: TUOKOUXIUSwiftFont.medium(16), textColor: .white)
        
        let lineV = UIView.tukou_bjView(CGRect(x: musicL.frame.maxX + 8, y: 14, width: 1, height: 12), superView: titleV, bgColor: TUOKOUXIUWhiteA60)
        
        let nameL = UILabel.tukou_bjLabel(CGRect(x: lineV.frame.maxX + 14, y: 8, width: 120, height: 24), text: "艺术家：包玉树", superView: titleV, textAlignment: .left, font: TUOKOUXIUSwiftFont.regular(14), textColor: TUOKOUXIUWhiteA60)
        
        let contentV = UIView.tukou_bjView(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-335/2, y: 0, width: 335, height: 80), superView: self.tufuh_toolsW!, bgColor: TUOKOUXIUSwiftwuseC)
        let intervalWidth = (335-20-40*4-48)/4
        let collectionBtn = UIButton.tukou_bjBtn(CGRect(x: 10, y: 20, width: 40, height: 40), target: self, image: UIImage(named: "home_collection_default"), superView: contentV, action: #selector(clickCollect(_:)))
        collectionBtn.setImage(UIImage(named: "home_collection_selected"), for: .selected)
        collectionBtn.backgroundColor = TUOKOUXIUWhiteA10
        collectionBtn.layer.cornerRadius = 20
        
        tufuh_replayBtn = UIButton.tukou_bjBtn(CGRect(x: Int(collectionBtn.frame.maxX) + intervalWidth, y: 20, width: 40, height: 40), target: self, image: UIImage(named: "home_replay"), superView: contentV, action: #selector(clickReplay))
        tufuh_replayBtn!.backgroundColor = TUOKOUXIUWhiteA10
        tufuh_replayBtn!.layer.cornerRadius = 20
        
        tufuh_timerBtn = UIButton.tukou_bjBtn(CGRect(x: 335/2-48/2, y: 16, width: 48, height: 48), target: self, image: UIImage(named: "home_timer_default"), superView: contentV, action: #selector(clickTime))
        tufuh_timerBtn!.backgroundColor = TUOKOUXIUWhiteA10
        tufuh_timerBtn!.layer.cornerRadius = 24
        tufuh_timerBtn!.titleLabel?.font = TUOKOUXIUSwiftFont.regular(14)
        
        tufuh_blockingBtn = UIButton.tukou_bjBtn(CGRect(x: 335/2-48/2+48 + intervalWidth, y: 20, width: 40, height: 40), target: self, image: UIImage(named: "home_blocking"), superView: contentV, action: #selector(clickTiming))
        tufuh_blockingBtn!.backgroundColor = TUOKOUXIUWhiteA10
        tufuh_blockingBtn!.layer.cornerRadius = 20
        
        let shareBtn = UIButton.tukou_bjBtn(CGRect(x: 335-10-40, y: 20, width: 40, height: 40), target: self, image: UIImage(named: "home_share"), superView: contentV, action: #selector(clickShare))
        shareBtn.backgroundColor = TUOKOUXIUWhiteA10
        shareBtn.layer.cornerRadius = 20
        self.view.addSubview(self.tufuh_musicW!)
        self.view.addSubview(self.tufuh_toolsW!)
        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isEnterApp {
            self.tufuh_musicW?.isHidden = true
            self.tufuh_toolsW?.isHidden = true
        }
    }
    
    @objc private func enterMainView() {
        self.tufuh_musicW?.isHidden = false
        self.tufuh_toolsW?.isHidden = false
    }
    
    //点击音乐
    @objc func clickMusic() {
        print("点击音乐")
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isOpenHomeMusicExpand = true
        NotificationCenter.default.post(name: Notification.Name("TUOKOUXIURefreshSubView"), object: nil)
        self.tufuh_musicW!.tukou_updateUI()
        tufuh_isMusicOpen = true
        self.tufuh_musicW!.tuks_spx = TUOKOUXIUSwiftSCRE_W/2-256/2
        self.tufuh_musicW!.tuks_spy = TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 44 + 32 + 10
        self.tufuh_musicW!.tuks_spwidth = 256
        self.tufuh_musicW!.tuks_spheight = 72
        tufuh_ttitleV?.removeFromSuperview()
        tufuh_ttitleV = nil
        tufuh_ttitleV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: 256, height: 72), superView: self.tufuh_musicW!, bgColor: TUOKOUXIUWhiteA10)
        tufuh_ttitleV?.layer.cornerRadius = 20
        let musicTitleL = UILabel.tukou_bjLabel(CGRect(x: 0, y: 0, width: 256, height: 40), text: "东方禅境", superView: tufuh_ttitleV!, textAlignment: .center, font: TUOKOUXIUSwiftFont.semibold(24), textColor: .white)
        let musicSubTitleL = UILabel.tukou_bjLabel(CGRect(x: 0, y: 40, width: 256, height: 32), text: "空灵东方之声，抚平内在涟漪", superView: tufuh_ttitleV!, textAlignment: .center, font: TUOKOUXIUSwiftFont.regular(14), textColor: TUOKOUXIUWhiteA60)
        tufuh_pageTitV.isHidden = true
        tufuh_homeSceneBtn?.isHidden = true
        
        //禁止横向滑动
        tufuh_pageContScrV.tufuh_scrV.isScrollEnabled = false
        
        self.tufuh_topTypeV = TUOKOUXIUTopTypeViewW(frame: self.view.bounds)
        let titleV = UIView.tukou_bjView(CGRect(x: 6, y: 0, width: 86, height: 32), superView: self.tufuh_topTypeV!, bgColor: TUOKOUXIUBlackA20)
        titleV.layer.cornerRadius = 16
        titleV.layer.borderColor = TUOKOUXIUWhiteA20.cgColor
        titleV.layer.borderWidth = 1
        titleV.tukou_addTapGesture(target: self, action: #selector(clickBackType))
        
        let titleIV = UIImageView.tukou_bjImageV(CGRect(x: 8, y: 4, width: 24, height: 24), superView: titleV, image: UIImage(named: "sleep"))
        let model:SceneModel = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray[TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_selectNum]
        let name = model.sceneName
        let musicL = UILabel.tukou_bjLabel(CGRect(x: titleIV.frame.maxX + 6, y: 4, width: 42, height: 24), text: name, superView: titleV, textAlignment: .left, font: TUOKOUXIUSwiftFont.regular(14), textColor: .white)
        
        let moreBtn = UIButton.tukou_bjBtn(CGRect(x: titleV.frame.maxX + 8, y: 0, width: 32, height: 32), target: self, image: UIImage(named: "home_scene_x"), superView: self.tufuh_topTypeV!, action: #selector(clickTypeVOpen))
//        moreBtn.backgroundColor = TUOKOUXIUWhiteA10
        moreBtn.layer.cornerRadius = 16
        moreBtn.layer.borderColor = TUOKOUXIUWhiteA20.cgColor
        moreBtn.layer.borderWidth = 1
        
        self.view.addSubview(self.tufuh_topTypeV!)
    }
    
    //点击返回之前类型页面
    @objc func clickBackType() {
        print("点击返回之前类型页面")
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isOpenHomeMusicExpand = false
        NotificationCenter.default.post(name: Notification.Name("TUOKOUXIURefreshSubView"), object: nil)
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
        let titleV = UIView.tukou_bjView(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-314/2, y: 0, width: 314, height: 40), superView: self.tufuh_musicW!, bgColor: TUOKOUXIUWhiteA10)
        titleV.layer.cornerRadius = 20
        titleV.tukou_addTapGesture(target: self, action: #selector(clickMusic))
        tufuh_ttitleV = titleV
        let musicIV = UIImageView.tukou_bjImageV(CGRect(x: 8, y: 8, width: 24, height: 24), superView: titleV, image: UIImage(named: "home_music"))
        musicIV.backgroundColor = TUOKOUXIUWhiteA10
        musicIV.layer.cornerRadius = 12
        musicIV.layer.masksToBounds = true
        
        let musicL = UILabel.tukou_bjLabel(CGRect(x: musicIV.frame.maxX + 8, y: 8, width: 120, height: 24), text: "东方禅境的艺术", superView: titleV, textAlignment: .left, font: TUOKOUXIUSwiftFont.medium(16), textColor: .white)
        
        let lineV = UIView.tukou_bjView(CGRect(x: musicL.frame.maxX + 8, y: 14, width: 1, height: 12), superView: titleV, bgColor: TUOKOUXIUWhiteA60)
        
        let nameL = UILabel.tukou_bjLabel(CGRect(x: lineV.frame.maxX + 14, y: 8, width: 120, height: 24), text: "艺术家：包玉树", superView: titleV, textAlignment: .left, font: TUOKOUXIUSwiftFont.regular(14), textColor: TUOKOUXIUWhiteA60)
        
        self.view.addSubview(self.tufuh_musicW!)
    }
    
    //点击展开类型
    @objc func clickTypeVOpen() {
        print("点击展开类型")
        tufuh_selectTypeV = TUOKOUXIUselectTypeW(frame: self.view.bounds)
        self.view.addSubview(self.tufuh_selectTypeV!)
        let botV = UIView.tukou_bjView(CGRect(x: 20, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 10, width: 152, height: 196), superView: tufuh_selectTypeV!, bgColor: .black)
        botV.layer.cornerRadius = 28
        botV.layer.borderColor = TUOKOUXIUWhiteA20.cgColor
        botV.layer.borderWidth = 1
        tufuh_selectTypeV!.tukou_addTapGesture(target: self, action: #selector(clickCloseTypeUpdateV))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(clickCloseTypeUpdateV))
        pan.cancelsTouchesInView = false  // ⭐️ 关键：不拦截事件
        tufuh_selectTypeV!.addGestureRecognizer(pan)
        self.tufuh_scrV = UIScrollView.tukou_bjScrollV(
            CGRect(x: 0, y: 16, width: 152, height: 164),
            superView: botV,
            bgColor: TUOKOUXIUSwiftwuseC
        )
        self.tufuh_scrV.showsVerticalScrollIndicator = false
            
        for i in 0...TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray.count - 1 {
            let model:SceneModel = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray[i]
            let tufuh_string = model.sceneName
            let btnY = i * (32 + 12)
            let typeBtn = UIButton.tukou_bjBtn(CGRect(x: 16, y: btnY, width: 120, height: 32), target: self, image: UIImage(named: "sleep"), superView: self.tufuh_scrV, action: #selector(clickTypeUpdate(_:)))
            typeBtn.layer.cornerRadius = 16
            typeBtn.setImageTitleSpacing(4, shiftLeft: 16)

            typeBtn.setTitle(tufuh_string, for: .normal)
            typeBtn.titleLabel?.font = TUOKOUXIUSwiftFont.regular(14)
            typeBtn.tag = i
            if i == TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_selectNum {
                typeBtn.backgroundColor = TUOKOUXIUWhiteA20
            }
            if i == TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray.count - 1 {
                self.tufuh_scrV.contentSize = CGSize(width: 152, height: btnY + 32)
            }
        }
    }
    
    //点击更新类型
    @objc func clickCloseTypeUpdateV() {
        if (tufuh_selectTypeV != nil) {
            tufuh_selectTypeV?.isHidden = true
            tufuh_selectTypeV?.removeFromSuperview()
            tufuh_selectTypeV = nil
        }
    }
    
    //点击更新类型
    @objc func clickTypeUpdate(_ btn: UIButton) {
        if (tufuh_selectTypeV != nil) {
            tufuh_selectTypeV?.isHidden = true
            tufuh_selectTypeV?.removeFromSuperview()
            tufuh_selectTypeV = nil
        }
        if (tufuh_topSelectTypeV != nil) {
            clickCloseTopSelectTypeV()
        }
    }
    
    //点击收藏
    @objc func clickCollect(_ btn: UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            print("收藏")
        } else {
            print("取消收藏")
        }
    }
    
    //点击重载
    @objc func clickReplay() {
        print("点击重载")
    }
    
    //点击定时
    @objc func clickTime() {
        print("点击定时")
        NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUHidTabb"), object: nil)
        let picker = AlarmDurationPicker()
        picker.onConfirm = { minute in
            NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShoTabb"), object: nil)
            self.tufuh_timerBtn?.setImage(UIImage(named: "home_timer_selected"), for: .normal)
            // 总秒数
            self.countdownRemainingSeconds = minute * 60
            // 设置初始显示
            let timeString = self.formatMinuteToHHMMSS(minute)
            print("选择：\(minute) 分钟")
            self.tufuh_timerBtn!.setImageTitleSpacing(4, shiftLeft: 1)
            self.tufuh_timerBtn!.setTitle(timeString, for: .normal)
            UIView.animate(withDuration: 0.25) {
                let intervalWidth = (335-20-40*4-105)/4
                let timeBtnX = 335/2-105/2
                self.tufuh_replayBtn?.frame = CGRect(x: timeBtnX-intervalWidth-40, y: 20, width: 40, height: 40)
                self.tufuh_timerBtn?.frame = CGRect(x: timeBtnX, y: 16, width: 105, height: 48)
                self.tufuh_blockingBtn?.frame = CGRect(x: timeBtnX+105+intervalWidth, y: 20, width: 40, height: 40)
            }
            // 启动倒计时
            self.startCountdown()
        }
        picker.onCancel = {
            NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShoTabb"), object: nil)
            print("点击取消")
        }
        picker.onDismissByPan = {
            NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShoTabb"), object: nil)
            print("下滑销毁浮层回调")
        }
        picker.show(in: self.view)
    }
    
    func startCountdown() {
        countdownTimer?.invalidate()

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            self.countdownRemainingSeconds -= 1

            // 更新按钮标题
            let hours = self.countdownRemainingSeconds / 3600
            let minutes = (self.countdownRemainingSeconds % 3600) / 60
            let seconds = self.countdownRemainingSeconds % 60
            let timeString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            self.tufuh_timerBtn?.setTitle(timeString, for: .normal)

            // 倒计时结束
            if self.countdownRemainingSeconds <= 0 {
                self.countdownTimer?.invalidate()
                self.countdownTimer = nil
                self.resetTimerButton()
            }
        }

        // 防止 UI 卡更新
        RunLoop.current.add(countdownTimer!, forMode: .common)
    }
    
    func resetTimerButton() {
        self.tufuh_timerBtn?.setTitle("", for: .normal)
        self.tufuh_timerBtn?.setImage(UIImage(named: "home_timer_default"), for: .normal)

        UIView.animate(withDuration: 0.25) {
            let intervalWidth = (335-20-40*4-48)/4
            let timeBtnX = 335/2-48/2
            self.tufuh_replayBtn?.frame = CGRect(x: timeBtnX-intervalWidth-40, y: 20, width: 40, height: 40)
            self.tufuh_timerBtn?.frame = CGRect(x: timeBtnX, y: 16, width: 48, height: 48)
            self.tufuh_blockingBtn?.frame = CGRect(x: timeBtnX+48+intervalWidth, y: 20, width: 40, height: 40)
        }
    }
    
    func formatMinuteToHHMMSS(_ minute: Int) -> String {
        let totalSeconds = minute * 60
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    //点击拦截
    @objc func clickTiming() {
        print("点击拦截")
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.tufuh_topV?.addSubview(self.tufuh_pageTitV)
        }
        tukou_topVi()
    }

    lazy var tufuh_pageTitV: TUOKOUXIUSwiftPagTitV = {

        var tufuh_arr = [String]()
        for model in TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray {
            let name = model.sceneName
            tufuh_arr.append(name)

        }
        
        let tufuh_conf = TUOKOUXIUSwiftPagTitVConf.tukou_pageTitVCon()
//        tufuh_conf.tufuh_titGradiEffe = true
        tufuh_conf.tufuh_titClr = TUOKOUXIUWhiteA40
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

        tufuh_conf.tufuh_titFont = TUOKOUXIUSwiftFont.semibold(16)
        tufuh_conf.tufuh_titSeleFon = TUOKOUXIUSwiftFont.semibold(20)
        pageTitV = TUOKOUXIUSwiftPagTitV.tukou_pageTitVWithFra(frame:
            CGRect(x: 20, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight+12, width: TUOKOUXIUSwiftSCRE_W - 20 - 64, height: 32),
            delegate: self,
            titleNames: tufuh_arr,
            configure: tufuh_conf
        )
        
        pageTitV.backgroundColor = TUOKOUXIUSwiftwuseC
        return pageTitV
    }()
    
    lazy var tufuh_pageContScrV: TUOKOUXIUSwiftPagContScrV = {
        var childVCs: [UIViewController] = []
        
        let urls = [
            URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/gear1/prog_index.m3u8")!,
            URL(string: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8")!,
            URL(string: "https://test-streams.mux.dev/pts_shift/master.m3u8")!,
            URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/gear1/prog_index.m3u8")!
        ]
        let urls2 = [
            URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3")!,
            URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")!,
            URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3")!,
            URL(string: "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/no_curator/Owl/Epic_Nature_Sounds/Owl_-_Ocean_Waves.mp3")!
        ]
        for (i, item) in TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray.enumerated() {
            let v1 = HomeSubVC(videoURL: urls[i], audioURL: urls2[i])
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
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_selectNum = selectedIndex
        self.tufuh_pageContScrV.tukou_pageContScrVCurrInd(selectedIndex)
    }

    func tukou_pageContScrV(_ pageContentScrollView: TUOKOUXIUSwiftPagContScrV, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_selectNum = targetIndex
        self.tufuh_pageTitV.tukou_pageTitVWithPro(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }

    func tukou_topVi() {
        self.tufuh_topV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 48), superView: self.view, bgColor: TUOKOUXIUSwiftwuseC)
        self.tufuh_topIV = UIImageView.tukou_bjImageV(CGRect(x: 0, y: 0, width: Int(TUOKOUXIUSwiftSCRE_W), height: Int(TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight) + 48), superView: self.view, image: UIImage(named: "home_top_shadow"))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [self] in
            self.tufuh_homeSceneBtn = UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W-24-20, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight+16, width: 24, height: 24), target: self, image: UIImage(named: "home_scene"), superView: self.tufuh_topV!, action: #selector(tukou_zhankai))
            self.tufuh_homeSceneBtn?.tukou_setEnlargeEdge(10)
        }
        
        self.tufuh_botIV = UIImageView.tukou_bjImageV(CGRect(x: 0, y: Int(TUOKOUXIUSwiftSCRE_H) - 240, width: Int(TUOKOUXIUSwiftSCRE_W), height: 240), superView: self.view, image: UIImage(named: "home_bot_shadow"))
    }
    
    @objc func tukou_zhankai() {
        print("点击展开 头标题类型")
        NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUHidTabb"), object: nil)
        if let topV = self.tufuh_topSelectTypeV {
            topV.removeFromSuperview()
            self.tufuh_topSelectTypeV = nil
        }
        tufuh_topSelectTypeV = UIView.tukou_bjView(CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H), superView: self.view, bgColor: .black)
        
        tufuh_topSelectTypeV!.tukou_addTapGesture(target: self, action: #selector(clickCloseTopSelectTypeV))
        tufuh_container = UIView.tukou_bjView(CGRect(x: 0, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight+12, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H-(TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight+12)), superView: tufuh_topSelectTypeV!, bgColor: TUOKOUXIUWhiteA10)
        
        tufuh_container!.layer.cornerRadius = 32
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        pan.cancelsTouchesInView = false
        tufuh_container!.addGestureRecognizer(pan)
        
        let tufuh_scrTypeV = UIScrollView.tukou_bjScrollV(
            CGRect(x: 20, y: 30, width: TUOKOUXIUSwiftSCRE_W - 70, height: TUOKOUXIUSwiftSCRE_H-(TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight+12)-30),
            superView: tufuh_container!,
            bgColor: TUOKOUXIUSwiftwuseC
        )
        tufuh_scrTypeV.showsVerticalScrollIndicator = false

        let dianV = UIView.tukou_bjView(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-18, y: 12, width: 36, height: 6), superView: tufuh_container!, bgColor: TUOKOUXIUWhiteA60)
        dianV.layer.cornerRadius = 3
            
        for i in 0...TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray.count - 1 {
            let model:SceneModel = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray[i]
            let tufuh_string = model.sceneName
            let btnY = 30 + i * (48 + 20)
            let typeV = UIView.tukou_bjView(CGRect(x: 0, y: btnY, width: Int(TUOKOUXIUSwiftSCRE_W), height: 48), superView: tufuh_scrTypeV, bgColor: TUOKOUXIUSwiftwuseC)
            typeV.tukou_addTapGesture(target: self, action: #selector(clickTypeUpdate(_:)))
            let typeIconIV = UIImageView.tukou_bjImageV(CGRect(x: 20, y: 0, width: 48, height: 48), superView: typeV, image: UIImage(named: "sleep"))
            typeIconIV.backgroundColor = TUOKOUXIUSwiftwuseC
            typeIconIV.layer.cornerRadius = 24
            typeIconIV.layer.masksToBounds = true
            typeIconIV.layer.borderWidth = 1
            typeIconIV.layer.borderColor = TUOKOUXIUWhiteA10.cgColor
            let typeL = UILabel.tukou_bjLabel(CGRect(x: typeIconIV.frame.maxX + 10, y: 0, width: TUOKOUXIUSwiftSCRE_W-(typeIconIV.frame.maxX + 10)-20, height: 48), text: tufuh_string, superView: typeV, textAlignment: .left, font: TUOKOUXIUSwiftFont.regular(16), textColor: TUOKOUXIUWhiteA60)
            if i == TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_selectNum {
                typeIconIV.backgroundColor = TUOKOUXIUWhiteA10
                typeIconIV.layer.borderWidth = 0
                typeL.textColor = .white
            }
            if i == TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray.count - 1 {
                tufuh_scrTypeV.contentSize = CGSize(width: CGFloat(TUOKOUXIUSwiftSCRE_W - 70), height: CGFloat(btnY) + 48)
            }
        }
        
        UIImageView.tukou_bjImageV(CGRect(x: 0, y: Int(TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight), width: Int(TUOKOUXIUSwiftSCRE_W), height: 60), superView: tufuh_topSelectTypeV!, image: UIImage(named: "home_top_shadow"))
        UIImageView.tukou_bjImageV(CGRect(x: 0, y: Int(TUOKOUXIUSwiftSCRE_H) - 80, width: Int(TUOKOUXIUSwiftSCRE_W), height: 80), superView: tufuh_topSelectTypeV!, image: UIImage(named: "home_bot_shadow"))
        UIView.animate(withDuration: 0.25) {
            self.tufuh_topSelectTypeV!.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H)
        }
    }
    
    @objc private func handlePan(_ ges: UIPanGestureRecognizer) {
        let translation = ges.translation(in: tufuh_container)
        switch ges.state {
        case .changed:
            if translation.y > 0 {
                tufuh_container!.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended, .cancelled:
            if translation.y > 100 {
                dismissByPan()
            } else {
                UIView.animate(withDuration: 0.25) { self.tufuh_container!.transform = .identity }
            }
        default: break
        }
    }
    
    private func dismissByPan() {
        UIView.animate(withDuration: 0.25, animations: {
            self.tufuh_container!.frame.origin.y = TUOKOUXIUSwiftSCRE_H
        }) { _ in
            self.tufuh_container!.removeFromSuperview()
            self.tufuh_container = nil
            self.tufuh_topSelectTypeV!.removeFromSuperview()
            self.tufuh_topSelectTypeV = nil
            NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShoTabb"), object: nil)
        }
    }
    
    @objc func clickCloseTopSelectTypeV() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.tufuh_topSelectTypeV!.frame = CGRect(x: 0, y: TUOKOUXIUSwiftSCRE_H, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H)
        }) { _ in
            self.tufuh_container!.removeFromSuperview()
            self.tufuh_container = nil
            self.tufuh_topSelectTypeV!.removeFromSuperview()
            self.tufuh_topSelectTypeV = nil
            NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShoTabb"), object: nil)
        }
    }

    func tukou_noNetwV() {
        guard self.tufuh_noNetV == nil else { return }

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
                             action: #selector(tukou_clickRefresh2),
                             font: TUOKOUXIUSwiftFont.semibold(14),
                             title: "重试",
                             color: TUOKOUXIUSwiftbaiseC,
                             bgColor: TUOKOUXIUWhiteA10,
                             cornerRadius: 12)
    }

}
