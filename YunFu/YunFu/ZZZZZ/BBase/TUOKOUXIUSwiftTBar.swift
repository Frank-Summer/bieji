
import Foundation
import Kingfisher
import Combine
import UIKit

class TUOKOUXIUSwiftTBar: UIViewController {
    
    var tufuh_tabbVCArr: [UIViewController] = []
    var tufuh_updaW: TUOKOUXIUAppUpdW?
    var tufuh_appUrl: String?
    var tufuh_isFirL = false
    var tufuh_isGTTabH = false
    var tufuh_isShoAd = false
    var tufuh_mDict: [String: Any]?
    var tufuh_indexNum: Int = 0
    var tufuh_tabBV: UIView!
    var tufuh_tabButArr: [UIButton] = []
    var tufuh_contV: UIView!
    var tufuh_selInd: Int = -1
    var tufuh_catheDict: [Int: UIViewController] = [:]
    private var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUShuaXinTabb"))
            .sink { [weak self] _ in self?.tukou_shuaXTabb() }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUAppUpdate"))
            .sink { [weak self] notif in self?.tukou_appUpdate(notif) }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUHidTabb"))
            .sink { [weak self] _ in self?.tukou_hidTabb() }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUShoTabb"))
            .sink { [weak self] _ in self?.tukou_shoTabb() }
            .store(in: &cancellables)

        tufuh_selInd = -1
        tukou_setTabBar()
        tukou_setContainerV()
        tukou_swiToVCAtInd(0)
    }
    
    private func tukou_setTabBar() {
        let tabHeight = TUOKOUXIUDeviceInfo.tukou_tabBarHeight
        tufuh_tabBV = UIView(frame: CGRect(x: 0, y: view.bounds.height - tabHeight, width: view.bounds.width, height: tabHeight))
        tufuh_tabBV.backgroundColor = TUOKOUXIUSwiftbaiseC
        view.addSubview(tufuh_tabBV)
        tufuh_tabButArr = []
    }
    
    
    private func tukou_setContainerV() {
        tufuh_contV = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - tufuh_tabBV.bounds.height))
        view.addSubview(tufuh_contV)
    }
    
    func tukou_swiToVCAtInd(_ index: Int) {
        guard index >= 0 && index < tufuh_tabbVCArr.count else { return }
        if index == tufuh_selInd { return }

        if tufuh_selInd != -1 {
            let currentVC = tufuh_tabbVCArr[tufuh_selInd]
            currentVC.willMove(toParent: nil)
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }

        let nextVC = tukou_cachedVCAtInd(index)
        nextVC.view.frame = tufuh_contV.bounds
        tufuh_contV.addSubview(nextVC.view)
        addChild(nextVC)
        nextVC.didMove(toParent: self)

        for button in tufuh_tabButArr {
            button.isSelected = button.tag == index
        }

        tufuh_selInd = index
    }
    
    func tukou_cachedVCAtInd(_ index: Int) -> UIViewController {
        if let vc = tufuh_catheDict[index] { return vc }
        let vc = tufuh_tabbVCArr[index]
        tufuh_catheDict[index] = vc
        return vc
    }
    
    func tukou_setTabBTitArr(_ titArr: [String], texClr: UIColor, selTexClr: UIColor, barBgClr: UIColor) {
        let tufuh_count = titArr.count
        let tufuh_btnW = self.view.bounds.width / CGFloat(tufuh_count)
        let tufuh_btnH = self.tufuh_tabBV.bounds.height

        for i in 0..<tufuh_count {
            let tufuh_btn = UIButton(type: .custom)
            tufuh_btn.frame = CGRect(x: CGFloat(i) * tufuh_btnW, y: 0, width: tufuh_btnW, height: tufuh_btnH)

            tufuh_btn.setTitle(titArr[i], for: .normal)
            tufuh_btn.setTitleColor(texClr, for: .normal)
            tufuh_btn.setTitleColor(selTexClr, for: .selected)

            switch i {
            case 0:
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_ite_off", andIsOne: false), for: .normal)
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_ite_on", andIsOne: false), for: .selected)
            case 1:
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_tas_ite_off", andIsOne: false), for: .normal)
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_tas_ite_on", andIsOne: false), for: .selected)
            case 2:
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_vp_ite_off", andIsOne: false), for: .normal)
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_vp_ite_on", andIsOne: false), for: .selected)
            case 3:
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_ite_off", andIsOne: false), for: .normal)
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_ite_on", andIsOne: false), for: .selected)
            default:
                break
            }

            tufuh_btn.titleLabel?.font = TUOKOUXIUSwiftFont.light(10)
            tufuh_btn.titleLabel?.textAlignment = .center
            tufuh_btn.imageView?.contentMode = .scaleAspectFit

            let tufuh_spac: CGFloat = 2.0
            let tufuh_imgS = tufuh_btn.imageView?.frame.size ?? .zero
            let tufuh_titS = tufuh_btn.titleLabel?.frame.size ?? .zero

            tufuh_btn.imageEdgeInsets = UIEdgeInsets(top: -tufuh_titS.height - tufuh_spac, left: 0, bottom: 0, right: -tufuh_titS.width)
            tufuh_btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -tufuh_imgS.width, bottom: -tufuh_imgS.height - tufuh_spac, right: 0)

            if TUOKOUXIUSwiftConstIX.isIPhoneXOrLater() {
                tufuh_btn.contentEdgeInsets = UIEdgeInsets(top: -15, left: 0, bottom: 15, right: 0)
            }

            tufuh_btn.addTarget(self, action: #selector(tukou_tabButTap(_:)), for: .touchUpInside)
            tufuh_btn.tag = i

            self.tufuh_tabBV.addSubview(tufuh_btn)
            self.tufuh_tabButArr.append(tufuh_btn)

            if i == 0 {
                tufuh_btn.isSelected = true
            }
        }

        self.tufuh_tabBV.backgroundColor = barBgClr
    }
    
    @objc func tukou_tabButTap(_ sender: UIButton) {
        
        let tufuh_index = sender.tag
        tukou_swiToVCAtInd(tufuh_index)
        
        tufuh_indexNum = sender.tag
    }
    
    func tukou_hidTabb() {
        var f = tufuh_tabBV.frame
        guard f.origin.y != view.frame.height else { return }
        f.origin.y = view.frame.height
        tufuh_tabBV.frame = f
        tufuh_contV.frame = view.bounds
    }

    func tukou_shoTabb() {
        var f = tufuh_tabBV.frame
        guard f.origin.y != view.frame.height - TUOKOUXIUDeviceInfo.tukou_tabBarHeight else { return }
        f.origin.y = view.frame.height - TUOKOUXIUDeviceInfo.tukou_tabBarHeight
        tufuh_tabBV.frame = f
        tufuh_contV.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - TUOKOUXIUDeviceInfo.tukou_tabBarHeight)
    }
    
    func tukou_appUpdate(_ notification: Notification) {
        guard let dict = notification.object as? [String: Any] else { return }

        let appUrl = dict["appUrl"] as? String
        let updateInfo = dict["appUpdateInfo"] as? String ?? ""
        let imageUrl = dict["appImageUrl"] as? String

        let centerW: CGFloat = 300
        let centerH: CGFloat = 440

        let updateView = TUOKOUXIUAppUpdW(frame: view.bounds)
        let centerV = UIView(frame: CGRect(x: TUOKOUXIUSwiftSCRE_W/2 - centerW/2, y: TUOKOUXIUSwiftSCRE_H/2 - centerH/2, width: centerW, height: centerH))
        centerV.backgroundColor = TUOKOUXIUSwiftZTClr2
        centerV.layer.cornerRadius = 14
        centerV.clipsToBounds = true
        updateView.addSubview(centerV)

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: centerW, height: 190))
        centerV.addSubview(imageView)
        
        imageView.kf.setImage(with: URL(string: imageUrl ?? ""))

        UILabel.tukou_bjLabel(CGRect(x: 0, y: 190+25, width: centerW, height: 24), text: "Notice", superView: centerV, textAlignment: .center, font: TUOKOUXIUSwiftFont.semibold(18), textColor: TUOKOUXIUSwiftZTClr1A)

        UIButton.tukou_bjBtn(CGRect(x: centerW-36, y: 10, width: 26, height: 26), target: self, image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_sub_close", andIsOne: false), superView: centerV, action: #selector(tukou_closWind))

        self.tufuh_appUrl = appUrl

        let contentLabel = UILabel.tukou_bjLabel(CGRect(x: 24, y: 190+55, width: centerW-48, height: 110), text: updateInfo, superView: centerV, textAlignment: .center, font: TUOKOUXIUSwiftFont.medium(14), textColor: TUOKOUXIUSwiftZTClr3A)
        contentLabel.numberOfLines = 0

        UIButton.tukou_bjBtn(CGRect(x: 24, y: 190+175, width: 252, height: 50), target: self, imageName: nil, superView: centerV, action: #selector(tukou_clkJuAppSto), font: TUOKOUXIUSwiftFont.semibold(16), title: "Download & Install", color: TUOKOUXIUSwiftbaiseC, bgColor: TUOKOUXIUSwiftZTClr, cornerRadius: 8)

        self.tufuh_updaW = updateView
        view.addSubview(updateView)
    }
    
    @objc func tukou_clkJuAppSto() {
        if let urlStr = tufuh_appUrl, let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }

    @objc func tukou_closWind() {
        if (tufuh_updaW != nil) {
            tufuh_updaW!.removeFromSuperview()
            tufuh_updaW = nil
        }
    }

    func tukou_shuaXTabb() {
        for (i, tufuh_btn) in self.tufuh_tabButArr.enumerated() {
            switch i {
            case 0:
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_ite_off", andIsOne: false), for: .normal)
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_ite_on", andIsOne: false), for: .selected)
            case 1:
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_tas_ite_off", andIsOne: false), for: .normal)
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_tas_ite_on", andIsOne: false), for: .selected)
            case 2:
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_vp_ite_off", andIsOne: false), for: .normal)
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_vp_ite_on", andIsOne: false), for: .selected)
            case 3:
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_ite_off", andIsOne: false), for: .normal)
                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_ite_on", andIsOne: false), for: .selected)
            default:
                break
            }

            tufuh_btn.titleLabel?.textAlignment = .center
            tufuh_btn.imageView?.contentMode = .scaleAspectFit

            let tufuh_spac: CGFloat = 2.0
            let tufuh_imgS = tufuh_btn.imageView?.frame.size ?? .zero
            let tufuh_titS = tufuh_btn.titleLabel?.frame.size ?? .zero

            tufuh_btn.imageEdgeInsets = UIEdgeInsets(top: -tufuh_titS.height - tufuh_spac,
                                                     left: 0,
                                                     bottom: 0,
                                                     right: -tufuh_titS.width)
            tufuh_btn.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                     left: -tufuh_imgS.width,
                                                     bottom: -tufuh_imgS.height - tufuh_spac,
                                                     right: 0)

            if TUOKOUXIUSwiftConstIX.isIPhoneXOrLater() {
                tufuh_btn.contentEdgeInsets = UIEdgeInsets(top: -15, left: 0, bottom: 15, right: 0)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let top = presentedViewController as? UINavigationController {
            return top.topViewController?.supportedInterfaceOrientations ?? .portrait
        } else if presentedViewController is TUOKOUXIUSwiftTBar || presentedViewController == nil {
            return presentedViewController?.supportedInterfaceOrientations ?? .portrait
        } else {
            return .portrait
        }
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}
