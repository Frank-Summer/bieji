
import Foundation
import Kingfisher
import Combine
import UIKit

class TUOKOUXIUSwiftTBar: UIViewController {
    
    var tufuh_tabbVCArr: [UIViewController] = []
    var tufuh_mDict: [String: Any]?
    var tufuh_indexNum: Int = 0
    var tufuh_tabBV: UIView!
    var tufuh_tabCenterBtn: UIButton?
    var tufuh_rightBtn: UIButton?
    var tufuh_tabButArr: [UIButton] = []
    var tufuh_contV: UIView!
    var tufuh_selInd: Int = -1
    var tufuh_catheDict: [Int: UIViewController] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUHidTabb"))
            .sink { [weak self] _ in self?.tukou_hidTabb() }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUShoTabb"))
            .sink { [weak self] _ in self?.tukou_shoTabb() }
            .store(in: &cancellables)

        tufuh_selInd = -1
        tukou_setTabBar()
        tukou_setContainerV()

        self.tukou_setTabBTitArr(
                    ["Home", "Explore", "My"],
                    texClr: UIColor.TUOKOUXIUSSRGB(r: 144, g: 147, b: 153),
                    selTexClr: TUOKOUXIUSwiftbaiseC,
                    barBgClr: TUOKOUXIUSwiftwuseC
                )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bringSubviewToFront(tufuh_tabBV)
    }
    
    private func tukou_setTabBar() {
        let tabHeight = TUOKOUXIUDeviceInfo.tukou_tabBarHeight + 30
        tufuh_tabBV = UIView(
            frame: CGRect(x: 0,
                          y: view.bounds.height - tabHeight,
                          width: view.bounds.width,
                          height: tabHeight)
        )
        
        tufuh_tabBV.backgroundColor = TUOKOUXIUSwiftwuseC
        view.addSubview(tufuh_tabBV)
        tufuh_tabButArr = []
    }
    
    
    private func tukou_setContainerV() {
        tufuh_contV = UIView(frame: view.bounds)
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
            switch i {
            case 0:
                let tufuh_btn = JellyButton(frame: CGRect(x: 30, y: 18, width: 52, height: 52))
                let off = UIImage(named: "tab_explore_default")
                let on = UIImage(named: "tab_explore_select")
                tufuh_btn.setImage((off), for: .normal)
                tufuh_btn.setImage((on), for: .selected)
                tufuh_btn.setImage((on), for: .highlighted)
                tufuh_btn.addTarget(self, action: #selector(tukou_tabButTap(_:)), for: .touchUpInside)
                tufuh_btn.tag = i
                tufuh_btn.tukou_setEnlargeEdge(10)
                self.tufuh_tabBV.addSubview(tufuh_btn)
                self.tufuh_tabButArr.append(tufuh_btn)
            case 1:
                let tufuh_btn = UIButton(type: .custom)
                tufuh_btn.backgroundColor = TUOKOUXIUWhiteA60
                tufuh_btn.frame = CGRect(x: TUOKOUXIUSwiftSCRE_W/2-60/2, y: 10, width: 60, height: 60)
                tufuh_btn.layer.cornerRadius = 30
                let off = UIImage(named: "tab_home_stop")
                let on = UIImage(named: "tab_home_play")
                tufuh_btn.setImage((off), for: .normal)
                tufuh_btn.setImage((on), for: .selected)
                tufuh_btn.addTarget(self, action: #selector(tukou_tabButTap(_:)), for: .touchUpInside)
                tufuh_btn.tag = i
                tufuh_btn.tukou_setEnlargeEdge(10)
                self.tufuh_tabBV.addSubview(tufuh_btn)
                self.tufuh_tabButArr.append(tufuh_btn)
                //默认选中第二个btn
                tufuh_btn.isSelected = true
                tufuh_indexNum = 1
                tukou_swiToVCAtInd(1)
                tufuh_tabCenterBtn = UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-207/2, y: 18, width: 207, height: 52), target: self, title: nil, superView: self.tufuh_tabBV, action: #selector(clicktabCenterBtn))
                tufuh_tabCenterBtn?.backgroundColor = TUOKOUXIUWhiteA60
                tufuh_tabCenterBtn?.isHidden = true
                tufuh_tabCenterBtn?.layer.borderColor = TUOKOUXIUWhiteA10.cgColor
                tufuh_tabCenterBtn?.layer.borderWidth = 1
                tufuh_tabCenterBtn?.layer.cornerRadius = 26
                
                let leftIV = UIImageView.tukou_bjImageV(CGRect(x: 6, y: 6, width: 40, height: 40), superView: tufuh_tabCenterBtn!, image: UIImage(named: "sleep"))
                
                tufuh_rightBtn = UIButton.tukou_bjBtn(CGRect(x: 207-6-40, y: 6, width: 40, height: 40), target: self, image: UIImage(named: "tab_home_play"), superView: tufuh_tabCenterBtn!, action: #selector(clickPlayAndPause))
                tufuh_rightBtn!.setImage((off), for: .selected)
                
                let topTitleL = UILabel.tukou_bjLabel(CGRect(x: leftIV.frame.maxX + 12, y: leftIV.frame.minY + 3, width: 42, height: 17), text: "瑜伽0", superView: tufuh_tabCenterBtn!, textAlignment: .center, font: TUOKOUXIUSwiftFont.medium(14), textColor: .white)
                
                let botTitleL = UILabel.tukou_bjLabel(CGRect(x: leftIV.frame.maxX + 12, y: topTitleL.frame.maxY, width: 48, height: 17), text: "东方禅境", superView: tufuh_tabCenterBtn!, textAlignment: .center, font: TUOKOUXIUSwiftFont.regular(12), textColor: .white)
                _ = UIImageView.tukou_bjImageV(CGRect(x: botTitleL.frame.maxX + 3, y: topTitleL.frame.maxY + 0.5, width: 16, height: 16), superView: tufuh_tabCenterBtn!, image: UIImage(named: "sleep"))
            case 2:
                let tufuh_btn = JellyButton(frame: CGRect(x: TUOKOUXIUSwiftSCRE_W-30-52, y: 18, width: 52, height: 52))
                let off = UIImage(named: "tab_my_default")
                let on = UIImage(named: "tab_my_select")
                tufuh_btn.setImage((off), for: .normal)
                tufuh_btn.setImage((on), for: .selected)
                tufuh_btn.setImage((on), for: .highlighted)
                tufuh_btn.addTarget(self, action: #selector(tukou_tabButTap(_:)), for: .touchUpInside)
                tufuh_btn.tag = i
                tufuh_btn.tukou_setEnlargeEdge(10)
                self.tufuh_tabBV.addSubview(tufuh_btn)
                self.tufuh_tabButArr.append(tufuh_btn)
            default:
                break
            }
        }
        self.tufuh_tabBV.backgroundColor = TUOKOUXIUSwiftwuseC
    }
    
    @objc func clickPlayAndPause() {
        tufuh_rightBtn?.isSelected = !tufuh_rightBtn!.isSelected
        if tufuh_rightBtn?.isSelected == true {
            print("暂停")
            NotificationCenter.default.post(
                name: Notification.Name("TUOKOUXIUAudioPause"),
                object: nil
            )
        } else {
            print("播放")
            NotificationCenter.default.post(
                name: Notification.Name("TUOKOUXIUAudioPlay"),
                object: nil
            )
        }
    }
    
    @objc func clicktabCenterBtn() {
        tukou_swiToVCAtInd(1)
        
        for (i, tufuh_btn) in self.tufuh_tabButArr.enumerated() {
            switch i {
            case 0:
                tufuh_btn.isSelected = false
            case 1:
                //果冻效果缩小
                btnChangesSmall(tufuh_btn)
            case 2:
                tufuh_btn.isSelected = false
            default:
                break
            }
        }

        tufuh_indexNum = 1
    }
    
    func addScaAnimToBut(_ button: UIButton) {
        let ani = CAKeyframeAnimation(keyPath: "transform.scale")
        ani.values = [1.0, 1.3, 0.9, 1.15, 0.95, 1.02, 1.0]
        ani.duration = 0.65
        ani.repeatCount = 0
        ani.calculationMode = .cubic
        button.layer.add(ani, forKey: nil)
    }
    
    @objc func tukou_tabButTap(_ sender: UIButton) {
        if sender.tag != tufuh_indexNum {
            addScaAnimToBut(sender)
        }

        if sender.tag == 0 {
            if tufuh_indexNum == sender.tag { return }
            sender.isSelected = !sender.isSelected
            let tufuh_btn2 = self.tufuh_tabButArr[2]
            tufuh_btn2.isSelected = !tufuh_btn2.isSelected
            if tufuh_indexNum != 2 {
                //果冻效果放大
                btnChangesBig()
            }
        } else if sender.tag == 1 {
            sender.isSelected = !sender.isSelected
            if sender.isSelected {
                print("播放")
                NotificationCenter.default.post(
                    name: Notification.Name("TUOKOUXIUAudioPlay"),
                    object: nil
                )
            } else {
                print("暂停")
                NotificationCenter.default.post(
                    name: Notification.Name("TUOKOUXIUAudioPause"),
                    object: nil
                )
            }
            let tufuh_btn0 = self.tufuh_tabButArr[0]
            if tufuh_btn0.isSelected {
                tufuh_btn0.isSelected = !tufuh_btn0.isSelected
            }
            let tufuh_btn2 = self.tufuh_tabButArr[2]
            if tufuh_btn2.isSelected {
                tufuh_btn2.isSelected = !tufuh_btn2.isSelected
            }
        } else if sender.tag == 2 {
            if tufuh_indexNum == sender.tag { return }
            sender.isSelected = !sender.isSelected
            let tufuh_btn0 = self.tufuh_tabButArr[0]
            tufuh_btn0.isSelected = !tufuh_btn0.isSelected
            if tufuh_indexNum != 0 {
                //果冻效果放大
                btnChangesBig()
            }
        }
        tukou_swiToVCAtInd(sender.tag)
        tufuh_indexNum = sender.tag
    }
    
    func btnChangesBig() {
        let tufuh_btn = self.tufuh_tabButArr[1]
        tufuh_btn.isHidden = true
        tufuh_tabCenterBtn?.isHidden = false
        tufuh_tabCenterBtn?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) // 缩小一点
        tufuh_tabCenterBtn?.layoutIfNeeded() // 确保渲染

        UIView.animate(withDuration: 0.35,        // 总时长略长，便于弹动更明显
                       delay: 0,
                       usingSpringWithDamping: 0.07, // 阻尼更小 → 弹动更大
                       initialSpringVelocity: 2.2,  // 初速度大一点
                       options: [.curveEaseInOut],
                       animations: {
            self.tufuh_tabCenterBtn?.transform = .identity // 弹回
        })
    }
    
    func btnChangesSmall(_ tufuh_btn: UIButton) {
        tufuh_btn.isHidden = false
        tufuh_btn.isSelected = !tufuh_rightBtn!.isSelected
        self.tufuh_tabCenterBtn?.isHidden = true
        tufuh_btn.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) // 缩小一点
        UIView.animate(withDuration: 0.55,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 1.0,
                       options: [.curveEaseInOut],
                       animations: {
            tufuh_btn.transform = .identity // 弹回
        })
    }
    
    func tukou_hidTabb() {
        tufuh_tabBV.frame.origin.y = view.bounds.height
        tufuh_contV.frame = view.bounds  // 保持全屏
    }

    func tukou_shoTabb() {
        let tabH = tufuh_tabBV.bounds.height
        tufuh_tabBV.frame.origin.y = view.bounds.height - tabH
        tufuh_contV.frame = view.bounds
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
