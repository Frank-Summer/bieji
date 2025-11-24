
import UIKit
import CoreImage

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
