import UIKit

final class CountdownButtonViewModel {

    private var timer: Timer?
    private(set) var seconds: Int = 0
    private(set) var isEnabled: Bool = false

    /// 每次倒计时变化回调
    var onUpdate: ((Int, Bool) -> Void)?

    /// 开始倒计时
    func start(seconds: Int) {
        self.seconds = seconds
        isEnabled = false
        notify()

        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(tick),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc private func tick() {
        seconds -= 1
        if seconds <= 0 {
            timer?.invalidate()
            timer = nil
            isEnabled = true
            notify()
        } else {
            notify()
        }
    }

    /// 给 View 发状态通知
    private func notify() {
        onUpdate?(seconds, isEnabled)
    }
}
