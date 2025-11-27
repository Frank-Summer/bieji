
import UIKit

class AlarmDurationPicker: UIView {

    var onConfirm: ((Int) -> Void)?
    var onCancel: (() -> Void)?
    var onDismissByPan: (() -> Void)?

    private let container = UIView()
    private let picker = UIPickerView()
    private let handleBar = UIView()
    private let cancelBtn = UIButton(type: .system)
    private let confirmBtn = UIButton(type: .system)
    private var durations: [Int] = []

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = .black
        self.alpha = 0.7
        setupDurations()
        setupUI()
        setupGesture()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupDurations() {
        durations = Array(stride(from: 5, through: 120, by: 5))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        onCancel?()
        dismissByPan()
    }

    private func setupUI() {

        container.backgroundColor = TUOKOUXIUSwiftZTClr5A
        container.layer.cornerRadius = 32
        container.clipsToBounds = true
        self.addSubview(container)
        container.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 635)
        
        handleBar.backgroundColor = TUOKOUXIUSwiftZTClr4A
        handleBar.layer.cornerRadius = 3
        container.addSubview(handleBar)
        handleBar.frame = CGRect(x: (UIScreen.main.bounds.width - 36)/2, y: 12, width: 36, height: 6)
        
        UILabel.tukou_bjLabel(CGRect(x: 0, y: 42, width: UIScreen.main.bounds.width, height: 32), text: "设置时长", superView: container, textAlignment: .center, font: TUOKOUXIUSwiftFont.medium(20), textColor: .white)

        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = .clear
        container.addSubview(picker)
        picker.frame = CGRect(x: 22, y: 106, width: UIScreen.main.bounds.width - 44, height: 240)
        if let index = durations.firstIndex(of: 15) {
            picker.selectRow(index, inComponent: 0, animated: false)
        }
        
        let AlarmClockV = UIView.tukou_bjView(CGRect(x: 20, y: picker.frame.maxY + 40, width: UIScreen.main.bounds.width - 40, height: 52), superView: container, bgColor: TUOKOUXIUSwiftZTClr5A)
        AlarmClockV.layer.cornerRadius = 8
        
        let AlarmClockIV = UIImageView.tukou_bjImageV(CGRect(x: 16, y: 12, width: 24, height: 24), superView: AlarmClockV, image: UIImage(named: "home_notification"))
        
        UILabel.tukou_bjLabel(CGRect(x: AlarmClockIV.frame.maxX + 10, y: 12, width: 100, height: 24), text: "闹铃提醒", superView: AlarmClockV, textAlignment: .left, font: TUOKOUXIUSwiftFont.medium(14), textColor: .white)
        
        
        let AlarmClockSW = UISwitch(frame: CGRect(x: UIScreen.main.bounds.width - 40 - 40 - 26, y: 12, width: 40, height: 24))
        AlarmClockSW.isOn = false // true: 开, false: 关
        AlarmClockV.addSubview(AlarmClockSW)
        AlarmClockSW.addTarget(self, action: #selector(alarmClockSwitchValueChanged(_:)), for: .valueChanged)
        
        let InterceptionV = UIView.tukou_bjView(CGRect(x: 20, y: AlarmClockV.frame.maxY + 16, width: UIScreen.main.bounds.width - 40, height: 52), superView: container, bgColor: TUOKOUXIUSwiftZTClr5A)
        InterceptionV.layer.cornerRadius = 8
        
        let InterceptionIV = UIImageView.tukou_bjImageV(CGRect(x: 16, y: 12, width: 24, height: 24), superView: InterceptionV, image: UIImage(named: "home_blocking"))
        UILabel.tukou_bjLabel(CGRect(x: InterceptionIV.frame.maxX + 10, y: 12, width: 200, height: 24), text: "定时期间打开应用拦截", superView: InterceptionV, textAlignment: .left, font: TUOKOUXIUSwiftFont.medium(14), textColor: .white)
        
        let InterceptionSW = UISwitch(frame: CGRect(x: UIScreen.main.bounds.width - 40 - 40 - 26, y: 12, width: 40, height: 24))
        InterceptionSW.isOn = false
        InterceptionV.addSubview(InterceptionSW)
        InterceptionSW.addTarget(self, action: #selector(interceptionSwitchValueChanged(_:)), for: .valueChanged)

        let cancelBtn = UIButton.tukou_bjBtn(CGRect(x: 16, y: InterceptionV.frame.maxY + 40, width: 155, height: 44), target: self, title: "取消", superView: container, action: #selector(cancelAction))
        cancelBtn.layer.borderColor = TUOKOUXIUSwiftZTClr11A.cgColor
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.cornerRadius = 12
        cancelBtn.titleLabel?.font = TUOKOUXIUSwiftFont.medium(16)
        
        
        let confirmBtn = UIButton.tukou_bjBtn(CGRect(x: UIScreen.main.bounds.width - 16 - 155, y: InterceptionV.frame.maxY + 40, width: 155, height: 44), target: self, title: "确认", superView: container, action: #selector(confirmAction))
        confirmBtn.backgroundColor = .white
        confirmBtn.layer.cornerRadius = 12
        confirmBtn.setTitleColor(.black, for: .normal)
        confirmBtn.titleLabel?.font = TUOKOUXIUSwiftFont.medium(16)
    }
    
    //闹钟提醒
    @objc func alarmClockSwitchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            print("开关已打开")
        } else {
            print("开关已关闭")
        }
    }
    
    //定时拦截
    @objc func interceptionSwitchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            print("开关已打开")
        } else {
            print("开关已关闭")
        }
    }

    private func setupGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        container.addGestureRecognizer(pan)
    }

    @objc private func handlePan(_ ges: UIPanGestureRecognizer) {
        let translation = ges.translation(in: container)
        switch ges.state {
        case .changed:
            if translation.y > 0 {
                container.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended, .cancelled:
            if translation.y > 100 {
                dismissByPan()
            } else {
                UIView.animate(withDuration: 0.25) { self.container.transform = .identity }
            }
        default: break
        }
    }

    // ✅ 新增方法：下滑销毁浮层
    private func dismissByPan() {
        UIView.animate(withDuration: 0.25, animations: {
            self.container.frame.origin.y = UIScreen.main.bounds.height
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
            self.onDismissByPan?()  // 调用回调
        }
    }

    @objc private func cancelAction() {
        onCancel?()
        dismissByPan()  // 取消也走动画关闭
    }

    @objc private func confirmAction() {
        let row = picker.selectedRow(inComponent: 0)
        let duration = durations[row]
        onConfirm?(duration)
        dismissByPan()
    }

    func show(in view: UIView) {
        view.addSubview(self)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.alpha = 1
            self.container.frame.origin.y = UIScreen.main.bounds.height - self.container.frame.height
        }, completion: nil)
    }
}

extension AlarmDurationPicker: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { durations.count }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(durations[row]) 分钟"
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat { 40 }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat { 240 }
    
    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        let title = "\(durations[row]) 分钟"
        return NSAttributedString(
            string: title,
            attributes: [
                .foregroundColor: UIColor.white,   // 字体颜色
                .font: TUOKOUXIUSwiftFont.medium(16) // 字体大小
            ]
        )
    }
}
