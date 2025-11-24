import UIKit

class TUOKOUXIUJellyButton: UIButton {
    
    var normalImage: UIImage? {
        didSet {
            if !isExpanded { self.setImage(normalImage, for: .normal) }
        }
    }
    var selectedImage: UIImage?
    var buttonColor: UIColor = .gray { didSet { backgroundColor = buttonColor } }
    
    var mainText: String? { didSet { mainLabel.text = mainText } }
    var subText: String? { didSet { subLabel.text = subText } }
    
    private let mainLabel = UILabel()
    private let subLabel = UILabel()
    private var isExpanded = false
    
    private let collapsedWidth: CGFloat = 60
    private let expandedWidth: CGFloat = 160
    private let heightConst: CGFloat = 60
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: collapsedWidth, height: heightConst))
        setupUI()
        layoutIfNeeded() // ⚡ 强制创建 imageView
        setImage(normalImage, for: .normal) // 第一次显示
        addTarget(self, action: #selector(toggle), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) { fatalError("") }
    
    private func setupUI() {
        backgroundColor = buttonColor
        layer.cornerRadius = heightConst / 2
        clipsToBounds = true
        
        imageView?.contentMode = .scaleAspectFit
        
        mainLabel.font = UIFont.boldSystemFont(ofSize: 15)
        mainLabel.textColor = .white
        mainLabel.alpha = 0
        addSubview(mainLabel)
        
        subLabel.font = UIFont.systemFont(ofSize: 12)
        subLabel.textColor = UIColor.white.withAlphaComponent(0.85)
        subLabel.alpha = 0
        addSubview(subLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContent()
    }
    
    @objc private func toggle() {
        isExpanded.toggle()
        animateChange()
    }
    
    private func animateChange() {
        let targetWidth: CGFloat = isExpanded ? expandedWidth : collapsedWidth
        let oldFrame = frame
        
        // 图标弹跳
        UIView.animate(withDuration: 0.2, animations: {
            self.imageView?.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        }) { _ in
            self.setImage(self.isExpanded ? self.selectedImage : self.normalImage, for: .normal)
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.45,
                           initialSpringVelocity: 0.5,
                           options: [],
                           animations: {
                self.imageView?.transform = .identity
            }, completion: nil)
        }
        
        // 宽度 + 文字果冻动画
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.55,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut],
                       animations: {
            self.frame = CGRect(x: oldFrame.midX - targetWidth/2,
                                y: oldFrame.minY,
                                width: targetWidth,
                                height: self.heightConst)
            self.layer.cornerRadius = self.heightConst / 2
            self.layoutContent()
            
            // 文字弹性淡入
            self.mainLabel.alpha = self.isExpanded ? 1 : 0
            self.subLabel.alpha = self.isExpanded ? 1 : 0
        }, completion: nil)
    }
    
    private func layoutContent() {
        guard let imageView = imageView else { return }
        
        let iconSize: CGFloat = 30
        
        // 左侧区域居中
        let leftAreaWidth: CGFloat = collapsedWidth
        let iconX = (leftAreaWidth - iconSize)/2
        imageView.frame = CGRect(x: iconX, y: (heightConst - iconSize)/2, width: iconSize, height: iconSize)
        
        if isExpanded {
            mainLabel.frame = CGRect(x: leftAreaWidth + 10, y: 12, width: expandedWidth - leftAreaWidth - 20, height: 20)
            subLabel.frame = CGRect(x: leftAreaWidth + 10, y: 32, width: expandedWidth - leftAreaWidth - 20, height: 18)
        } else {
            mainLabel.frame = .zero
            subLabel.frame = .zero
        }
    }
}
