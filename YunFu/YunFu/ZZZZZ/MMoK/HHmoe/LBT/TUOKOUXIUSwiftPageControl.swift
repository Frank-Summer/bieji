
import UIKit
import Foundation

class TUOKOUXIUSwiftPageControl: UIControl {

    var tufuh_numbOfPag: Int = 0 {
        didSet {
            if tufuh_numbOfPag == oldValue { return }
            if tufuh_currPag >= tufuh_numbOfPag {
                tufuh_currPag = 0
            }
            tukou_updIndV()
            if !tufuh_indVArr.isEmpty {
                setNeedsLayout()
            }
        }
    }
    var tufuh_currPag: Int = 0 {
        didSet {
            if oldValue == tufuh_currPag || tufuh_indVArr.count <= tufuh_currPag {
                return
            }
            if tufuh_currPagIndSi != tufuh_pagIndSi {
                setNeedsLayout()
            }
            tukou_updIndVBeha()
            if isUserInteractionEnabled {
                sendActions(for: .valueChanged)
            }
        }
    }
    var tufuh_hidForSingPag: Bool = false
    var tufuh_pagIndSpa: CGFloat = 10 {
        didSet {
            if !tufuh_indVArr.isEmpty {
                setNeedsLayout()
            }
        }
    }
    var tufuh_contIns: UIEdgeInsets = .zero
    var tufuh_pagIndTintClr: UIColor? {
        didSet { tukou_updIndVBeha() }
    }
    var tufuh_currPagIndTintClr: UIColor? {
        didSet { tukou_updIndVBeha() }
    }
    var tufuh_pagIndImg: UIImage? {
        didSet { tukou_updIndVBeha() }
    }
    var tufuh_currPagIndImg: UIImage? {
        didSet { tukou_updIndVBeha() }
    }
    var tufuh_indImgConMod: UIView.ContentMode = .center
    var tufuh_pagIndSi: CGSize = CGSize(width: 6, height: 6) {
        didSet {
            if tufuh_pagIndSi == oldValue { return }
            if tufuh_currPagIndSi == .zero ||
                (tufuh_currPagIndSi.width < tufuh_pagIndSi.width &&
                 tufuh_currPagIndSi.height < tufuh_pagIndSi.height) {
                tufuh_currPagIndSi = tufuh_pagIndSi
            }
            if !tufuh_indVArr.isEmpty {
                setNeedsLayout()
            }
        }
    }
    var tufuh_currPagIndSi: CGSize = CGSize(width: 6, height: 6) {
        didSet {
            if tufuh_currPagIndSi == oldValue { return }
            if !tufuh_indVArr.isEmpty {
                setNeedsLayout()
            }
        }
    }

    private var tufuh_indVArr: [UIImageView] = []
    private var tufuh_forcUpd: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tukou_confiPros()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tukou_confiPros()
    }
    
    private func tukou_confiPros() {
        isUserInteractionEnabled = false
        tufuh_forcUpd = false
        tufuh_pagIndSpa = 10
        tufuh_indImgConMod = .center
        tufuh_pagIndSi = CGSize(width: 6, height: 6)
        tufuh_currPagIndSi = tufuh_pagIndSi
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil {
            tufuh_forcUpd = true
            tukou_updIndV()
            tufuh_forcUpd = false
        }
    }

    private func tukou_updIndV() {
        guard superview != nil || tufuh_forcUpd else { return }
        if tufuh_indVArr.count == tufuh_numbOfPag {
            tukou_updIndVBeha()
            return
        }
        
        var arr = tufuh_indVArr
        if arr.count < tufuh_numbOfPag {
            for _ in arr.count..<tufuh_numbOfPag {
                let iv = UIImageView()
                iv.contentMode = tufuh_indImgConMod
                addSubview(iv)
                arr.append(iv)
            }
        } else if arr.count > tufuh_numbOfPag {
            for idx in stride(from: arr.count - 1, through: tufuh_numbOfPag, by: -1) {
                let iv = arr[idx]
                iv.removeFromSuperview()
                arr.remove(at: idx)
            }
        }
        tufuh_indVArr = arr
        tukou_updIndVBeha()
    }
    private func tukou_updIndVBeha() {
        guard !tufuh_indVArr.isEmpty, (superview != nil || tufuh_forcUpd) else { return }
        
        if tufuh_hidForSingPag && tufuh_indVArr.count == 1 {
            tufuh_indVArr.last?.isHidden = true
            return
        }
        
        for (index, indicatorView) in tufuh_indVArr.enumerated() {
            if let pagImg = tufuh_pagIndImg {
                indicatorView.contentMode = tufuh_indImgConMod
                indicatorView.image = (tufuh_currPag == index ? tufuh_currPagIndImg : pagImg)
            } else {
                indicatorView.image = nil
                indicatorView.backgroundColor = (tufuh_currPag == index ? tufuh_currPagIndTintClr : tufuh_pagIndTintClr)
            }
            indicatorView.isHidden = false
        }
    }
    private func tukou_layIndV() {
        guard !tufuh_indVArr.isEmpty else { return }
        
        var orignX: CGFloat = 0
        var centerY: CGFloat = 0
        var space = tufuh_pagIndSpa
        
        switch contentHorizontalAlignment {
        case .center:
            orignX = (bounds.width - CGFloat(tufuh_indVArr.count - 1) * (tufuh_pagIndSi.width + tufuh_pagIndSpa) - tufuh_currPagIndSi.width) / 2
        case .left:
            orignX = tufuh_contIns.left
        case .right:
            orignX = bounds.width - (CGFloat(tufuh_indVArr.count - 1) * (tufuh_pagIndSi.width + tufuh_pagIndSpa) + tufuh_currPagIndSi.width) - tufuh_contIns.right
        case .fill:
            orignX = tufuh_contIns.left
            if tufuh_indVArr.count > 1 {
                space = (bounds.width - tufuh_contIns.left - tufuh_contIns.right - tufuh_pagIndSi.width - CGFloat(tufuh_indVArr.count - 1) * tufuh_pagIndSi.width) / CGFloat(tufuh_indVArr.count - 1)
            }
        default:
            break
        }

        switch contentVerticalAlignment {
        case .center:
            centerY = bounds.height / 2
        case .top:
            centerY = tufuh_contIns.top + tufuh_currPagIndSi.height / 2
        case .bottom:
            centerY = bounds.height - tufuh_currPagIndSi.height / 2 - tufuh_contIns.bottom
        case .fill:
            centerY = (bounds.height - tufuh_contIns.top - tufuh_contIns.bottom) / 2 + tufuh_contIns.top
        default:
            break
        }

        for (index, indicatorView) in tufuh_indVArr.enumerated() {
            let size = (index == tufuh_currPag) ? tufuh_currPagIndSi : tufuh_pagIndSi
            if tufuh_pagIndImg == nil {
                indicatorView.layer.cornerRadius = (index == tufuh_currPag ? tufuh_currPagIndSi.height / 2 : tufuh_pagIndSi.height / 2)
            } else {
                indicatorView.layer.cornerRadius = 0
            }
            indicatorView.frame = CGRect(x: orignX, y: centerY - size.height / 2, width: size.width, height: size.height)
            orignX += size.width + space
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tukou_layIndV()
    }
}
