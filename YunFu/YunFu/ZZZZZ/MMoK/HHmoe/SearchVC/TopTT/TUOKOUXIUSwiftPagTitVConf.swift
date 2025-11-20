
import UIKit
import Foundation

enum TUOKOUXIUENUM_IndiSty: Int {
    case def
    case cov
    case fix
    case dyn
}

enum TUOKOUXIUENUM_IndiScrSty: Int {
    case def
    case half
    case end
}

class TUOKOUXIUSwiftPagTitVConf: NSObject {
    
    static func tukou_pageTitVCon() -> TUOKOUXIUSwiftPagTitVConf {
        return TUOKOUXIUSwiftPagTitVConf()
    }
    
    var tufuh_bounce: Bool = false
    var tufuh_bounces: Bool = true
    var tufuh_equivalence: Bool = false
    var tufuh_shoBotSeparator: Bool = true
    
    private var _tufuh_botSeparClr: UIColor?
    var tufuh_botSeparClr: UIColor {
        get { _tufuh_botSeparClr ?? UIColor.lightGray }
        set { _tufuh_botSeparClr = newValue }
    }
    
    private var _tufuh_contInsSpac: CGFloat = 0
    var tufuh_contInsSpac: CGFloat {
        get { max(_tufuh_contInsSpac, 0) }
        set { _tufuh_contInsSpac = newValue }
    }
    
    private var _tufuh_titFont: UIFont?
    var tufuh_titFont: UIFont {
        get { _tufuh_titFont ?? TUOKOUXIUSwiftFont.regular(15) }
        set { _tufuh_titFont = newValue }
    }
    
    private var _tufuh_titSeleFon: UIFont?
     var tufuh_titSeleFon: UIFont {
        get { _tufuh_titSeleFon ?? TUOKOUXIUSwiftFont.regular(15) }
        set { _tufuh_titSeleFon = newValue }
    }
    
    private var _tufuh_titClr: UIColor?
    var tufuh_titClr: UIColor {
        get { _tufuh_titClr ?? TUOKOUXIUSwiftZTClr3A }
        set { _tufuh_titClr = newValue }
    }
    
    private var _tufuh_titSeleClr: UIColor?
    var tufuh_titSeleClr: UIColor {
        get { _tufuh_titSeleClr ?? TUOKOUXIUSwiftbaiseC }
        set { _tufuh_titSeleClr = newValue }
    }
    
//    var tufuh_titGradiEffe: Bool = false
    var tufuh_titTexZoo: Bool = false
    
    private var _tufuh_titTexZooRat: CGFloat = 0
    var tufuh_titTexZooRat: CGFloat {
        get {
            var ratio = _tufuh_titTexZooRat
            if ratio <= 0 { ratio = 0 }
            else if ratio >= 1 { ratio = 1 }
            return ratio * 0.5
        }
        set { _tufuh_titTexZooRat = newValue }
    }
    
    private var _tufuh_titAdditiW: CGFloat = 0
    var tufuh_titAdditiW: CGFloat {
        get { _tufuh_titAdditiW > 0 ? _tufuh_titAdditiW : 20 }
        set { _tufuh_titAdditiW = newValue }
    }
    
    var tufuh_shoIndicator: Bool = true
        
    private var _tufuh_indicClr: UIColor?
    var tufuh_indicClr: UIColor {
        get { _tufuh_indicClr ?? UIColor.red }
        set { _tufuh_indicClr = newValue }
    }
    
    private var _tufuh_indicHei: CGFloat = 0
    var tufuh_indicHei: CGFloat {
        get { _tufuh_indicHei > 0 ? _tufuh_indicHei : 2.0 }
        set { _tufuh_indicHei = newValue }
    }
    
    private var _tufuh_indiAnimaT: CGFloat = 0
    var tufuh_indiAnimaT: CGFloat {
        get {
            var t = _tufuh_indiAnimaT
            if t <= 0 { t = 0.1 }
            else if t > 0.3 { t = 0.3 }
            return t
        }
        set { _tufuh_indiAnimaT = newValue }
    }
    
    private var _tufuh_indiCorRadi: CGFloat = 0
    var tufuh_indiCorRadi: CGFloat {
        get { max(_tufuh_indiCorRadi, 0) }
        set { _tufuh_indiCorRadi = newValue }
    }
    
    private var _tufuh_indicToBotDist: CGFloat = 0
    var tufuh_indicToBotDist: CGFloat {
        get { max(_tufuh_indicToBotDist, 0) }
        set { _tufuh_indicToBotDist = newValue }
    }
    private var _tufuh_indicBordW: CGFloat = 0
    var tufuh_indicBordW: CGFloat {
        get { max(_tufuh_indicBordW, 0) }
        set { _tufuh_indicBordW = newValue }
    }
    
    private var _tufuh_indicBordClr: UIColor?
    var tufuh_indicBordClr: UIColor {
        get { _tufuh_indicBordClr ?? UIColor.clear }
        set { _tufuh_indicBordClr = newValue }
    }
    
    private var _tufuh_indiAdditiW: CGFloat = 0
    var tufuh_indiAdditiW: CGFloat {
        get { max(_tufuh_indiAdditiW, 0) }
        set { _tufuh_indiAdditiW = newValue }
    }
    
    private var _tufuh_indiFixW: CGFloat = 0
    var tufuh_indiFixW: CGFloat {
        get { _tufuh_indiFixW > 0 ? _tufuh_indiFixW : 20 }
        set { _tufuh_indiFixW = newValue }
    }
    
    private var _tufuh_indiDynaW: CGFloat = 0
    var tufuh_indiDynaW: CGFloat {
        get { _tufuh_indiDynaW > 0 ? _tufuh_indiDynaW : 20 }
        set { _tufuh_indiDynaW = newValue }
    }
    
    var tufuh_indicaSty: TUOKOUXIUENUM_IndiSty = .def
    var tufuh_indicScrSty: TUOKOUXIUENUM_IndiScrSty = .def
    
    var tufuh_shoVerSepar: Bool = false
    
    private var _tufuh_verSeparClr: UIColor?
    var tufuh_verSeparClr: UIColor {
        get { _tufuh_verSeparClr ?? UIColor.red }
        set { _tufuh_verSeparClr = newValue }
    }
    
    private var _tufuh_vertSeparReduH: CGFloat = 0
    var tufuh_vertSeparReduH: CGFloat {
        get { max(_tufuh_vertSeparReduH, 0) }
        set { _tufuh_vertSeparReduH = newValue }
    }
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        tufuh_shoBotSeparator = true
        tufuh_shoIndicator = true
        tufuh_equivalence = false
        tufuh_bounces = true
    }
    
}
