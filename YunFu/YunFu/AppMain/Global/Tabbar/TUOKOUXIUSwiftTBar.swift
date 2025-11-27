
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
//        tukou_swiToVCAtInd(1)
        self.tukou_setTabBTitArr(
                    ["Home", "Explore", "My"],
                    texClr: UIColor.TUOKOUXIUSSRGB(r: 144, g: 147, b: 153),
                    selTexClr: TUOKOUXIUSwiftbaiseC,
                    barBgClr: .clear
                )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        let tabH = TUOKOUXIUDeviceInfo.tukou_tabBarHeight + 30
//        tufuh_tabBV.frame = CGRect(
//            x: 0,
//            y: view.bounds.height - tabH,
//            width: view.bounds.width,
//            height: tabH
//        )
        
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
        
        tufuh_tabBV.backgroundColor = .clear     // 透明
        
        view.addSubview(tufuh_tabBV)
        tufuh_tabButArr = []
    }
    
    
    private func tukou_setContainerV() {
        tufuh_contV = UIView(frame: view.bounds)   // 全屏
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
                let tufuh_btn = UIButton(type: .custom)
                tufuh_btn.backgroundColor = TUOKOUXIUSwiftZTClr3A
                tufuh_btn.frame = CGRect(x: 30, y: 18, width: 52, height: 52)
                tufuh_btn.layer.cornerRadius = 26
                let off = UIImage(named: "tab_explore_default")
                let on = UIImage(named: "tab_explore_select")
                tufuh_btn.setImage((off), for: .normal)
                tufuh_btn.setImage((on), for: .selected)
                tufuh_btn.addTarget(self, action: #selector(tukou_tabButTap(_:)), for: .touchUpInside)
                tufuh_btn.tag = i
                tufuh_btn.tukou_setEnlargeEdge(10)
                self.tufuh_tabBV.addSubview(tufuh_btn)
                self.tufuh_tabButArr.append(tufuh_btn)
            case 1:
                let tufuh_btn = UIButton(type: .custom)
                tufuh_btn.backgroundColor = TUOKOUXIUSwiftZTClr3A
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
                tufuh_tabCenterBtn = UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-1/2, y: 18, width: 1, height: 52), target: self, title: nil, superView: self.tufuh_tabBV, action: #selector(clicktabCenterBtn))
                tufuh_tabCenterBtn?.backgroundColor = TUOKOUXIUSwiftZTClr3A
                tufuh_tabCenterBtn?.isHidden = true
                tufuh_tabCenterBtn?.layer.borderColor = TUOKOUXIUSwiftZTClr5A.cgColor
                tufuh_tabCenterBtn?.layer.borderWidth = 1
                tufuh_tabCenterBtn?.layer.cornerRadius = 26
                
                let leftIV = UIImageView.tukou_bjImageV(CGRect(x: 6, y: 6, width: 40, height: 40), superView: tufuh_tabCenterBtn!, image: UIImage(named: "sleep"))
                
                let rightIV = UIImageView.tukou_bjImageV(CGRect(x: 207-6-40, y: 6, width: 40, height: 40), superView: tufuh_tabCenterBtn!, image: UIImage(named: "tab_home_play"))
                rightIV.contentMode = .center
                
                let topTitleL = UILabel.tukou_bjLabel(CGRect(x: leftIV.frame.maxX + 12, y: leftIV.frame.minY + 3, width: 42, height: 17), text: "瑜伽0", superView: tufuh_tabCenterBtn!, textAlignment: .center, font: TUOKOUXIUSwiftFont.medium(14), textColor: .white)
                
                let botTitleL = UILabel.tukou_bjLabel(CGRect(x: leftIV.frame.maxX + 12, y: topTitleL.frame.maxY, width: 48, height: 17), text: "东方禅境", superView: tufuh_tabCenterBtn!, textAlignment: .center, font: TUOKOUXIUSwiftFont.regular(12), textColor: .white)
                _ = UIImageView.tukou_bjImageV(CGRect(x: botTitleL.frame.maxX + 3, y: topTitleL.frame.maxY + 0.5, width: 16, height: 16), superView: tufuh_tabCenterBtn!, image: UIImage(named: "sleep"))
            case 2:
                let tufuh_btn = UIButton(type: .custom)
                tufuh_btn.backgroundColor = TUOKOUXIUSwiftZTClr3A
                tufuh_btn.frame = CGRect(x: TUOKOUXIUSwiftSCRE_W-30-52, y: 18, width: 52, height: 52)
                tufuh_btn.layer.cornerRadius = 26
                let off = UIImage(named: "tab_my_default")
                let on = UIImage(named: "tab_my_select")
                tufuh_btn.setImage((off), for: .normal)
                tufuh_btn.setImage((on), for: .selected)
                tufuh_btn.addTarget(self, action: #selector(tukou_tabButTap(_:)), for: .touchUpInside)
                tufuh_btn.tag = i
                tufuh_btn.tukou_setEnlargeEdge(10)
                self.tufuh_tabBV.addSubview(tufuh_btn)
                self.tufuh_tabButArr.append(tufuh_btn)
            default:
                break
            }
        }
        self.tufuh_tabBV.backgroundColor = .clear
    }
    
    
    @objc func clicktabCenterBtn() {
        tukou_swiToVCAtInd(1)
        
        for (i, tufuh_btn) in self.tufuh_tabButArr.enumerated() {
            switch i {
            case 0:
                tufuh_btn.isSelected = false
            case 1:
                //果冻效果缩小
                self.animateChange(false)
                TUOKOUXIUSwiftDelaBlk(0.2) {
                    tufuh_btn.isHidden = false
                    self.tufuh_tabCenterBtn?.isHidden = true
                }
            case 2:
                tufuh_btn.isSelected = false
            default:
                break
            }
        }

        tufuh_indexNum = 1
    }
    
    @objc func tukou_tabButTap(_ sender: UIButton) {
        let tufuh_index = sender.tag
        tukou_swiToVCAtInd(tufuh_index)
        
        for (i, tufuh_btn) in self.tufuh_tabButArr.enumerated() {
            switch i {
            case 0:
                if tufuh_btn.tag == sender.tag {
                    tufuh_btn.isSelected = true
                } else {
                    tufuh_btn.isSelected = false
                }
            case 1:
                if sender.tag == 1 {
                    tufuh_btn.isSelected = !tufuh_btn.isSelected
                } else {
                    tufuh_btn.isHidden = true
                    //果冻效果放大
                    tufuh_tabCenterBtn?.isHidden = false
                    self.animateChange(true)
                }
            case 2:
                if tufuh_btn.tag == sender.tag {
                    tufuh_btn.isSelected = true
                } else {
                    tufuh_btn.isSelected = false
                }
            default:
                break
            }
        }

        tufuh_indexNum = sender.tag
    }
    
    private func animateChange(_ isExpanded: Bool) {
        guard let btn = tufuh_tabCenterBtn else { return }

        let targetWidth: CGFloat = isExpanded ? 207 : 52
        let targetX: CGFloat = TUOKOUXIUSwiftSCRE_W/2 - targetWidth/2

        if isExpanded {
            tufuh_tabCenterBtn?.setImage(nil, for: .normal)
            tufuh_tabCenterBtn?.layer.cornerRadius = 26
            tufuh_tabCenterBtn?.layer.borderColor = TUOKOUXIUSwiftZTClr5A.cgColor
            tufuh_tabCenterBtn?.layer.borderWidth = 1
            if (tufuh_tabCenterBtn?.subviews.count)! < 5 {
                let leftIV = UIImageView.tukou_bjImageV(CGRect(x: 6, y: 6, width: 40, height: 40), superView: tufuh_tabCenterBtn!, image: UIImage(named: "sleep"))
                
                let rightIV = UIImageView.tukou_bjImageV(CGRect(x: 207-6-40, y: 6, width: 40, height: 40), superView: tufuh_tabCenterBtn!, image: UIImage(named: "tab_home_play"))
                rightIV.contentMode = .center
                
                let topTitleL = UILabel.tukou_bjLabel(CGRect(x: leftIV.frame.maxX + 12, y: leftIV.frame.minY + 3, width: 42, height: 17), text: "瑜伽0", superView: tufuh_tabCenterBtn!, textAlignment: .center, font: TUOKOUXIUSwiftFont.medium(14), textColor: .white)
                
                let botTitleL = UILabel.tukou_bjLabel(CGRect(x: leftIV.frame.maxX + 12, y: topTitleL.frame.maxY, width: 48, height: 17), text: "东方禅境", superView: tufuh_tabCenterBtn!, textAlignment: .center, font: TUOKOUXIUSwiftFont.regular(12), textColor: .white)
                _ = UIImageView.tukou_bjImageV(CGRect(x: botTitleL.frame.maxX + 3, y: topTitleL.frame.maxY + 0.5, width: 16, height: 16), superView: tufuh_tabCenterBtn!, image: UIImage(named: "sleep"))
            }

            UIView.animate(
                withDuration: 0.55,
                delay: 0,
                usingSpringWithDamping: 0.55,
                initialSpringVelocity: 0.9,
                options: [.curveEaseInOut],
                animations: {
                    btn.frame = CGRect(x: targetX, y: 18, width: targetWidth, height: 52)
                },
                completion: nil
            )
        } else {
            tufuh_tabCenterBtn?.subviews.forEach { $0.removeFromSuperview() }
            tufuh_tabCenterBtn?.setImage(UIImage(named: "tab_home_play"), for: .normal)
            tufuh_tabCenterBtn?.layer.cornerRadius = 30
            tufuh_tabCenterBtn?.layer.borderColor = TUOKOUXIUSwiftZTClr3A.cgColor
            tufuh_tabCenterBtn?.layer.borderWidth = 1
            UIView.animate(
                withDuration: 0.55,
                delay: 0,
                usingSpringWithDamping: 0.55,
                initialSpringVelocity: 0.9,
                options: [.curveEaseInOut],
                animations: {
                    btn.frame = CGRect(x: TUOKOUXIUSwiftSCRE_W/2-60/2, y: 10, width: 60, height: 60)
                },
                completion: nil
            )
        }

        // scale 果冻效果（轻微缩放）
        btn.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.35,
                       initialSpringVelocity: 0.6,
                       options: [],
                       animations: {
                        btn.transform = .identity
                       },
                       completion: nil)
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
