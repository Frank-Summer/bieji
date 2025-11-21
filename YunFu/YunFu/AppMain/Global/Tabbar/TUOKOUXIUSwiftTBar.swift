
import Foundation
import Kingfisher
import Combine
import UIKit

class TUOKOUXIUSwiftTBar: UIViewController {
    
    var tufuh_tabbVCArr: [UIViewController] = []
    
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

//        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUShuaXinTabb"))
//            .sink { [weak self] _ in self?.tukou_shuaXTabb() }
//            .store(in: &cancellables)
        
        
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUHidTabb"))
            .sink { [weak self] _ in self?.tukou_hidTabb() }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUShoTabb"))
            .sink { [weak self] _ in self?.tukou_shoTabb() }
            .store(in: &cancellables)

        tufuh_selInd = -1
        tukou_setTabBar()
        tukou_setContainerV()
        tukou_swiToVCAtInd(1)
        self.tukou_setTabBTitArr(
                    ["Home", "Explore", "My"],
                    texClr: UIColor.TUOKOUXIUSSRGB(r: 144, g: 147, b: 153),
                    selTexClr: TUOKOUXIUSwiftbaiseC,
                    barBgClr: .clear
                )
    }
    
    private func tukou_setTabBar() {
        let tabHeight = TUOKOUXIUDeviceInfo.tukou_tabBarHeight+30
        tufuh_tabBV = UIView(frame: CGRect(x: 0, y: view.bounds.height - tabHeight, width: view.bounds.width, height: tabHeight))
        tufuh_tabBV.backgroundColor = .blue
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

        for i in 0..<tufuh_count {
            let tufuh_btn = UIButton(type: .custom)

            switch i {
            case 0:
                tufuh_btn.frame = CGRect(x: 40, y: 20, width: 40, height: 40)
                tufuh_btn.layer.cornerRadius = 20
                let off = UIImage(named: "tab_explore_default")
                let on = UIImage(named: "tab_explore_select")
                tufuh_btn.setImage((off), for: .normal)
                tufuh_btn.setImage((on), for: .selected)
            case 1:
                tufuh_btn.frame = CGRect(x: TUOKOUXIUSwiftSCRE_W/2-60/2, y: 10, width: 60, height: 60)
                tufuh_btn.backgroundColor = .gray
                tufuh_btn.layer.cornerRadius = 30
                let off = UIImage(named: "tab_home_stop")
                let on = UIImage(named: "tab_home_play")
                tufuh_btn.setImage((off), for: .normal)
                tufuh_btn.setImage((on), for: .selected)
            case 2:
                tufuh_btn.frame = CGRect(x: TUOKOUXIUSwiftSCRE_W-40-40, y: 20, width: 40, height: 40)
                tufuh_btn.layer.cornerRadius = 20
                let off = UIImage(named: "tab_my_default")
                let on = UIImage(named: "tab_my_select")
                tufuh_btn.setImage((off), for: .normal)
                tufuh_btn.setImage((on), for: .selected)
            default:
                break
            }

            tufuh_btn.addTarget(self, action: #selector(tukou_tabButTap(_:)), for: .touchUpInside)
            tufuh_btn.tag = i

            self.tufuh_tabBV.addSubview(tufuh_btn)
            self.tufuh_tabButArr.append(tufuh_btn)

            //默认选中第二个btn
            if i == 1 {
                tufuh_btn.isSelected = true
            }
        }

        self.tufuh_tabBV.backgroundColor = .clear
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
        guard f.origin.y != view.frame.height - TUOKOUXIUDeviceInfo.tukou_tabBarHeight-30 else { return }
        f.origin.y = view.frame.height - TUOKOUXIUDeviceInfo.tukou_tabBarHeight-30
        tufuh_tabBV.frame = f
        tufuh_contV.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - TUOKOUXIUDeviceInfo.tukou_tabBarHeight-30)
    }

//    func tukou_shuaXTabb() {
//        for (i, tufuh_btn) in self.tufuh_tabButArr.enumerated() {
//            switch i {
//            case 0:
//                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_ite_off", andIsOne: false), for: .normal)
//                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_ite_on", andIsOne: false), for: .selected)
//            case 1:
//                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_tas_ite_off", andIsOne: false), for: .normal)
//                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_tas_ite_on", andIsOne: false), for: .selected)
//            case 2:
//                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_ite_off", andIsOne: false), for: .normal)
//                tufuh_btn.setImage(TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_ite_on", andIsOne: false), for: .selected)
//            default:
//                break
//            }
//
//            tufuh_btn.titleLabel?.textAlignment = .center
//            tufuh_btn.imageView?.contentMode = .scaleAspectFit
//
//            let tufuh_spac: CGFloat = 2.0
//            let tufuh_imgS = tufuh_btn.imageView?.frame.size ?? .zero
//            let tufuh_titS = tufuh_btn.titleLabel?.frame.size ?? .zero
//
//            tufuh_btn.imageEdgeInsets = UIEdgeInsets(top: -tufuh_titS.height - tufuh_spac,
//                                                     left: 0,
//                                                     bottom: 0,
//                                                     right: -tufuh_titS.width)
//            tufuh_btn.titleEdgeInsets = UIEdgeInsets(top: 0,
//                                                     left: -tufuh_imgS.width,
//                                                     bottom: -tufuh_imgS.height - tufuh_spac,
//                                                     right: 0)
//
//            if TUOKOUXIUSwiftConstIX.isIPhoneXOrLater() {
//                tufuh_btn.contentEdgeInsets = UIEdgeInsets(top: -15, left: 0, bottom: 15, right: 0)
//            }
//        }
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
