
import Foundation
import Kingfisher
import Combine
import UIKit

class TUOKOUXIUSwiftTBar: UIViewController {
    
    var tufuh_tabbVCArr: [UIViewController] = []
    var tufuh_mDict: [String: Any]?
    var tufuh_tabBV: UIView!
    var tufuh_tabButArr: [UIButton] = []
    var tufuh_contV: UIView!
    var tufuh_selInd: Int = -1
    var tufuh_catheDict: [Int: UIViewController] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var animatedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 26
        button.clipsToBounds = true
        button.layer.shadowOpacity = 0
        button.tag = 1
        button.layer.borderColor = TUOKOUXIUWhiteA30.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickCenterBtn)))
        return button
    }()
    
    private lazy var centerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func updateCenterText(title: String, subtitle: String) {
        let attributedString = NSMutableAttributedString(
            string: "\(title)\n\(subtitle)",
            attributes: [
                .font: TUOKOUXIUSwiftFont.medium(14),
                .foregroundColor: UIColor.white
            ]
        )
        
        // 可以设置不同行的不同样式
        attributedString.addAttribute(
            .font,
            value: TUOKOUXIUSwiftFont.regular(12),
            range: NSRange(location: title.count, length: subtitle.count + 1)
        )
        
        centerLabel.attributedText = attributedString
    }
    
    private lazy var leftIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sleep") // 左边图标
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var rightIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tab_home_play") // 暂停图标
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickPlayBtn)))
        return imageView
    }()
    
    private lazy var leftSideButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = TUOKOUXIUSwiftwuseC
        let off = UIImage(named: "tab_explore_default")
        let on = UIImage(named: "tab_explore_select")
        button.setImage((off), for: .normal)
        button.setImage((on), for: .selected)
        button.tag = 0
        button.layer.cornerRadius = 20
        button.layer.borderColor = TUOKOUXIUWhiteA30.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        button.tukou_setEnlargeEdge(10)
        return button
    }()
    
    private lazy var rightSideButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = TUOKOUXIUSwiftwuseC
        let off = UIImage(named: "tab_my_default")
        let on = UIImage(named: "tab_my_select")
        button.setImage((off), for: .normal)
        button.setImage((on), for: .selected)
        button.tag = 2
        button.layer.cornerRadius = 20
        button.layer.borderColor = TUOKOUXIUWhiteA30.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        button.tukou_setEnlargeEdge(10)
        return button
    }()
    
    private var buttonWidthConstraint: NSLayoutConstraint!
    private var rightIconCenterXConstraint: NSLayoutConstraint!
    
    private var leftButtonWidthConstraint: NSLayoutConstraint!
    private var leftButtonHeightConstraint: NSLayoutConstraint!
    private var leftButtonLeadingConstraint: NSLayoutConstraint!
    
    private var rightButtonWidthConstraint: NSLayoutConstraint!
    private var rightButtonHeightConstraint: NSLayoutConstraint!
    private var rightButtonTrailingConstraint: NSLayoutConstraint!
    
    private var isExpanded = false
    private var isLeftButtonExpanded = false
    private var isRightButtonExpanded = false
    
    
    private var enterBtn = UIButton()
    
    private enum LayoutConstants {
        static let oriSideButtonInitialSize: CGFloat = 40
        static let leftButtonAfterCornerRadius: CGFloat = 26
        static let sideButtonInitialSize: CGFloat = 52
        static let oriSideButtonInitialMargin: CGFloat = 30
        static let sideButtonInitialMargin: CGFloat = 24
        static let centerButtonCollapsedSize: CGFloat = 52
        static let centerButtonExpandedSize: CGFloat = 210
    }
    
    private var isPlay = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUHidTabb"))
            .sink { [weak self] _ in self?.tukou_hidTabb() }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUShoTabb"))
            .sink { [weak self] _ in self?.tukou_shoTabb() }
            .store(in: &cancellables)
        //显示首页类型
        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUShowLeiXing"))
            .sink { [weak self] _ in self?.clickCenterBtn() }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: NSNotification.Name("TUOKOUXIUToggleTypePlayback"))
            .sink { [weak self] _ in self?.toggleTypePlayback() }
            .store(in: &cancellables)
        
        tufuh_selInd = -1
        tukou_setTabBar()
        tukou_setContainerV()
        
        self.tukou_setTabBTitArr()
//        updateCenterText(title: "", subtitle: "")
        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isEnterApp {
            enterBtn.frame = CGRect(x: TUOKOUXIUSwiftSCRE_W/2-140/2, y: 7, width: 140, height: 52)
            enterBtn.backgroundColor = TUOKOUXIUSwiftbaiseC
            enterBtn.setTitle("进入", for: .normal)
            enterBtn.setTitleColor(.black, for: .normal)
            enterBtn.titleLabel?.font = TUOKOUXIUSwiftFont.semibold(16)
            enterBtn.layer.cornerRadius = 26
            enterBtn.addTarget(self, action: #selector(clickEnter), for: .touchUpInside)
            enterBtn.tukou_setEnlargeEdge(10)
            tufuh_tabBV.addSubview(enterBtn)
        }
    }
    
    @objc private func clickEnter() {
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isEnterApp = false
        NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUEnterMainView"), object: nil)
        enterBtn.isHidden = true
        enterBtn.removeFromSuperview()
        if isLeftButtonExpanded || isRightButtonExpanded {
            tukou_swiToVCAtInd(1)
            if isLeftButtonExpanded {
                isLeftButtonExpanded = false
                leftSideButton.backgroundColor = TUOKOUXIUSwiftwuseC
                leftBtnChange()
                leftBtnAnimation()
            }
            if isRightButtonExpanded {
                isRightButtonExpanded = false
                rightSideButton.backgroundColor = TUOKOUXIUSwiftwuseC
                rightBtnChange()
                rightBtnAnimation()
            }
        }
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
    
    func tukou_setTabBTitArr() {
        self.tufuh_tabBV.addSubview(leftSideButton)
        self.tufuh_tabButArr.append(leftSideButton)

        self.tufuh_tabBV.addSubview(animatedButton)
        self.tufuh_tabButArr.append(animatedButton)
        //默认选中第二个btn
        animatedButton.isSelected = true

        tukou_swiToVCAtInd(1)
        self.tufuh_tabBV.addSubview(rightSideButton)
        self.tufuh_tabButArr.append(rightSideButton)
        
        buttonWidthConstraint = animatedButton.widthAnchor.constraint(equalToConstant: 52)
        
        NSLayoutConstraint.activate([
            animatedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animatedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonWidthConstraint,
            animatedButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        // 左边按钮约束 - 固定在屏幕左侧
        leftButtonWidthConstraint = leftSideButton.widthAnchor.constraint(equalToConstant: LayoutConstants.oriSideButtonInitialSize)
        leftButtonHeightConstraint = leftSideButton.heightAnchor.constraint(equalToConstant: LayoutConstants.oriSideButtonInitialSize)
        leftButtonLeadingConstraint = leftSideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.oriSideButtonInitialMargin)
        
        NSLayoutConstraint.activate([
            leftButtonLeadingConstraint,
            leftSideButton.centerYAnchor.constraint(equalTo: animatedButton.centerYAnchor),
            leftButtonWidthConstraint,
            leftButtonHeightConstraint
        ])
        
        // 右边按钮约束 - 固定在屏幕右侧
        rightButtonWidthConstraint = rightSideButton.widthAnchor.constraint(equalToConstant: LayoutConstants.oriSideButtonInitialSize)
        rightButtonHeightConstraint = rightSideButton.heightAnchor.constraint(equalToConstant: LayoutConstants.oriSideButtonInitialSize)
        rightButtonTrailingConstraint = rightSideButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.oriSideButtonInitialMargin)
        
        NSLayoutConstraint.activate([
            rightButtonTrailingConstraint,
            rightSideButton.centerYAnchor.constraint(equalTo: animatedButton.centerYAnchor),
            rightButtonWidthConstraint,
            rightButtonHeightConstraint
        ])
        
        // 添加内部元素
        animatedButton.addSubview(centerLabel)
        animatedButton.addSubview(leftIcon)
        animatedButton.addSubview(rightIcon)
        
        // 设置暂停图标约束（初始居中）
        rightIconCenterXConstraint = rightIcon.centerXAnchor.constraint(equalTo: animatedButton.centerXAnchor)
        
        NSLayoutConstraint.activate([
            // 暂停图标居中（初始状态）
            rightIconCenterXConstraint,
            rightIcon.centerYAnchor.constraint(equalTo: animatedButton.centerYAnchor),
            rightIcon.widthAnchor.constraint(equalToConstant: 40),
            rightIcon.heightAnchor.constraint(equalToConstant: 40),
            
            // 中间文本（初始隐藏）
            centerLabel.centerXAnchor.constraint(equalTo: animatedButton.centerXAnchor),
            centerLabel.centerYAnchor.constraint(equalTo: animatedButton.centerYAnchor),
            
            // 左边图标（初始隐藏）
            leftIcon.centerYAnchor.constraint(equalTo: animatedButton.centerYAnchor),
            leftIcon.trailingAnchor.constraint(equalTo: centerLabel.leadingAnchor, constant: -20),
            leftIcon.widthAnchor.constraint(equalToConstant: 40),
            leftIcon.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // 初始状态：只显示暂停图标
        rightIcon.alpha = 1.0
        self.tufuh_tabBV.backgroundColor = TUOKOUXIUSwiftwuseC
    }
    
    @objc private func leftButtonTapped() {
        if isRightButtonExpanded {
            isRightButtonExpanded = false
            rightSideButton.backgroundColor = TUOKOUXIUSwiftwuseC
            rightBtnChange()
            rightBtnAnimation()
        }
        if isLeftButtonExpanded { return }
        tukou_swiToVCAtInd(0)
        leftSideButton.isSelected = true
        leftSideButton.backgroundColor = TUOKOUXIUSwiftbaiseC
        leftBtnChange()
        isLeftButtonExpanded = true
        leftBtnAnimation()

        if isExpanded { return }
        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isEnterApp { return }
        handleButtonTap()
    }
    
    func leftBtnAnimation() {
//        UIView.animate(withDuration: 0.3,
//                      delay: 0,
//                      usingSpringWithDamping: 0.7,
//                      initialSpringVelocity: 0.7,
//                      options: .curveEaseInOut,
//                       animations: { [self] in
//            self.view.layoutIfNeeded()
//            leftSideButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//        }, completion: { _ in
//            UIView.animate(withDuration: 0.1) { [self] in
//                leftSideButton.transform = .identity
//            }
//        })
        leftSideButton.transform = CGAffineTransform(scaleX: 0.86, y: 0.86)

        UIView.animate(
            withDuration: 0.16,
            animations: {
                self.leftSideButton.transform = CGAffineTransform(scaleX: 1.12, y: 1.12)
            },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.32,
                    delay: 0,
                    usingSpringWithDamping: 0.48,
                    initialSpringVelocity: 1.2,
                    options: [.allowUserInteraction, .beginFromCurrentState]
                ) {
                    self.leftSideButton.transform = .identity
                }
            }
        )
    }
    
    func rightBtnAnimation() {
//        UIView.animate(withDuration: 0.3,
//                      delay: 0,
//                      usingSpringWithDamping: 0.7,
//                      initialSpringVelocity: 0.7,
//                      options: .curveEaseInOut,
//                       animations: { [self] in
//            self.view.layoutIfNeeded()
//            rightSideButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//        }, completion: { _ in
//            UIView.animate(withDuration: 0.1) { [self] in
//                rightSideButton.transform = .identity
//            }
//        })
        rightSideButton.transform = CGAffineTransform(scaleX: 0.86, y: 0.86)

        UIView.animate(
            withDuration: 0.16,
            animations: {
                self.rightSideButton.transform = CGAffineTransform(scaleX: 1.12, y: 1.12)
            },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.32,
                    delay: 0,
                    usingSpringWithDamping: 0.48,
                    initialSpringVelocity: 1.2,
                    options: [.allowUserInteraction, .beginFromCurrentState]
                ) {
                    self.rightSideButton.transform = .identity
                }
            }
        )
    }
    
    @objc private func rightButtonTapped() {
        if isLeftButtonExpanded {
            isLeftButtonExpanded = false
            leftSideButton.backgroundColor = TUOKOUXIUSwiftwuseC
            leftBtnChange()
            leftBtnAnimation()
        }
            
        if isRightButtonExpanded { return }
        tukou_swiToVCAtInd(2)
        isRightButtonExpanded = true
        rightSideButton.backgroundColor = TUOKOUXIUSwiftbaiseC
        rightBtnChange()
        rightBtnAnimation()
        if isExpanded { return }
        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isEnterApp { return }
        handleButtonTap()
    }
    
    @objc private func handleButtonTap() {
        if isExpanded {
            collapseButton()
            rightIcon.isUserInteractionEnabled = false
        } else {
            expandButton()
            rightIcon.isUserInteractionEnabled = true
        }
    }
    
    private func collapseButton() {
        stopRotationAnimation()
        
        // 先执行淡出动画
        UIView.animate(withDuration: 0.2) {
            self.centerLabel.alpha = 0
            self.leftIcon.alpha = 0
        } completion: { _ in
            // 淡出完成后执行收缩动画
            self.buttonWidthConstraint.constant = 52
            self.rightIconCenterXConstraint.isActive = false
            self.rightIconCenterXConstraint = self.rightIcon.centerXAnchor.constraint(
                equalTo: self.animatedButton.centerXAnchor
            )
            self.rightIconCenterXConstraint.isActive = true
            self.isExpanded = false
            self.resetIconOrientation()
            
            UIView.animate(withDuration: 0.5, delay: 0,
                           usingSpringWithDamping: 1.0,
                           initialSpringVelocity: 1.0,
                           options: .curveEaseInOut) {
                self.view.layoutIfNeeded()
                self.animatedButton.backgroundColor = .white
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                self.playCollapseJellyEffect()
            }
        }
    }
    
    private func expandButton() {
        // 先执行淡出动画
        UIView.animate(withDuration: 0.2) {
            self.centerLabel.alpha = 1
            self.leftIcon.alpha = 1
        } completion: { [self] _ in
            let meta = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_metaInfo
            let musicStr:String = meta?.internalName ?? ""
            let nameStr:String = meta?.artist?.name ?? ""
            updateCenterText(title: musicStr, subtitle: nameStr)
            buttonWidthConstraint.constant = LayoutConstants.centerButtonExpandedSize
    
            // 移除旧的居中约束，添加新的右侧约束
            rightIconCenterXConstraint.isActive = false
    
            rightIconCenterXConstraint = rightIcon.centerXAnchor.constraint(
                equalTo: animatedButton.trailingAnchor,
                constant: -30
            )
            rightIconCenterXConstraint.isActive = true
            self.isExpanded = true
            
            UIView.animate(withDuration: 0.5, delay: 0,
                           usingSpringWithDamping: 1.0,
                           initialSpringVelocity: 1.0,
                           options: .curveEaseInOut) {
                self.view.layoutIfNeeded()
                self.animatedButton.backgroundColor = .clear
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                self.playExpandJellyEffect()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.startRotationAnimation()
            }
        }
    }
    
    private func playExpandJellyEffect() {
        animatedButton.transform = CGAffineTransform(scaleX: 1.12, y: 0.96)

        UIView.animate(
            withDuration: 0.16,
            animations: {
                self.animatedButton.transform = CGAffineTransform(scaleX: 0.92, y: 1.02)
            },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.32,
                    delay: 0,
                    usingSpringWithDamping: 0.42,
                    initialSpringVelocity: 1.3,
                    options: [.allowUserInteraction, .beginFromCurrentState]
                ) {
                    self.animatedButton.transform = .identity
                }
            }
        )
    }
    
    private func playCollapseJellyEffect() {
        animatedButton.transform = CGAffineTransform(scaleX: 0.86, y: 1.06)

        UIView.animate(
            withDuration: 0.16,
            animations: {
                self.animatedButton.transform = CGAffineTransform(scaleX: 1.12, y: 0.96)
            },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.32,
                    delay: 0,
                    usingSpringWithDamping: 0.48,
                    initialSpringVelocity: 1.2,
                    options: [.allowUserInteraction, .beginFromCurrentState]
                ) {
                    self.animatedButton.transform = .identity
                }
            }
        )
    }
    
    func leftBtnChange() {
        guard leftSideButton.layer.cornerRadius != 26 else { return }
        leftSideButton.layer.cornerRadius = 26
        leftButtonWidthConstraint.constant = LayoutConstants.sideButtonInitialSize
        leftButtonHeightConstraint.constant = LayoutConstants.sideButtonInitialSize
        leftButtonLeadingConstraint.constant = LayoutConstants.sideButtonInitialMargin
    }
    
    func rightBtnChange() {
        guard rightSideButton.layer.cornerRadius != 26 else { return }
        rightSideButton.layer.cornerRadius = 26
        rightButtonWidthConstraint.constant = LayoutConstants.sideButtonInitialSize
        rightButtonHeightConstraint.constant = LayoutConstants.sideButtonInitialSize
        rightButtonTrailingConstraint.constant = -LayoutConstants.sideButtonInitialMargin
    }
    
    @objc private func clickCenterBtn() {
        if isExpanded {
            tukou_swiToVCAtInd(1)
            handleButtonTap()
            if isLeftButtonExpanded {
                isLeftButtonExpanded = false
                leftSideButton.backgroundColor = TUOKOUXIUSwiftwuseC
                leftBtnChange()
                leftBtnAnimation()
            }
            if isRightButtonExpanded {
                isRightButtonExpanded = false
                rightSideButton.backgroundColor = TUOKOUXIUSwiftwuseC
                rightBtnChange()
                rightBtnAnimation()
            }
        } else {
            addScaAnimToBut(animatedButton)
            if self.isPlay {
                self.isPlay = false
                rightIcon.image = UIImage(named: "tab_home_stop")
                NotificationCenter.default.post(
                    name: Notification.Name("TUOKOUXIUAudioPause"),
                    object: nil
                )
            } else {
                self.isPlay = true
                rightIcon.image = UIImage(named: "tab_home_play")
                NotificationCenter.default.post(
                    name: Notification.Name("TUOKOUXIUAudioPlay"),
                    object: nil
                )
            }
        }
    }
    
    private func toggleTypePlayback() {
        self.isPlay = true
        rightIcon.image = UIImage(named: "tab_home_play")
    }
    
    @objc private func clickPlayBtn() {
        self.isPlay = !self.isPlay
        if self.isPlay {
            rightIcon.image = UIImage(named: "tab_home_play") // 暂停图标
            NotificationCenter.default.post(
                name: Notification.Name("TUOKOUXIUAudioPlay"),
                object: nil
            )
            startRotationAnimation()
        } else {
            rightIcon.image = UIImage(named: "tab_home_stop") // 播放图标
            NotificationCenter.default.post(
                name: Notification.Name("TUOKOUXIUAudioPause"),
                object: nil
            )
            stopRotationAnimation()
        }
    }
    
    func addScaAnimToBut(_ button: UIView) {
        let ani = CAKeyframeAnimation(keyPath: "transform.scale")
        ani.values = [1.0, 1.2, 0.9, 1.15, 1.0]
        ani.duration = 0.35
        ani.repeatCount = 1
        ani.calculationMode = .cubic
        button.layer.add(ani, forKey: nil)
    }
    
    func tukou_hidTabb() {
        tufuh_tabBV.isHidden = true
    }

    func tukou_shoTabb() {
        tufuh_tabBV.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - 视图显示后更新布局
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 确保初始状态正确
        rightIcon.alpha = 1.0
    }
    
    // MARK: - Rotation Animation
    private var rotationAnimation: CABasicAnimation?
    private var isRotating = false

    // 开始旋转动画
    private func startRotationAnimation() {
        // 确保没有重复添加动画
        stopRotationAnimation()
        
        // 创建旋转动画
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = CGFloat.pi * 2
        rotation.duration = 5.0  // 每2秒旋转一圈
        rotation.repeatCount = .infinity  // 无限重复
        rotation.isRemovedOnCompletion = false
        
        leftIcon.layer.add(rotation, forKey: "rotationAnimation")
        isRotating = true
        
        print("旋转动画开始")
    }

    // 停止旋转动画
    private func stopRotationAnimation() {
        leftIcon.layer.removeAnimation(forKey: "rotationAnimation")
        isRotating = false
        print("旋转动画停止")
    }

    // 重置图标方向（可选）
    private func resetIconOrientation() {
        UIView.animate(withDuration: 0.3) {
            self.leftIcon.transform = .identity
        }
    }
}
