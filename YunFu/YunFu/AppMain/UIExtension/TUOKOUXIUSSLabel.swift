
import UIKit
import CoreImage

extension UILabel {

    @discardableResult
    static func tukou_bjLabel(_ frame: CGRect,
                                      text: String?,
                                      superView: UIView,
                                      textAlignment: NSTextAlignment,
                                      font: UIFont,
                                      textColor: UIColor?) -> UILabel {
        let tufuh_l = UILabel(frame: frame)
        if let text = text, !text.isEmpty {
            tufuh_l.text = text
        }
        tufuh_l.textAlignment = textAlignment
        tufuh_l.font = font
        if let textColor = textColor {
            tufuh_l.textColor = textColor
        }
        superView.addSubview(tufuh_l)
        return tufuh_l
    }
}


extension UIView {

    @discardableResult
    static func tukou_bjView(_ frame: CGRect,
                                    superView: UIView,
                                    bgColor: UIColor?) -> UIView {
        let tufuh_v = UIView(frame: frame)
        if let bgColor = bgColor {
            tufuh_v.backgroundColor = bgColor
        }
        superView.addSubview(tufuh_v)
        return tufuh_v
    }
    @discardableResult
    static func tukou_bjView(_ frame: CGRect,
                                    superView: UIView,
                                    bgColor: UIColor?,
                                    cornerRadius:CGFloat = 0,
                                    borderWidth:CGFloat = 0,
                                    borderColor:UIColor?) -> UIView {
        let tufuh_v = UIView(frame: frame)
        if let bgColor = bgColor {
            tufuh_v.backgroundColor = bgColor
        }
        if cornerRadius > 0 {
            tufuh_v.layer.cornerRadius = cornerRadius
            tufuh_v.layer.masksToBounds = true
        }
        if borderWidth > 0 {
            tufuh_v.layer.borderWidth = borderWidth
        }
        if let borderColor = borderColor {
            tufuh_v.layer.borderColor = borderColor.cgColor
        }
        superView.addSubview(tufuh_v)
        return tufuh_v
    }
}

extension UIImageView {

    @discardableResult
    static func tukou_bjImageV(_ frame: CGRect,
                                    superView: UIView,
                                    image: UIImage?) -> UIImageView {
        let tufuh_imgV = UIImageView(frame: frame)
        if let image = image {
            tufuh_imgV.image = image
        }
        superView.addSubview(tufuh_imgV)
        return tufuh_imgV
    }
}

extension UIScrollView {

    @discardableResult
    static func tukou_bjScrollV(_ frame: CGRect,
                                    superView: UIView,
                                    bgColor: UIColor?) -> UIScrollView {
        let tufuh_scrV = UIScrollView(frame: frame)
        if let bgColor = bgColor {
            tufuh_scrV.backgroundColor = bgColor
        } else {
            tufuh_scrV.backgroundColor = TUOKOUXIUSwiftwuseC
        }
        superView.addSubview(tufuh_scrV)
        return tufuh_scrV
    }
}

extension UIButton {

    @discardableResult
    static func tukou_bjBtn(_ frame: CGRect,
                           target: AnyObject?,
                           title: String? = nil,
                           superView: UIView,
                           action: Selector) -> UIButton {
        let tufuh_btn = UIButton(type: .custom)
        tufuh_btn.frame = frame
        tufuh_btn.backgroundColor = TUOKOUXIUSwiftwuseC
        
        if let title = title, !title.isEmpty {
            tufuh_btn.setTitle(title, for: .normal)
        }
        tufuh_btn.addTarget(target, action: action, for: .touchUpInside)
        superView.addSubview(tufuh_btn)
        return tufuh_btn
    }
    @discardableResult
    static func tukou_bjBtn(_ frame: CGRect,
                           target: AnyObject?,
                           title: String? = nil,
                           color: UIColor?,
                           color2: UIColor?,
                           font: UIFont,
                           superView: UIView,
                           action: Selector) -> UIButton {
        let tufuh_btn = UIButton(type: .custom)
        tufuh_btn.frame = frame
        tufuh_btn.backgroundColor = TUOKOUXIUSwiftwuseC
        
        if let title = title, !title.isEmpty {
            tufuh_btn.setTitle(title, for: .normal)
        }
        if let color = color {
            tufuh_btn.setTitleColor(color, for: .normal)
        }
        if let color2 = color2 {
            tufuh_btn.setTitleColor(color2, for: .selected)
        }
        tufuh_btn.titleLabel?.font = font
        tufuh_btn.addTarget(target, action: action, for: .touchUpInside)
        superView.addSubview(tufuh_btn)
        return tufuh_btn
    }
    @discardableResult
    static func tukou_bjBtn(_ frame: CGRect,
                           target: AnyObject?,
                           title: String? = nil,
                           title2: String? = nil,
                           superView: UIView,
                           action: Selector) -> UIButton {
        let tufuh_btn = UIButton(type: .custom)
        tufuh_btn.frame = frame
        tufuh_btn.backgroundColor = TUOKOUXIUSwiftwuseC
        
        if let title = title, !title.isEmpty {
            tufuh_btn.setTitle(title, for: .normal)
        }
        if let title2 = title2, !title2.isEmpty {
            tufuh_btn.setTitle(title2, for: .selected)
        }
        tufuh_btn.addTarget(target, action: action, for: .touchUpInside)
        superView.addSubview(tufuh_btn)
        return tufuh_btn
    }
    @discardableResult
    static func tukou_bjBtn(_ frame: CGRect,
                           target: AnyObject?,
                           image: UIImage? = nil,
                           superView: UIView,
                           action: Selector) -> UIButton {
        let tufuh_btn = UIButton(type: .custom)
        tufuh_btn.frame = frame
        tufuh_btn.backgroundColor = TUOKOUXIUSwiftwuseC
        
        if let image = image {
            tufuh_btn.setImage(image, for: .normal)
        }
        tufuh_btn.addTarget(target, action: action, for: .touchUpInside)
        superView.addSubview(tufuh_btn)
        return tufuh_btn
    }
    @discardableResult
    static func tukou_bjBtn(_ frame: CGRect,
                           target: AnyObject?,
                           image: UIImage? = nil,
                           superView: UIView,
                           action: Selector,
                           title: String? = nil,
                           color: UIColor?,
                           font: UIFont,
                           titleEdgeInsets:UIEdgeInsets,
                           imageEdgeInsets:UIEdgeInsets) -> UIButton {
        let tufuh_btn = UIButton(type: .custom)
        tufuh_btn.frame = frame
        tufuh_btn.backgroundColor = TUOKOUXIUSwiftwuseC
        
        if let image = image {
            tufuh_btn.setImage(image, for: .normal)
        }
        if let title = title, !title.isEmpty {
            tufuh_btn.setTitle(title, for: .normal)
        }
        if let color = color {
            tufuh_btn.setTitleColor(color, for: .normal)
        }
        tufuh_btn.titleLabel?.font = font
        tufuh_btn.titleEdgeInsets = titleEdgeInsets
        tufuh_btn.imageEdgeInsets = imageEdgeInsets
        tufuh_btn.addTarget(target, action: action, for: .touchUpInside)
        superView.addSubview(tufuh_btn)
        return tufuh_btn
    }
    @discardableResult
    static func tukou_bjBtn(_ frame: CGRect,
                           target: AnyObject?,
                           imageName: String? = nil,
                           superView: UIView,
                           action: Selector,
                           font: UIFont,
                           title: String? = nil,
                           color: UIColor? = nil,
                           bgColor: UIColor?,
                           cornerRadius:CGFloat = 0) -> UIButton {
        let tufuh_btn = UIButton(type: .custom)
        tufuh_btn.frame = frame
        tufuh_btn.backgroundColor = bgColor
        
        if let name = imageName, !name.isEmpty {
            let image = UIImage(named: name)
            tufuh_btn.setImage(image, for: .normal)
        }
        if let title = title {
            tufuh_btn.setTitle(title, for: .normal)
        }
        if let color = color {
            tufuh_btn.setTitleColor(color, for: .normal)
        }
        
        tufuh_btn.titleLabel?.font = font
        
        if cornerRadius > 0 {
            tufuh_btn.layer.cornerRadius = cornerRadius
        }
        tufuh_btn.addTarget(target, action: action, for: .touchUpInside)
        superView.addSubview(tufuh_btn)
        return tufuh_btn
    }
    
    
}

extension UIImage {
    func tukou_applyDarkEffectGPU() -> UIImage? {
        let tintColor = UIColor(white: 0.11, alpha: 0.7)
        return self.tukou_applyBlurGPU(radius: 20, tintColor: tintColor, saturationDelta: 1.8, maskImage: nil)
    }
    func tukou_applyBlurGPU(radius blurRadius: CGFloat,
                             tintColor: UIColor?,
                             saturationDelta: CGFloat,
                             maskImage: UIImage?) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }

        let inputImage = CIImage(cgImage: cgImage)
        let context = CIContext(options: [.useSoftwareRenderer: false])

        var blurredImage = inputImage
        for _ in 0..<3 {
            guard let blurFilter = CIFilter(name: "CIGaussianBlur") else { continue }
            blurFilter.setValue(blurredImage, forKey: kCIInputImageKey)
            blurFilter.setValue(blurRadius, forKey: kCIInputRadiusKey)
            blurredImage = blurFilter.outputImage ?? blurredImage
        }

        if abs(saturationDelta - 1.0) > .leastNonzeroMagnitude,
           let colorFilter = CIFilter(name: "CIColorControls") {
            colorFilter.setValue(blurredImage, forKey: kCIInputImageKey)
            colorFilter.setValue(saturationDelta, forKey: kCIInputSaturationKey)
            blurredImage = colorFilter.outputImage ?? blurredImage
        }

        var outputImage = blurredImage
        if let tint = tintColor {
            let overlay = CIImage(color: CIColor(color: tint)).cropped(to: inputImage.extent)
            if let compositeFilter = CIFilter(name: "CISourceOverCompositing") {
                compositeFilter.setValue(overlay, forKey: kCIInputImageKey)
                compositeFilter.setValue(outputImage, forKey: kCIInputBackgroundImageKey)
                outputImage = compositeFilter.outputImage ?? outputImage
            }
        }

        if let mask = maskImage, let maskCg = mask.cgImage {
            let maskCI = CIImage(cgImage: maskCg)
            if let maskFilter = CIFilter(name: "CIBlendWithMask") {
                maskFilter.setValue(outputImage, forKey: kCIInputImageKey)
                maskFilter.setValue(inputImage, forKey: kCIInputBackgroundImageKey)
                maskFilter.setValue(maskCI, forKey: kCIInputMaskImageKey)
                outputImage = maskFilter.outputImage ?? outputImage
            }
        }

        guard let finalCG = context.createCGImage(outputImage, from: inputImage.extent) else { return nil }
        return UIImage(cgImage: finalCG, scale: self.scale, orientation: self.imageOrientation)
    }
}
