
import UIKit
import Foundation

protocol TUOKOUXIUSwiftPagTitVDelegate: AnyObject {
    func tukou_pageTitV(_ pageTitleView: TUOKOUXIUSwiftPagTitV, selectedIndex: Int)
}

class TUOKOUXIUSwiftPageTitleButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
        }
    }
}

class TUOKOUXIUSwiftPagTitV: UIView {
    
    weak var tufuh_delePageTitV: TUOKOUXIUSwiftPagTitVDelegate?
    var tufuh_configure: TUOKOUXIUSwiftPagTitVConf
    var tufuh_tempBtn: UIButton?
    var tufuh_allBtnTextWid: CGFloat = 0
    var tufuh_allBtnWid: CGFloat = 0
    var tufuh_sigBtnInd: Int = 0
    var tufuh_sigBtnClk: Bool = false
//    var tufuh_staR: CGFloat = 0
//    var tufuh_staG: CGFloat = 0
//    var tufuh_staB: CGFloat = 0
//    var tufuh_endR: CGFloat = 0
//    var tufuh_endG: CGFloat = 0
//    var tufuh_endB: CGFloat = 0
    var tufuh_seleInd: Int = 0
    private var tufuh_titArr: [String]
    
    init(frame: CGRect, delegate: TUOKOUXIUSwiftPagTitVDelegate?, titleNames: [String], configure: TUOKOUXIUSwiftPagTitVConf) {
        
        self.tufuh_delePageTitV = delegate
        self.tufuh_titArr = titleNames
        self.tufuh_configure = configure
        
        super.init(frame: frame)
        self.backgroundColor = TUOKOUXIUSwiftbaiseC.withAlphaComponent(0.77)
        self.initialization()
        self.tukou_setuSubVs()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func tukou_pageTitVWithFra(frame: CGRect,
                                      delegate: TUOKOUXIUSwiftPagTitVDelegate?,
                                      titleNames: [String],
                                      configure: TUOKOUXIUSwiftPagTitVConf) -> TUOKOUXIUSwiftPagTitV {
        return TUOKOUXIUSwiftPagTitV(frame: frame, delegate: delegate, titleNames: titleNames, configure: configure)
    }
    private func initialization() {
        tufuh_seleInd = 0
    }
    
    private func tukou_setuSubVs() {
        let tufuh_tempView = UIView(frame: .zero)
        addSubview(tufuh_tempView)
        addSubview(tufuh_scrollV)
        tukou_setuTitBtns()
        
        if tufuh_configure.tufuh_shoBotSeparator {
            addSubview(tufuh_botSepaV)
        }
        if tufuh_configure.tufuh_shoIndicator {
            tufuh_scrollV.insertSubview(tufuh_indiV, at: 0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tukou_laySubVs()
        
        if tufuh_btnMArr.count > tufuh_seleInd {
            tukou_btnAction(tufuh_btnMArr[tufuh_seleInd])
        }
    }
    
    private func tukou_laySubVs() {
        let tufuh_selfHeight = self.frame.size.height
        tufuh_scrollV.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: tufuh_selfHeight)
        let tufuh_titleCount = tufuh_titArr.count

        if tufuh_allBtnWid <= bounds.size.width {
            if tufuh_configure.tufuh_equivalence {
                let tufuh_btnY: CGFloat = 0
                let tufuh_btnW = self.frame.size.width / CGFloat(tufuh_titleCount)
                let tufuh_btnH: CGFloat = (tufuh_configure.tufuh_indicaSty == .def)
                    ? tufuh_selfHeight - tufuh_configure.tufuh_indicHei
                    : tufuh_selfHeight

                for (idx, btn) in tufuh_btnMArr.enumerated() {
                    let tufuh_btnX = tufuh_btnW * CGFloat(idx)
                    btn.frame = CGRect(x: tufuh_btnX, y: tufuh_btnY, width: tufuh_btnW, height: tufuh_btnH)
                }

                tufuh_scrollV.contentSize = CGSize(width: frame.size.width, height: tufuh_selfHeight)

                if tufuh_configure.tufuh_shoVerSepar {
                    let tufuh_VSeparatorW: CGFloat = 1
                    var tufuh_VSeparatorH = tufuh_selfHeight - tufuh_configure.tufuh_vertSeparReduH
                    if tufuh_VSeparatorH <= 0 {
                        tufuh_VSeparatorH = tufuh_selfHeight
                    }
                    let tufuh_VSeparatorY = 0.5 * (tufuh_selfHeight - tufuh_VSeparatorH)
                    for (idx, sepView) in tufuh_sepaMArr.enumerated() {
                        let tufuh_VSeparatorX = tufuh_btnW * CGFloat(idx + 1) - 0.5 * tufuh_VSeparatorW
                        sepView.frame = CGRect(x: tufuh_VSeparatorX, y: tufuh_VSeparatorY, width: tufuh_VSeparatorW, height: tufuh_VSeparatorH)
                    }
                }
            } else {
                tukou_fromLeToRigLayTit()
            }

            if tufuh_configure.tufuh_bounce == false {
                tufuh_scrollV.bounces = false
            }
        } else {
            tukou_fromLeToRigLayTit()
            if tufuh_configure.tufuh_bounce == false {
                tufuh_scrollV.bounces = false
            }
        }

        if tufuh_configure.tufuh_shoBotSeparator {
            let tufuh_bottomSeparatorW = frame.width
            let tufuh_bottomSeparatorH: CGFloat = 0.5
            let tufuh_bottomSeparatorX: CGFloat = 0
            let tufuh_bottomSeparatorY = frame.height - tufuh_bottomSeparatorH
            tufuh_botSepaV.frame = CGRect(x: tufuh_bottomSeparatorX, y: tufuh_bottomSeparatorY, width: tufuh_bottomSeparatorW, height: tufuh_bottomSeparatorH)
        }

        if tufuh_configure.tufuh_shoIndicator {
            if tufuh_configure.tufuh_indicaSty == .cov {
                guard let firstBtnTitle = tufuh_btnMArr.first?.currentTitle else { return }
                let tufuh_tempSize = tukou_size(firstBtnTitle, font: tufuh_configure.tufuh_titFont)
                let tufuh_tempIndicatorViewH = tufuh_tempSize.height

                if tufuh_configure.tufuh_indicHei > frame.height {
                    tufuh_indiV.frame.origin.y = 0
                    tufuh_indiV.frame.size.height = frame.height
                } else if tufuh_configure.tufuh_indicHei < tufuh_tempIndicatorViewH {
                    tufuh_indiV.frame.origin.y = 0.5 * (frame.height - tufuh_tempIndicatorViewH)
                    tufuh_indiV.frame.size.height = tufuh_tempIndicatorViewH
                } else {
                    tufuh_indiV.frame.origin.y = 0.5 * (frame.height - tufuh_configure.tufuh_indicHei)
                    tufuh_indiV.frame.size.height = tufuh_configure.tufuh_indicHei
                }
            } else {
                let tufuh_indicatorViewH = tufuh_configure.tufuh_indicHei
                tufuh_indiV.frame.size.height = tufuh_indicatorViewH
                tufuh_indiV.frame.origin.y = frame.height - tufuh_indicatorViewH - tufuh_configure.tufuh_indicToBotDist
            }

            if tufuh_configure.tufuh_indiCorRadi > 0.5 * tufuh_indiV.frame.height {
                tufuh_indiV.layer.cornerRadius = 0.5 * tufuh_indiV.frame.height
            } else {
                tufuh_indiV.layer.cornerRadius = tufuh_configure.tufuh_indiCorRadi
            }
        }
    }
    private func tukou_fromLeToRigLayTit() {
        let tufuh_selfHeight = self.frame.height
        var tufuh_btnX = tufuh_configure.tufuh_contInsSpac
        let tufuh_btnY: CGFloat = 0
        let tufuh_btnH: CGFloat = (tufuh_configure.tufuh_indicaSty == .def)
            ? tufuh_selfHeight - tufuh_configure.tufuh_indicHei
            : tufuh_selfHeight

        for (idx, btn) in tufuh_btnMArr.enumerated() {
            let tufuh_tempSize = tukou_size(tufuh_titArr[idx], font: tufuh_configure.tufuh_titFont)
            let tufuh_btnW = tufuh_tempSize.width + tufuh_configure.tufuh_titAdditiW
            btn.frame = CGRect(x: tufuh_btnX, y: tufuh_btnY, width: tufuh_btnW, height: tufuh_btnH)
            tufuh_btnX += tufuh_btnW
        }

        if let lastBtn = tufuh_btnMArr.last {
            let tufuh_scrollVW = lastBtn.frame.maxX + tufuh_configure.tufuh_contInsSpac
            tufuh_scrollV.contentSize = CGSize(width: tufuh_scrollVW, height: tufuh_selfHeight)
        }

        if tufuh_configure.tufuh_shoVerSepar {
            let tufuh_VSeparatorW: CGFloat = 1
            var tufuh_VSeparatorH = tufuh_selfHeight - tufuh_configure.tufuh_vertSeparReduH
            if tufuh_VSeparatorH <= 0 {
                tufuh_VSeparatorH = tufuh_selfHeight
            }
            let VSeparatorY = 0.5 * (tufuh_selfHeight - tufuh_VSeparatorH)

            for (idx, sepView) in tufuh_sepaMArr.enumerated() {
                let tufuh_btn = tufuh_btnMArr[idx]
                let VSeparatorX = tufuh_btn.frame.maxX - 0.5 * tufuh_VSeparatorW
                sepView.frame = CGRect(x: VSeparatorX, y: VSeparatorY, width: tufuh_VSeparatorW, height: tufuh_VSeparatorH)
            }
        }
    }

    private lazy var tufuh_btnMArr: [UIButton] = {
        return []
    }()

    private lazy var tufuh_sepaMArr: [UIView] = {
        return []
    }()
    
    private lazy var tufuh_scrollV: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.showsVerticalScrollIndicator = false
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.alwaysBounceHorizontal = true
        return scrollV
    }()

    private lazy var tufuh_indiV: UIView = {
        let indiV = UIView()
        if tufuh_configure.tufuh_indicaSty == .cov {
            indiV.layer.borderWidth = tufuh_configure.tufuh_indicBordW
            indiV.layer.borderColor = tufuh_configure.tufuh_indicBordClr.cgColor
        }
        indiV.backgroundColor = tufuh_configure.tufuh_indicClr
        return indiV
    }()

    private lazy var tufuh_botSepaV: UIView = {
        let botSepaV = UIView()
        botSepaV.backgroundColor = tufuh_configure.tufuh_botSeparClr
        return botSepaV
    }()

    private func tukou_setuTitBtns() {
        let tufuh_titleCount = tufuh_titArr.count
        
        for title in tufuh_titArr {
            let size = tukou_size(title, font: tufuh_configure.tufuh_titFont)
            tufuh_allBtnTextWid += size.width
        }
        
        tufuh_allBtnWid = tufuh_allBtnTextWid + tufuh_configure.tufuh_titAdditiW * CGFloat(tufuh_titleCount)
        tufuh_allBtnWid = ceil(tufuh_allBtnWid)
        
        for index in 0..<tufuh_titleCount {
            let btn = TUOKOUXIUSwiftPageTitleButton()
            btn.tag = index
            btn.titleLabel?.font = tufuh_configure.tufuh_titFont
            btn.setTitle(tufuh_titArr[index], for: .normal)
            btn.setTitleColor(tufuh_configure.tufuh_titClr, for: .normal)
            btn.setTitleColor(tufuh_configure.tufuh_titSeleClr, for: .selected)
            btn.addTarget(self, action: #selector(tukou_btnAction(_:)), for: .touchUpInside)
            
            tufuh_btnMArr.append(btn)
            tufuh_scrollV.addSubview(btn)
        }
        
//        if tufuh_configure.tufuh_titGradiEffe {
//            tukou_setStaClr(tufuh_configure.tufuh_titClr)
//            tukou_setEndClr(tufuh_configure.tufuh_titSeleClr)
//        }
        

        if tufuh_configure.tufuh_shoVerSepar {
            for _ in 0..<tufuh_titleCount - 1 {
                let separator = UIView()
                separator.backgroundColor = tufuh_configure.tufuh_verSeparClr
                tufuh_sepaMArr.append(separator)
                tufuh_scrollV.addSubview(separator)
            }
        }
    }
    
    @objc func tukou_btnAction(_ button: UIButton) {
        tukou_bianSeledBtn(button)
        
        if tufuh_allBtnWid > self.frame.size.width {
            tufuh_sigBtnClk = true
            tukou_seledBtnCen(button)
        }
        
        if tufuh_configure.tufuh_shoIndicator {
            tukou_chanIndWithBtn(button)
        }
        
        tufuh_delePageTitV?.tukou_pageTitV(self, selectedIndex: button.tag)
        
        tufuh_sigBtnInd = button.tag
    }
    
    private func tukou_bianSeledBtn(_ button: UIButton) {
        if tufuh_tempBtn == nil {
            button.isSelected = true
            tufuh_tempBtn = button
        } else if tufuh_tempBtn === button {
            button.isSelected = true
        } else if tufuh_tempBtn !== button, let tempBtn = tufuh_tempBtn {
            tempBtn.isSelected = false
            button.isSelected = true
            tufuh_tempBtn = button
        }
        
        tufuh_seleInd = button.tag
        
        let selectedFont = tufuh_configure.tufuh_titSeleFon
        let defaultFont = TUOKOUXIUSwiftFont.regular(15)
        
        if selectedFont.fontName == defaultFont.fontName && selectedFont.pointSize == defaultFont.pointSize {
            if tufuh_configure.tufuh_titTexZoo {
                for btn in tufuh_btnMArr {
                    btn.transform = .identity
                }
                
                let oldBtnWidth = button.frame.width
                let afterScale = 1 + tufuh_configure.tufuh_titTexZooRat
                button.transform = CGAffineTransform(scaleX: afterScale, y: afterScale)
                
                let newBtnWidth = button.frame.width
                let diffWidth = newBtnWidth - oldBtnWidth
                
                if tufuh_configure.tufuh_indiAdditiW >= diffWidth {
                    tufuh_configure.tufuh_indiAdditiW = diffWidth
                }
                
                let tempSize = tukou_size(button.currentTitle ?? "", font: tufuh_configure.tufuh_titFont)
                var indiWidth = tufuh_configure.tufuh_indiAdditiW + tempSize.width + tufuh_configure.tufuh_titTexZooRat * tempSize.width
                if indiWidth > button.frame.width {
                    indiWidth = button.frame.width - tufuh_configure.tufuh_titTexZooRat * tempSize.width
                }
                
                tufuh_indiV.frame.size.width = indiWidth
                tufuh_indiV.center.x = button.center.x
            }
            
//            if tufuh_configure.tufuh_titGradiEffe {
//                for btn in tufuh_btnMArr {
//                    btn.titleLabel?.textColor = tufuh_configure.tufuh_titClr
//                }
//                button.titleLabel?.textColor = tufuh_configure.tufuh_titSeleClr
//            }
        } else {
            for btn in tufuh_btnMArr {
                btn.titleLabel?.font = tufuh_configure.tufuh_titFont
            }
            button.titleLabel?.font = tufuh_configure.tufuh_titSeleFon

//            if tufuh_configure.tufuh_titGradiEffe {
//                for btn in tufuh_btnMArr {
//                    btn.titleLabel?.textColor = tufuh_configure.tufuh_titClr
//                    btn.titleLabel?.font = tufuh_configure.tufuh_titFont
//                }
//                button.titleLabel?.textColor = tufuh_configure.tufuh_titSeleClr
//                button.titleLabel?.font = tufuh_configure.tufuh_titSeleFon
//            } else {
//                for btn in tufuh_btnMArr {
//                    btn.titleLabel?.font = tufuh_configure.tufuh_titFont
//                }
//                button.titleLabel?.font = tufuh_configure.tufuh_titSeleFon
//            }
        }
    }
    private func tukou_seledBtnCen(_ centerBtn: UIButton) {
        var offsetX = centerBtn.center.x - self.frame.width * 0.5
        if offsetX < 0 { offsetX = 0 }
        
        let maxOffsetX = tufuh_scrollV.contentSize.width - self.frame.width
        if offsetX > maxOffsetX { offsetX = maxOffsetX }
        
        tufuh_scrollV.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }

    private func tukou_chanIndWithBtn(_ button: UIButton) {
        UIView.animate(withDuration: tufuh_configure.tufuh_indiAnimaT) {
            switch self.tufuh_configure.tufuh_indicaSty {
            case .fix:
                self.tufuh_indiV.frame.size.width = self.tufuh_configure.tufuh_indiFixW
                self.tufuh_indiV.center.x = button.center.x
                return
            case .dyn:
                self.tufuh_indiV.frame.size.width = self.tufuh_configure.tufuh_indiDynaW
                self.tufuh_indiV.center.x = button.center.x
                return
            default:
                break
            }
            
            if !self.tufuh_configure.tufuh_titTexZoo {
                let tempSize = self.tukou_size(button.currentTitle ?? "", font: self.tufuh_configure.tufuh_titFont)
                var indiWidth = self.tufuh_configure.tufuh_indiAdditiW + tempSize.width
                if indiWidth > button.frame.width {
                    indiWidth = button.frame.width
                }
                self.tufuh_indiV.frame.size.width = indiWidth
                self.tufuh_indiV.center.x = button.center.x
            }
        }
    }
    
    func tukou_pageTitVWithPro(progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        let originalBtn = tufuh_btnMArr[originalIndex]
        let targetBtn = tufuh_btnMArr[targetIndex]
        tufuh_sigBtnInd = targetBtn.tag

        if tufuh_allBtnWid > frame.width {
            if !tufuh_sigBtnClk {
                tukou_seledBtnCen(targetBtn)
            }
            tufuh_sigBtnClk = false
        }

        if tufuh_configure.tufuh_shoIndicator {
            if tufuh_allBtnWid <= bounds.width {
                if tufuh_configure.tufuh_equivalence {
                    if tufuh_configure.tufuh_indicScrSty == .def {
                        tukou_statiindicScrStyDef(progress: progress, originalBtn: originalBtn, targetBtn: targetBtn)
                    } else {
                        tukou_statindiScrStyHalfEnd(progress: progress, originalBtn: originalBtn, targetBtn: targetBtn)
                    }
                } else {
                    if tufuh_configure.tufuh_indicScrSty == .def {
                        tukou_indicScrStyDef(progress: progress, originalBtn: originalBtn, targetBtn: targetBtn)
                    } else {
                        tukou_indicScroStyHalfEndWiProg(progress: progress, originalBtn: originalBtn, targetBtn: targetBtn)
                    }
                }
            } else {
                if tufuh_configure.tufuh_indicScrSty == .def {
                    tukou_indicScrStyDef(progress: progress, originalBtn: originalBtn, targetBtn: targetBtn)
                } else {
                    tukou_indicScroStyHalfEndWiProg(progress: progress, originalBtn: originalBtn, targetBtn: targetBtn)
                }
            }
        } else {
            if tufuh_configure.tufuh_indicScrSty == .half {
                tukou_indicScrStyHalf(progress: progress, originalBtn: originalBtn, targetBtn: targetBtn)
            } else {
                tukou_indicScrStyOther(progress: progress, originalBtn: originalBtn, targetBtn: targetBtn)
            }
        }

//        if tufuh_configure.tufuh_titGradiEffe {
//            tukou_titGradiEffe(progress: progress, originalBtn: originalBtn, targetBtn: targetBtn)
//        }

        let selectedFont = tufuh_configure.tufuh_titSeleFon
        let defaultFont = TUOKOUXIUSwiftFont.regular(15)
        
        if selectedFont.fontName == defaultFont.fontName && selectedFont.pointSize == defaultFont.pointSize {
            if tufuh_configure.tufuh_titTexZoo {
                let originalBtnZoomRatio = (1 - progress) * tufuh_configure.tufuh_titTexZooRat
                originalBtn.transform = CGAffineTransform(scaleX: originalBtnZoomRatio + 1,
                                                          y: originalBtnZoomRatio + 1)

                let targetBtnZoomRatio = progress * tufuh_configure.tufuh_titTexZooRat
                targetBtn.transform = CGAffineTransform(scaleX: targetBtnZoomRatio + 1,
                                                        y: targetBtnZoomRatio + 1)
            }
        }
    }

    func tukou_indicScrStyHalf(progress: CGFloat, originalBtn: UIButton, targetBtn: UIButton) {
        UIView.animate(withDuration: tufuh_configure.tufuh_indiAnimaT) {
            if progress >= 0.5 {
                self.tukou_bianSeledBtn(targetBtn)
            } else {
                self.tukou_bianSeledBtn(originalBtn)
            }
        }
    }
    func tukou_statiindicScrStyDef(progress: CGFloat, originalBtn: UIButton, targetBtn: UIButton) {
        if progress >= 0.8 {
            tukou_bianSeledBtn(targetBtn)
        }
        
        let btnCount = CGFloat(tufuh_titArr.count)
        let totalWidth = tuks_spwidth
        
        if tufuh_configure.tufuh_indicaSty == .fix {
            let btnW = totalWidth / btnCount
            let targetBtnMaxX = CGFloat(targetBtn.tag + 1) * btnW
            let oriBtnMaxX = CGFloat(originalBtn.tag + 1) * btnW
            let targetBtnIndX = targetBtnMaxX - 0.5 * (btnW - tufuh_configure.tufuh_indiFixW) - tufuh_configure.tufuh_indiFixW
            let oriBtnIndX = oriBtnMaxX - 0.5 * (btnW - tufuh_configure.tufuh_indiFixW) - tufuh_configure.tufuh_indiFixW
            let totalOffsetX = targetBtnIndX - oriBtnIndX
            tufuh_indiV.tuks_spx = oriBtnIndX + progress * totalOffsetX
            return
        }
        
        if tufuh_configure.tufuh_indicaSty == .dyn {
            let originalTag = originalBtn.tag
            let targetTag = targetBtn.tag
            let btnW = totalWidth / btnCount
            let targetBtnMaxX = CGFloat(targetBtn.tag + 1) * btnW
            let originalBtnMaxX = CGFloat(originalBtn.tag + 1) * btnW
            
            if originalTag <= targetTag {
                if progress <= 0.5 {
                    tufuh_indiV.tuks_spwidth = tufuh_configure.tufuh_indiDynaW + 2 * progress * btnW
                } else {
                    let targetIndicatorX = targetBtnMaxX - 0.5 * (btnW - tufuh_configure.tufuh_indiDynaW) - tufuh_configure.tufuh_indiDynaW
                    tufuh_indiV.tuks_spx = targetIndicatorX + 2 * (progress - 1) * btnW
                    tufuh_indiV.tuks_spwidth = tufuh_configure.tufuh_indiDynaW + 2 * (1 - progress) * btnW
                }
            } else {
                if progress <= 0.5 {
                    let originalIndicatorX = originalBtnMaxX - 0.5 * (btnW - tufuh_configure.tufuh_indiDynaW) - tufuh_configure.tufuh_indiDynaW
                    tufuh_indiV.tuks_spx = originalIndicatorX - 2 * progress * btnW
                    tufuh_indiV.tuks_spwidth = tufuh_configure.tufuh_indiDynaW + 2 * progress * btnW
                } else {
                    let targetIndicatorX = targetBtnMaxX - tufuh_configure.tufuh_indiDynaW - 0.5 * (btnW - tufuh_configure.tufuh_indiDynaW)
                    tufuh_indiV.tuks_spx = targetIndicatorX
                    tufuh_indiV.tuks_spwidth = tufuh_configure.tufuh_indiDynaW + 2 * (1 - progress) * btnW
                }
            }
            return
        }
        
        let btnW = totalWidth / btnCount
        let targetTextW = tukou_size(targetBtn.currentTitle ?? "", font: tufuh_configure.tufuh_titFont).width
        let oriTextW = tukou_size(originalBtn.currentTitle ?? "", font: tufuh_configure.tufuh_titFont).width
        
        var targetMaxX: CGFloat = 0
        var oriMaxX: CGFloat = 0
        if tufuh_configure.tufuh_titTexZoo {
            targetMaxX = CGFloat(targetBtn.tag + 1) * btnW
            oriMaxX = CGFloat(originalBtn.tag + 1) * btnW
        } else {
            targetMaxX = targetBtn.frame.maxX
            oriMaxX = originalBtn.frame.maxX
        }
        
        let targetIndX = targetMaxX - targetTextW - 0.5 * (btnW - targetTextW + tufuh_configure.tufuh_indiAdditiW)
        let oriIndX = oriMaxX - oriTextW - 0.5 * (btnW - oriTextW + tufuh_configure.tufuh_indiAdditiW)
        
        let totalOffsetX = targetIndX - oriIndX
        let targetRightTextX = targetMaxX - 0.5 * (btnW - targetTextW)
        let oriRightTextX = oriMaxX - 0.5 * (btnW - oriTextW)
        let rightTextDis = targetRightTextX - oriRightTextX
        
        let offsetX = totalOffsetX * progress
        let distance = progress * (rightTextDis - totalOffsetX)
        
        tufuh_indiV.tuks_spx = oriIndX + offsetX
        let tempIndW = tufuh_configure.tufuh_indiAdditiW + oriTextW + distance
        
        if tempIndW >= targetBtn.tuks_spwidth {
            let moveTotalX = targetBtn.tuks_sporigin.x - originalBtn.tuks_sporigin.x
            let moveX = moveTotalX * progress
            tufuh_indiV.tuks_spcenterX = originalBtn.tuks_spcenterX + moveX
        } else {
            tufuh_indiV.tuks_spwidth = tempIndW
        }
    }
    func tukou_indicScrStyDef(progress: CGFloat, originalBtn: UIButton, targetBtn: UIButton) {
        if progress >= 0.8 {
            tukou_bianSeledBtn(targetBtn)
        }
        
        if tufuh_configure.tufuh_indicaSty == .fix {
            let targetIndicatorX = targetBtn.frame.maxX - 0.5 * (targetBtn.tuks_spwidth - tufuh_configure.tufuh_indiFixW) - tufuh_configure.tufuh_indiFixW
            let originalIndicatorX = originalBtn.frame.maxX - tufuh_configure.tufuh_indiFixW - 0.5 * (originalBtn.tuks_spwidth - tufuh_configure.tufuh_indiFixW)
            let totalOffsetX = targetIndicatorX - originalIndicatorX
            tufuh_indiV.tuks_spx = originalIndicatorX + totalOffsetX * progress
            return
        }
        
        if tufuh_configure.tufuh_indicaSty == .dyn {
            let originalTag = originalBtn.tag
            let targetTag = targetBtn.tag
            let btnCenterXDistance: CGFloat
            
            if originalTag <= targetTag {
                btnCenterXDistance = targetBtn.tuks_spcenterX - originalBtn.tuks_spcenterX
                if progress <= 0.5 {
                    tufuh_indiV.tuks_spwidth = 2 * progress * btnCenterXDistance + tufuh_configure.tufuh_indiDynaW
                } else {
                    let targetBtnX = targetBtn.frame.maxX - tufuh_configure.tufuh_indiDynaW - 0.5 * (targetBtn.tuks_spwidth - tufuh_configure.tufuh_indiDynaW)
                    tufuh_indiV.tuks_spx = targetBtnX + 2 * (progress - 1) * btnCenterXDistance
                    tufuh_indiV.tuks_spwidth = 2 * (1 - progress) * btnCenterXDistance + tufuh_configure.tufuh_indiDynaW
                }
            } else {
                btnCenterXDistance = originalBtn.tuks_spcenterX - targetBtn.tuks_spcenterX
                if progress <= 0.5 {
                    let originalBtnX = originalBtn.frame.maxX - tufuh_configure.tufuh_indiDynaW - 0.5 * (originalBtn.tuks_spwidth - tufuh_configure.tufuh_indiDynaW)
                    tufuh_indiV.tuks_spx = originalBtnX - 2 * progress * btnCenterXDistance
                    tufuh_indiV.tuks_spwidth = 2 * progress * btnCenterXDistance + tufuh_configure.tufuh_indiDynaW
                } else {
                    let targetBtnX = targetBtn.frame.maxX - tufuh_configure.tufuh_indiDynaW - 0.5 * (targetBtn.tuks_spwidth - tufuh_configure.tufuh_indiDynaW)
                    tufuh_indiV.tuks_spx = targetBtnX
                    tufuh_indiV.tuks_spwidth = 2 * (1 - progress) * btnCenterXDistance + tufuh_configure.tufuh_indiDynaW
                }
            }
            return
        }
        
        if tufuh_configure.tufuh_titTexZoo && tufuh_configure.tufuh_shoIndicator {
            let oriTextWidth = tukou_size(originalBtn.currentTitle ?? "", font: tufuh_configure.tufuh_titFont).width
            let tarTextWidth = tukou_size(targetBtn.currentTitle ?? "", font: tufuh_configure.tufuh_titFont).width
            let diffText = tarTextWidth - oriTextWidth
            let distanceCenter = targetBtn.tuks_spcenterX - originalBtn.tuks_spcenterX
            var offsetCX: CGFloat = 0
            let tempIndicatorWidth = tufuh_configure.tufuh_indiAdditiW + tarTextWidth + tufuh_configure.tufuh_titTexZooRat * tarTextWidth
            
            offsetCX = distanceCenter * progress
            tufuh_indiV.tuks_spcenterX = originalBtn.tuks_spcenterX + offsetCX
            
            let tempIndicatorW = oriTextWidth + diffText * progress
            if tempIndicatorWidth >= targetBtn.tuks_spwidth {
                tufuh_indiV.tuks_spwidth = targetBtn.tuks_spwidth - tufuh_configure.tufuh_titTexZooRat * tempIndicatorW
            } else {
                tufuh_indiV.tuks_spwidth = tempIndicatorW + tufuh_configure.tufuh_titTexZooRat * tempIndicatorW + tufuh_configure.tufuh_indiAdditiW
            }
            return
        }
        
        let totalOffsetX = targetBtn.tuks_spx - originalBtn.tuks_spx
        let totalDistance = targetBtn.frame.maxX - originalBtn.frame.maxX
        var offsetX: CGFloat = 0
        var distance: CGFloat = 0
        let targetTextWidth = tukou_size(targetBtn.currentTitle ?? "", font: tufuh_configure.tufuh_titFont).width
        let tempIndicatorWidth = tufuh_configure.tufuh_indiAdditiW + targetTextWidth
        
        if tempIndicatorWidth >= targetBtn.tuks_spwidth {
            offsetX = totalOffsetX * progress
            distance = progress * (totalDistance - totalOffsetX)
            tufuh_indiV.tuks_spx = originalBtn.tuks_spx + offsetX
            tufuh_indiV.tuks_spwidth = originalBtn.tuks_spwidth + distance
        } else {
            offsetX = totalOffsetX * progress + 0.5 * tufuh_configure.tufuh_titAdditiW - 0.5 * tufuh_configure.tufuh_indiAdditiW
            distance = progress * (totalDistance - totalOffsetX) - tufuh_configure.tufuh_titAdditiW
            tufuh_indiV.tuks_spx = originalBtn.tuks_spx + offsetX
            tufuh_indiV.tuks_spwidth = originalBtn.tuks_spwidth + distance + tufuh_configure.tufuh_indiAdditiW
        }
    }
    
    func tukou_statindiScrStyHalfEnd(progress: CGFloat, originalBtn: UIButton, targetBtn: UIButton) {
        
        let animateDuration = tufuh_configure.tufuh_indiAnimaT
        
        if tufuh_configure.tufuh_indicScrSty == .half {
            if tufuh_configure.tufuh_indicaSty == .fix {
                UIView.animate(withDuration: animateDuration) {
                    if progress >= 0.5 {
                        self.tufuh_indiV.tuks_spcenterX = targetBtn.tuks_spcenterX
                        self.tukou_bianSeledBtn(targetBtn)
                    } else {
                        self.tufuh_indiV.tuks_spcenterX = originalBtn.tuks_spcenterX
                        self.tukou_bianSeledBtn(originalBtn)
                    }
                }
                return
            }
            
            if progress >= 0.5 {
                let tempSize = tukou_size(targetBtn.currentTitle ?? "", font: tufuh_configure.tufuh_titFont)
                let tempIndicatorWidth = tufuh_configure.tufuh_indiAdditiW + tempSize.width
                
                UIView.animate(withDuration: animateDuration) {
                    self.tufuh_indiV.tuks_spwidth = max(tempIndicatorWidth, targetBtn.tuks_spwidth)
                    self.tufuh_indiV.tuks_spcenterX = targetBtn.tuks_spcenterX
                    self.tukou_bianSeledBtn(targetBtn)
                }
            } else {
                let tempSize = tukou_size(originalBtn.currentTitle ?? "", font: tufuh_configure.tufuh_titFont)
                let tempIndicatorWidth = tufuh_configure.tufuh_indiAdditiW + tempSize.width
                
                UIView.animate(withDuration: animateDuration) {
                    self.tufuh_indiV.tuks_spwidth = max(tempIndicatorWidth, originalBtn.tuks_spwidth)
                    self.tufuh_indiV.tuks_spcenterX = originalBtn.tuks_spcenterX
                    self.tukou_bianSeledBtn(originalBtn)
                }
            }
            return
        }
        
        if tufuh_configure.tufuh_indicaSty == .fix {
            UIView.animate(withDuration: animateDuration) {
                if progress == 1.0 {
                    self.tufuh_indiV.tuks_spcenterX = targetBtn.tuks_spcenterX
                    self.tukou_bianSeledBtn(targetBtn)
                } else {
                    self.tufuh_indiV.tuks_spcenterX = originalBtn.tuks_spcenterX
                    self.tukou_bianSeledBtn(originalBtn)
                }
            }
            return
        }
        
        if progress == 1.0 {
            let tempSize = tukou_size(targetBtn.currentTitle ?? "", font: tufuh_configure.tufuh_titFont)
            let tempIndicatorWidth = tufuh_configure.tufuh_indiAdditiW + tempSize.width
            
            UIView.animate(withDuration: animateDuration) {
                self.tufuh_indiV.tuks_spwidth = max(tempIndicatorWidth, targetBtn.tuks_spwidth)
                self.tufuh_indiV.tuks_spcenterX = targetBtn.tuks_spcenterX
                self.tukou_bianSeledBtn(targetBtn)
            }
        } else {
            let tempSize = tukou_size(originalBtn.currentTitle ?? "", font: tufuh_configure.tufuh_titFont)
            let tempIndicatorWidth = tufuh_configure.tufuh_indiAdditiW + tempSize.width
            
            UIView.animate(withDuration: animateDuration) {
                self.tufuh_indiV.tuks_spwidth = max(tempIndicatorWidth, originalBtn.tuks_spwidth)
                self.tufuh_indiV.tuks_spcenterX = originalBtn.tuks_spcenterX
                self.tukou_bianSeledBtn(originalBtn)
            }
        }
    }
    
    func tukou_indicScroStyHalfEndWiProg(progress: CGFloat, originalBtn: UIButton, targetBtn: UIButton) {
        if tufuh_configure.tufuh_indicScrSty == .half {
            if tufuh_configure.tufuh_indicaSty == .fix {
                UIView.animate(withDuration: tufuh_configure.tufuh_indiAnimaT) {
                    if progress >= 0.5 {
                        self.tufuh_indiV.tuks_spcenterX = targetBtn.tuks_spcenterX
                        self.tukou_bianSeledBtn(targetBtn)
                    } else {
                        self.tufuh_indiV.tuks_spcenterX = originalBtn.tuks_spcenterX
                        self.tukou_bianSeledBtn(originalBtn)
                    }
                }
                return
            }
            
            if progress >= 0.5 {
                let tempSize = tukou_size(targetBtn.currentTitle ?? "", font: tufuh_configure.tufuh_titFont)
                let tempIndicatorWidth = tufuh_configure.tufuh_indiAdditiW + tempSize.width
                UIView.animate(withDuration: tufuh_configure.tufuh_indiAnimaT) {
                    self.tufuh_indiV.tuks_spwidth = max(tempIndicatorWidth, targetBtn.tuks_spwidth)
                    self.tufuh_indiV.tuks_spcenterX = targetBtn.tuks_spcenterX
                    self.tukou_bianSeledBtn(targetBtn)
                }
            } else {
                let tempSize = tukou_size(originalBtn.currentTitle ?? "", font: tufuh_configure.tufuh_titFont)
                let tempIndicatorWidth = tufuh_configure.tufuh_indiAdditiW + tempSize.width
                UIView.animate(withDuration: tufuh_configure.tufuh_indiAnimaT) {
                    self.tufuh_indiV.tuks_spwidth = max(tempIndicatorWidth, originalBtn.tuks_spwidth)
                    self.tufuh_indiV.tuks_spcenterX = originalBtn.tuks_spcenterX
                    self.tukou_bianSeledBtn(originalBtn)
                }
            }
            return
        }
        
        if tufuh_configure.tufuh_indicaSty == .fix {
            UIView.animate(withDuration: tufuh_configure.tufuh_indiAnimaT) {
                if progress == 1.0 {
                    self.tufuh_indiV.tuks_spcenterX = targetBtn.tuks_spcenterX
                    self.tukou_bianSeledBtn(targetBtn)
                } else {
                    self.tufuh_indiV.tuks_spcenterX = originalBtn.tuks_spcenterX
                    self.tukou_bianSeledBtn(originalBtn)
                }
            }
            return
        }
        
        if progress == 1.0 {
            let tempSize = tukou_size(targetBtn.currentTitle ?? "", font: tufuh_configure.tufuh_titFont)
            let tempIndicatorWidth = tufuh_configure.tufuh_indiAdditiW + tempSize.width
            UIView.animate(withDuration: tufuh_configure.tufuh_indiAnimaT) {
                self.tufuh_indiV.tuks_spwidth = max(tempIndicatorWidth, targetBtn.tuks_spwidth)
                self.tufuh_indiV.tuks_spcenterX = targetBtn.tuks_spcenterX
                self.tukou_bianSeledBtn(targetBtn)
            }
        } else {
            let tempSize = tukou_size(originalBtn.currentTitle ?? "", font: tufuh_configure.tufuh_titFont)
            let tempIndicatorWidth = tufuh_configure.tufuh_indiAdditiW + tempSize.width
            UIView.animate(withDuration: tufuh_configure.tufuh_indiAnimaT) {
                self.tufuh_indiV.tuks_spwidth = max(tempIndicatorWidth, originalBtn.tuks_spwidth)
                self.tufuh_indiV.tuks_spcenterX = originalBtn.tuks_spcenterX
                self.tukou_bianSeledBtn(originalBtn)
            }
        }
    }
    
    func tukou_indicScrStyOther(progress: CGFloat, originalBtn: UIButton, targetBtn: UIButton) {
        UIView.animate(withDuration: tufuh_configure.tufuh_indiAnimaT) {
            if progress == 1.0 {
                self.tukou_bianSeledBtn(targetBtn)
            } else {
                self.tukou_bianSeledBtn(originalBtn)
            }
        }
    }

//    func tukou_titGradiEffe(progress: CGFloat, originalBtn: UIButton, targetBtn: UIButton) {
//        let targetProgress = progress
//        let originalProgress = 1.0 - targetProgress
//        
//        let r = tufuh_endR - tufuh_staR
//        let g = tufuh_endG - tufuh_staG
//        let b = tufuh_endB - tufuh_staB
//        
//        let originalColor = UIColor(
//            red: tufuh_staR + r * originalProgress,
//            green: tufuh_staG + g * originalProgress,
//            blue: tufuh_staB + b * originalProgress,
//            alpha: 1.0
//        )
//        
//        let targetColor = UIColor(
//            red: tufuh_staR + r * targetProgress,
//            green: tufuh_staG + g * targetProgress,
//            blue: tufuh_staB + b * targetProgress,
//            alpha: 1.0
//        )
//        
//        originalBtn.setTitleColor(originalColor, for: .normal)
//        targetBtn.setTitleColor(targetColor, for: .normal)
//    }
    
//    private func tukou_setStaClr(_ color: UIColor) {
//        let components = tukou_getRGBComponents(color)
//        tufuh_staR = components.r
//        tufuh_staG = components.g
//        tufuh_staB = components.b
//    }
//
//    private func tukou_setEndClr(_ color: UIColor) {
//        let components = tukou_getRGBComponents(color)
//        tufuh_endR = components.r
//        tufuh_endG = components.g
//        tufuh_endB = components.b
//    }
    
    func tukou_getRGBComponents(_ color: UIColor) -> (r: CGFloat, g: CGFloat, b: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (r: red, g: green, b: blue)
    }

    var tufuh_resSeleInd: Int = 0 {
        didSet {
            if tufuh_resSeleInd >= 0 && tufuh_resSeleInd < tufuh_btnMArr.count {
                tukou_btnAction(tufuh_btnMArr[tufuh_resSeleInd])
            }
        }
    }

    func tukou_size(_ string: String, font: UIFont) -> CGSize {
        let attrs = [NSAttributedString.Key.font: font]
        let size = string.boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attrs,
            context: nil
        ).size
        return size
    }
}
