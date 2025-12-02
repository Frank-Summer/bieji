
import UIKit

class JellyButton: UIButton {

    private var blurEffectView: UIVisualEffectView!

    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        // 设置圆角
        self.layer.cornerRadius = 26
        self.clipsToBounds = true
        self.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        if #available(iOS 26.0, *) {
            // 对系统 UIButton 使用 glass 配置
//            self.configuration = .glass()
        } else {
            let blurEffect = UIBlurEffect(style: .light)
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.isUserInteractionEnabled = false
            self.addSubview(blurEffectView)
        }
        
        // 把 imageView 放到最上层
        if let imgView = self.imageView {
            self.bringSubviewToFront(imgView)
        }

        self.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 1
    }

    // 按钮点击时的果冻动画
    override var isHighlighted: Bool {
        didSet {
            animateJelly(isHighlighted: isHighlighted)
        }
    }

    private func animateJelly(isHighlighted: Bool) {
        let scale: CGFloat = isHighlighted ? 0.85 : 1.0
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 3,
                       options: [.allowUserInteraction, .curveEaseOut],
                       animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: nil)
    }
}
