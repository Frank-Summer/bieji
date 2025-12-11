import UIKit

class AnimatedTabButton: UIButton {

    // MARK: - 放大动画（选中状态）
    func animateSelect() {
        // 1. 使用 CAKeyframeAnimation 模拟 Flutter TweenSequence
        let scaleAnim = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnim.values = [1.0, 1.2, 1.0]       // 放大到 1.2 再回到 1.0
        scaleAnim.keyTimes = [0, 0.5, 1.0]       // 时间分布
        scaleAnim.timingFunctions = [
            CAMediaTimingFunction(name: .easeOut),
            CAMediaTimingFunction(name: .easeIn)
        ]
        scaleAnim.duration = 0.2                  // 总时长 200ms

        // 2. 应用动画到图层
        self.layer.add(scaleAnim, forKey: "scaleSelect")
    }

    // MARK: - 缩小动画（取消选中或复原状态）
    func animateDeselect() {
        // 可以用两段 UIView 弹簧动画实现自然回弹
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1.0,
                       options: [.curveEaseInOut],
                       animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 1.0,
                           options: [.curveEaseInOut],
                           animations: {
                self.transform = .identity
            })
        }
    }

    // MARK: - 可选：快速 Flutter 风格弹跳（两段 CAKeyframe）
    func animateQuickTween() {
        let scaleAnim = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnim.values = [1.0, 1.2, 0.9, 1.0]   // 多段放大缩小，弹性更明显
        scaleAnim.keyTimes = [0, 0.4, 0.7, 1.0]
        scaleAnim.timingFunctions = [
            CAMediaTimingFunction(name: .easeOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeIn)
        ]
        scaleAnim.duration = 0.25
        self.layer.add(scaleAnim, forKey: "scaleTween")
    }
}
