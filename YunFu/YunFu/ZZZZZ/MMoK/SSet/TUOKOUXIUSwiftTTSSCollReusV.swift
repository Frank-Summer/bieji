
import Foundation
import UIKit

typealias TUOKOUXIUTS_ClkItemBlk = (_ param1: String, _ param2: String) -> Void

class TUOKOUXIUSwiftTTSSCollReusV: UICollectionReusableView {
    
    var tufuh_clkItemBlk: TUOKOUXIUTS_ClkItemBlk?
    var tufuh_dataTDict: [String: Any]?
    
    var tufuh_name1: String?
    var tufuh_name2: String?
    var tufuh_name3: String?
    var tufuh_name4: String?
    var tufuh_name5: String?
    var tufuh_name6: String?
    
    private var tufuh_ty1: String?
    private var tufuh_ty2: String?
    private var tufuh_ty3: String?
    private var tufuh_ty4: String?
    private var tufuh_ty5: String?
    private var tufuh_ty6: String?
    
    private var tufuh_dsjWid1: CGFloat = 0
    private var tufuh_dsjWid2: CGFloat = 0
    private var tufuh_dsjWid3: CGFloat = 0
    private var tufuh_dsjWid4: CGFloat = 0
    private var tufuh_dsjWid5: CGFloat = 0
    private var tufuh_dsjWid6: CGFloat = 0
    
    private var tufuh_scrV = UIScrollView()
    private var tufuh_scrV2 = UIScrollView()
    private var tufuh_scrV3 = UIScrollView()
    private var tufuh_scrV4 = UIScrollView()
    private var tufuh_scrV5 = UIScrollView()
    private var tufuh_scrV6 = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = TUOKOUXIUSwiftheiseC
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func tukou_recoverV(_ dict: [String: Any]) {
        self.tufuh_dataTDict = dict
        
        guard let tufuh_arr1 = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr as? [[String: Any]], !tufuh_arr1.isEmpty else {
            return
        }
        
        if tufuh_arr1.count > 0 {
            let tufuh_d1 = tufuh_arr1[0]
            let tufuh_v1 = tufuh_d1["data"] as? [[String: String]] ?? []
            tufuh_ty1 = tufuh_d1["module"] as? String
            let tufuh_stringType = self.tufuh_dataTDict!["type"] as? String ?? ""
            for (i, item) in tufuh_v1.enumerated() {
                let name = item["name"] ?? ""
                let value = item["value"] ?? ""
                if let btn = tufuh_scrV.viewWithTag(i + 1) as? UIButton {
                    btn.setTitle(name, for: .normal)
                    if tufuh_stringType == value {
                        fuhan_clkNumT(btn)
                    }
                }
            }
        }
        
        if tufuh_arr1.count > 1 {
            let tufuh_d2 = tufuh_arr1[1]
            let tufuh_v2 = tufuh_d2["data"] as? [[String: String]] ?? []
            tufuh_ty2 = "\(tufuh_d2["module"] ?? "")"
            let stringReleaseYear = self.tufuh_dataTDict!["release_year"] as? String ?? ""
            for (i, item) in tufuh_v2.enumerated() {
                let name = item["name"] ?? ""
                let value = item["value"] ?? ""
                if let btn = tufuh_scrV2.viewWithTag(i + 1) as? UIButton {
                    btn.setTitle(name, for: .normal)
                    if stringReleaseYear == value {
                        fuhan_clkNumT2(btn)
                    }
                }
            }
        }
        
        if tufuh_arr1.count > 2 {
            let tufuh_d3 = tufuh_arr1[2]
            let tufuh_v3 = tufuh_d3["data"] as? [[String: String]] ?? []
            tufuh_ty3 = "\(tufuh_d3["module"] ?? "")"
            let stringGenre = self.tufuh_dataTDict!["genre"] as? String ?? ""
            for (i, item) in tufuh_v3.enumerated() {
                let name = item["name"] ?? ""
                let value = item["value"] ?? ""
                if let btn = tufuh_scrV3.viewWithTag(i + 1) as? UIButton {
                    btn.setTitle(name, for: .normal)
                    if stringGenre == value {
                        fuhan_clkNumT3(btn)
                    }
                }
            }
        }
        if tufuh_arr1.count > 3 {
            let tufuh_d4 = tufuh_arr1[3]
            let tufuh_v4 = tufuh_d4["data"] as? [[String: String]] ?? []
            tufuh_ty4 = tufuh_d4["module"] as? String
            let stringCountry = self.tufuh_dataTDict!["country"] as? String ?? ""
            for (i, item) in tufuh_v4.enumerated() {
                let name = item["name"] ?? ""
                let value = item["value"] ?? ""
                if let btn = tufuh_scrV4.viewWithTag(i + 1) as? UIButton {
                    btn.setTitle(name, for: .normal)
                    if stringCountry == value {
                        fuhan_clkNumT4(btn)
                    }
                }
            }
        }
        
        if tufuh_arr1.count > 4 {
            let tufuh_d5 = tufuh_arr1[4]
            let tufuh_v5 = tufuh_d5["data"] as? [[String: String]] ?? []
            tufuh_ty5 = tufuh_d5["module"] as? String
            let stringStreaming = self.tufuh_dataTDict!["streaming"] as? String ?? ""
            for (i, item) in tufuh_v5.enumerated() {
                let name = item["name"] ?? ""
                let value = item["value"] ?? ""
                if let btn = tufuh_scrV5.viewWithTag(i + 1) as? UIButton {
                    btn.setTitle(name, for: .normal)
                    if stringStreaming == value {
                        fuhan_clkNumT5(btn)
                    }
                }
            }
        }
        
        if tufuh_arr1.count > 5 {
            let tufuh_d6 = tufuh_arr1[5]
            let tufuh_v6 = tufuh_d6["data"] as? [[String: String]] ?? []
            tufuh_ty6 = tufuh_d6["module"] as? String
            let stringQuality = self.tufuh_dataTDict!["quality"] as? String ?? ""
            for (i, item) in tufuh_v6.enumerated() {
                let name = item["name"] ?? ""
                let value = item["value"] ?? ""
                if let btn = tufuh_scrV6.viewWithTag(i + 1) as? UIButton {
                    btn.setTitle(name, for: .normal)
                    if stringQuality == value {
                        fuhan_clkNumT6(btn)
                    }
                }
            }
        }
    }
    
    func fuhan_shoPoiToCenBtn(_ buttonCurrent: UIButton, andNum num: Int) {
        var scroV: UIScrollView
        switch num {
        case 1: scroV = tufuh_scrV2
        case 2: scroV = tufuh_scrV3
        case 3: scroV = tufuh_scrV4
        case 4: scroV = tufuh_scrV5
        case 5: scroV = tufuh_scrV6
        default: scroV = tufuh_scrV
        }
        
        let scrollViewCenterX = scroV.frame.size.width * 0.5
        if scrollViewCenterX == 0 { return }
        if scroV.contentSize.width < scroV.frame.size.width { return }
        
        let buttonCenterX = buttonCurrent.center.x
        if buttonCenterX < scrollViewCenterX {
            scroV.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        } else if buttonCenterX > scrollViewCenterX {
            let unVisiableWidth = scroV.contentSize.width - scroV.frame.size.width
            let needOffset = buttonCenterX - scrollViewCenterX
            if unVisiableWidth > needOffset {
                scroV.setContentOffset(CGPoint(x: needOffset, y: 0), animated: true)
            } else {
                scroV.setContentOffset(CGPoint(x: unVisiableWidth, y: 0), animated: true)
            }
        }
    }
    func tukou_creatrV() {
        self.tufuh_scrV.removeFromSuperview()
        self.tufuh_scrV2.removeFromSuperview()
        self.tufuh_scrV3.removeFromSuperview()
        self.tufuh_scrV4.removeFromSuperview()
        self.tufuh_scrV5.removeFromSuperview()
        self.tufuh_scrV6.removeFromSuperview()
        tufuh_dsjWid1 = 0
        tufuh_dsjWid2 = 0
        tufuh_dsjWid3 = 0
        tufuh_dsjWid4 = 0
        tufuh_dsjWid5 = 0
        tufuh_dsjWid6 = 0
        
        self.tufuh_scrV = UIScrollView.tukou_bjScrollV(
            CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W - 20, height: 30),
            superView: self,
            bgColor: nil
        )
        self.tufuh_scrV.showsHorizontalScrollIndicator = false
        
        let tufuh_arr1 = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr
        guard tufuh_arr1.count > 0 else { return }
        if let tufuh_d1 = tufuh_arr1[0] as? [String: Any],
           let tufuh_v1 = tufuh_d1["data"] as? [[String: Any]] {
            tufuh_ty1 = tufuh_d1["module"] as? String ?? ""
            
            for i in 1...tufuh_v1.count {
                let tufuh_string = tufuh_v1[i-1]["name"] as? String ?? ""
                let dsjWidth = TUOKOUXIUSSStringUtils.tukou_sizWithT(
                    tufuh_string,
                    font: TUOKOUXIUSwiftFont.regular(14),
                    maxSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30)
                ).width + 20
                
                tufuh_dsjWid1 += dsjWidth
                
                let tufuh_btn = UIButton.tukou_bjBtn(
                    CGRect(x: CGFloat(12 * (i-1)) + tufuh_dsjWid1 - dsjWidth, y: 0, width: dsjWidth, height: 30),
                    target: self,
                    imageName: nil,
                    superView: self.tufuh_scrV,
                    action: #selector(fuhan_clkNumT(_:)),
                    font: TUOKOUXIUSwiftFont.regular(12),
                    title: tufuh_string,
                    color: TUOKOUXIUSwiftbaiseC,
                    bgColor: TUOKOUXIUSwiftZTClr2,
                    cornerRadius: 5
                )
                tufuh_btn.setTitleColor(TUOKOUXIUSwiftbaiseC, for: UIControl.State.selected)
                tufuh_btn.tag = i
                
                if i == tufuh_v1.count {
                    let offsetX = CGFloat(12 * (i - 1)) + tufuh_dsjWid1 + 12.0
                    self.tufuh_scrV.contentSize = CGSize(width: offsetX, height: 30)
                }
                if i == 1 {
                    fuhan_clkNumT(tufuh_btn)
                }
            }
        }
        
        self.tufuh_scrV2 = UIScrollView.tukou_bjScrollV(
            CGRect(x: 0, y: 40, width: TUOKOUXIUSwiftSCRE_W - 20, height: 30),
            superView: self,
            bgColor: nil
        )
        self.tufuh_scrV2.showsHorizontalScrollIndicator = false
        guard tufuh_arr1.count > 1 else { return }
        if let tufuh_d2 = tufuh_arr1[1] as? [String: Any],
           let tufuh_v2 = tufuh_d2["data"] as? [[String: Any]] {
            tufuh_ty2 = "\(tufuh_d2["module"] ?? "")"
            
            for i in 1...tufuh_v2.count {
                let tufuh_string = tufuh_v2[i-1]["name"] as? String ?? ""
                let dsjWidth = TUOKOUXIUSSStringUtils.tukou_sizWithT(
                    tufuh_string,
                    font: TUOKOUXIUSwiftFont.regular(14),
                    maxSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30)
                ).width + 20
                
                tufuh_dsjWid2 += dsjWidth
                
                let tufuh_btn = UIButton.tukou_bjBtn(
                    CGRect(x: CGFloat(12 * (i-1)) + tufuh_dsjWid2 - dsjWidth, y: 0, width: dsjWidth, height: 30),
                    target: self,
                    imageName: nil,
                    superView: self.tufuh_scrV2,
                    action: #selector(fuhan_clkNumT2(_:)),
                    font: TUOKOUXIUSwiftFont.regular(12),
                    title: tufuh_string,
                    color: TUOKOUXIUSwiftbaiseC,
                    bgColor: TUOKOUXIUSwiftZTClr2,
                    cornerRadius: 5
                )
                tufuh_btn.setTitleColor(TUOKOUXIUSwiftbaiseC, for: UIControl.State.selected)
                tufuh_btn.tag = i
                
                if i == tufuh_v2.count {
                    let offsetX = CGFloat(12 * (i - 1)) + tufuh_dsjWid2 + 12.0
                    self.tufuh_scrV2.contentSize = CGSize(width: offsetX, height: 30)
                }
                if i == 1 {
                    fuhan_clkNumT2(tufuh_btn)
                }
            }
        }
        
        self.tufuh_scrV3 = UIScrollView.tukou_bjScrollV(
            CGRect(x: 0, y: 80, width: TUOKOUXIUSwiftSCRE_W - 20, height: 30),
            superView: self,
            bgColor: nil
        )
        self.tufuh_scrV3.showsHorizontalScrollIndicator = false
        guard tufuh_arr1.count > 2 else { return }
        if let tufuh_d3 = tufuh_arr1[2] as? [String: Any],
           let tufuh_v3 = tufuh_d3["data"] as? [[String: Any]] {
            tufuh_ty3 = "\(tufuh_d3["module"] ?? "")"
            
            for i in 1...tufuh_v3.count {
                let tufuh_string = tufuh_v3[i-1]["name"] as? String ?? ""
                let dsjWidth = TUOKOUXIUSSStringUtils.tukou_sizWithT(
                    tufuh_string,
                    font: TUOKOUXIUSwiftFont.regular(14),
                    maxSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30)
                ).width + 20
                
                tufuh_dsjWid3 += dsjWidth
                
                let tufuh_btn = UIButton.tukou_bjBtn(
                    CGRect(x: CGFloat(10 * (i-1)) + tufuh_dsjWid3 - dsjWidth, y: 0, width: dsjWidth, height: 30),
                    target: self,
                    imageName: nil,
                    superView: self.tufuh_scrV3,
                    action: #selector(fuhan_clkNumT3(_:)),
                    font: TUOKOUXIUSwiftFont.regular(12),
                    title: tufuh_string,
                    color: TUOKOUXIUSwiftbaiseC,
                    bgColor: TUOKOUXIUSwiftZTClr2,
                    cornerRadius: 5
                )
                tufuh_btn.setTitleColor(TUOKOUXIUSwiftbaiseC, for: UIControl.State.selected)
                tufuh_btn.tag = i
                
                if i == tufuh_v3.count {
                    let offsetX = CGFloat(10 * (i - 1)) + tufuh_dsjWid3 + 10.0
                    self.tufuh_scrV3.contentSize = CGSize(width: offsetX, height: 30)
                }
                if i == 1 {
                    fuhan_clkNumT3(tufuh_btn)
                }
            }
        }
        
        self.tufuh_scrV4 = UIScrollView.tukou_bjScrollV(
            CGRect(x: 0, y: 120, width: TUOKOUXIUSwiftSCRE_W - 20, height: 30),
            superView: self,
            bgColor: nil
        )
        self.tufuh_scrV4.showsHorizontalScrollIndicator = false
        guard tufuh_arr1.count > 3 else { return }
        if let tufuh_d4 = tufuh_arr1[3] as? [String: Any],
           let tufuh_v4 = tufuh_d4["data"] as? [[String: Any]] {
            tufuh_ty4 = "\(tufuh_d4["module"] ?? "")"
            
            for i in 1...tufuh_v4.count {
                let tufuh_string = tufuh_v4[i-1]["name"] as? String ?? ""
                let dsjWidth = TUOKOUXIUSSStringUtils.tukou_sizWithT(
                    tufuh_string,
                    font: TUOKOUXIUSwiftFont.regular(14),
                    maxSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30)
                ).width + 20
                
                tufuh_dsjWid4 += dsjWidth
                
                let tufuh_btn = UIButton.tukou_bjBtn(
                    CGRect(x: CGFloat(10 * (i-1)) + tufuh_dsjWid4 - dsjWidth, y: 0, width: dsjWidth, height: 30),
                    target: self,
                    imageName: nil,
                    superView: self.tufuh_scrV4,
                    action: #selector(fuhan_clkNumT4(_:)),
                    font: TUOKOUXIUSwiftFont.regular(12),
                    title: tufuh_string,
                    color: TUOKOUXIUSwiftbaiseC,
                    bgColor: TUOKOUXIUSwiftZTClr2,
                    cornerRadius: 5
                )
                tufuh_btn.setTitleColor(TUOKOUXIUSwiftbaiseC, for: UIControl.State.selected)
                tufuh_btn.tag = i
                
                if i == tufuh_v4.count {
                    let offsetX = CGFloat(10 * (i - 1)) + tufuh_dsjWid4 + 10.0
                    self.tufuh_scrV4.contentSize = CGSize(width: offsetX, height: 30)
                }
                if i == 1 {
                    fuhan_clkNumT4(tufuh_btn)
                }
            }
        }
        
        self.tufuh_scrV5 = UIScrollView.tukou_bjScrollV(
            CGRect(x: 0, y: 160, width: TUOKOUXIUSwiftSCRE_W - 20, height: 30),
            superView: self,
            bgColor: nil
        )
        self.tufuh_scrV5.showsHorizontalScrollIndicator = false
        guard tufuh_arr1.count > 4 else { return }
        if let tufuh_d5 = tufuh_arr1[4] as? [String: Any],
           let tufuh_v5 = tufuh_d5["data"] as? [[String: Any]] {
            tufuh_ty5 = "\(tufuh_d5["module"] ?? "")"
            
            for i in 1...tufuh_v5.count {
                let tufuh_string = tufuh_v5[i-1]["name"] as? String ?? ""
                let dsjWidth = TUOKOUXIUSSStringUtils.tukou_sizWithT(
                    tufuh_string,
                    font: TUOKOUXIUSwiftFont.regular(14),
                    maxSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30)
                ).width + 20
                
                tufuh_dsjWid5 += dsjWidth
                
                let tufuh_btn = UIButton.tukou_bjBtn(
                    CGRect(x: CGFloat(10 * (i-1)) + tufuh_dsjWid5 - dsjWidth, y: 0, width: dsjWidth, height: 30),
                    target: self,
                    imageName: nil,
                    superView: self.tufuh_scrV5,
                    action: #selector(fuhan_clkNumT5(_:)),
                    font: TUOKOUXIUSwiftFont.regular(12),
                    title: tufuh_string,
                    color: TUOKOUXIUSwiftbaiseC,
                    bgColor: TUOKOUXIUSwiftZTClr2,
                    cornerRadius: 5
                )
                tufuh_btn.setTitleColor(TUOKOUXIUSwiftbaiseC, for: UIControl.State.selected)
                tufuh_btn.tag = i
                
                if i == tufuh_v5.count {
                    let offsetX = CGFloat(10 * (i - 1)) + tufuh_dsjWid5 + 10.0
                    self.tufuh_scrV5.contentSize = CGSize(width: offsetX, height: 30)
                }
                if i == 1 {
                    fuhan_clkNumT5(tufuh_btn)
                }
            }
        }
        
        self.tufuh_scrV6 = UIScrollView.tukou_bjScrollV(
            CGRect(x: 0, y: 200, width: TUOKOUXIUSwiftSCRE_W - 20, height: 30),
            superView: self,
            bgColor: nil
        )
        self.tufuh_scrV6.showsHorizontalScrollIndicator = false
        guard tufuh_arr1.count > 5 else { return }
        if let tufuh_d6 = tufuh_arr1[5] as? [String: Any],
           let tufuh_v6 = tufuh_d6["data"] as? [[String: Any]] {
            tufuh_ty6 = "\(tufuh_d6["module"] ?? "")"
            
            for i in 1...tufuh_v6.count {
                let tufuh_string = tufuh_v6[i-1]["name"] as? String ?? ""
                let dsjWidth = TUOKOUXIUSSStringUtils.tukou_sizWithT(
                    tufuh_string,
                    font: TUOKOUXIUSwiftFont.regular(14),
                    maxSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30)
                ).width + 20
                
                tufuh_dsjWid6 += dsjWidth
                
                let tufuh_btn = UIButton.tukou_bjBtn(
                    CGRect(x: CGFloat(10 * (i-1)) + tufuh_dsjWid6 - dsjWidth, y: 0, width: dsjWidth, height: 30),
                    target: self,
                    imageName: nil,
                    superView: self.tufuh_scrV6,
                    action: #selector(fuhan_clkNumT6(_:)),
                    font: TUOKOUXIUSwiftFont.regular(12),
                    title: tufuh_string,
                    color: TUOKOUXIUSwiftbaiseC,
                    bgColor: TUOKOUXIUSwiftZTClr2,
                    cornerRadius: 5
                )
                tufuh_btn.setTitleColor(TUOKOUXIUSwiftbaiseC, for: UIControl.State.selected)
                tufuh_btn.tag = i
                
                if i == tufuh_v6.count {
                    let offsetX = CGFloat(10 * (i - 1)) + tufuh_dsjWid6 + 10.0
                    self.tufuh_scrV6.contentSize = CGSize(width: offsetX, height: 30)
                }
                if i == 1 {
                    fuhan_clkNumT6(tufuh_btn)
                }
            }
        }
    }
}

extension TUOKOUXIUSwiftTTSSCollReusV {
    @objc func fuhan_clkNumT(_ btn: UIButton) {
        if btn.isSelected { return }
        if btn.tag < 1 { return }
        
        let tufuh_arr1 = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr
        guard let tufuh_d = tufuh_arr1[0] as? [String: Any],
              let tufuh_v = tufuh_d["data"] as? [[String: Any]] else { return }
        
        for i in 1...tufuh_v.count {
            if let tufuh_btnAll = tufuh_scrV.viewWithTag(i) as? UIButton {
                tufuh_btnAll.isSelected = false
                tufuh_btnAll.titleLabel?.font = TUOKOUXIUSwiftFont.regular(12)
                tufuh_btnAll.backgroundColor = TUOKOUXIUSwiftZTClr2
            }
        }
        
        btn.isSelected = true
        btn.backgroundColor = TUOKOUXIUSwiftZTClr
        btn.titleLabel?.font = TUOKOUXIUSwiftFont.semibold(12)
        fuhan_shoPoiToCenBtn(btn, andNum: 0)
        
        let tufuh_string = tufuh_v[btn.tag - 1]["value"] as? String ?? ""
        self.tufuh_name1 = tufuh_v[btn.tag - 1]["name"] as? String ?? ""
        
        tufuh_clkItemBlk?(tufuh_string, tufuh_ty1!)
    }
    
    @objc func fuhan_clkNumT2(_ btn: UIButton) {
        if btn.isSelected { return }
        if btn.tag < 1 { return }
        
        let tufuh_arr1 = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr
        guard let tufuh_d = tufuh_arr1[1] as? [String: Any],
              let tufuh_v = tufuh_d["data"] as? [[String: Any]] else { return }
        
        for i in 1...tufuh_v.count {
            if let tufuh_btnAll = tufuh_scrV2.viewWithTag(i) as? UIButton {
                tufuh_btnAll.isSelected = false
                tufuh_btnAll.titleLabel?.font = TUOKOUXIUSwiftFont.regular(12)
                tufuh_btnAll.backgroundColor = TUOKOUXIUSwiftZTClr2
            }
        }
        
        btn.isSelected = true
        btn.backgroundColor = TUOKOUXIUSwiftZTClr
        btn.titleLabel?.font = TUOKOUXIUSwiftFont.semibold(12)
        fuhan_shoPoiToCenBtn(btn, andNum: 1)
        
        let tufuh_string = tufuh_v[btn.tag - 1]["value"] as? String ?? ""
        self.tufuh_name2 = tufuh_v[btn.tag - 1]["name"] as? String ?? ""
        
        tufuh_clkItemBlk?(tufuh_string, tufuh_ty2!)
    }
    
    @objc func fuhan_clkNumT3(_ btn: UIButton) {
        if btn.isSelected { return }
        if btn.tag < 1 { return }
        
        let tufuh_arr1 = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr
        guard let tufuh_d = tufuh_arr1[2] as? [String: Any],
              let tufuh_v = tufuh_d["data"] as? [[String: Any]] else { return }
        
        for i in 1...tufuh_v.count {
            if let tufuh_btnAll = tufuh_scrV3.viewWithTag(i) as? UIButton {
                tufuh_btnAll.isSelected = false
                tufuh_btnAll.titleLabel?.font = TUOKOUXIUSwiftFont.regular(12)
                tufuh_btnAll.backgroundColor = TUOKOUXIUSwiftZTClr2
            }
        }
        
        btn.isSelected = true
        btn.backgroundColor = TUOKOUXIUSwiftZTClr
        btn.titleLabel?.font = TUOKOUXIUSwiftFont.semibold(12)
        fuhan_shoPoiToCenBtn(btn, andNum: 2)
        
        let tufuh_string = tufuh_v[btn.tag - 1]["value"] as? String ?? ""
        self.tufuh_name3 = tufuh_v[btn.tag - 1]["name"] as? String ?? ""
        
        tufuh_clkItemBlk?(tufuh_string, tufuh_ty3!)
    }
    
    @objc func fuhan_clkNumT4(_ btn: UIButton) {
        if btn.isSelected { return }
        if btn.tag < 1 { return }
        
        let tufuh_arr1 = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr
        guard let tufuh_d = tufuh_arr1[3] as? [String: Any],
              let tufuh_v = tufuh_d["data"] as? [[String: Any]] else { return }
        
        for i in 1...tufuh_v.count {
            if let tufuh_btnAll = tufuh_scrV4.viewWithTag(i) as? UIButton {
                tufuh_btnAll.isSelected = false
                tufuh_btnAll.titleLabel?.font = TUOKOUXIUSwiftFont.regular(12)
                tufuh_btnAll.backgroundColor = TUOKOUXIUSwiftZTClr2
            }
        }
        
        btn.isSelected = true
        btn.backgroundColor = TUOKOUXIUSwiftZTClr
        btn.titleLabel?.font = TUOKOUXIUSwiftFont.semibold(12)
        fuhan_shoPoiToCenBtn(btn, andNum: 3)
        
        let tufuh_string = tufuh_v[btn.tag - 1]["value"] as? String ?? ""
        self.tufuh_name4 = tufuh_v[btn.tag - 1]["name"] as? String ?? ""
        
        tufuh_clkItemBlk?(tufuh_string, tufuh_ty4!)
    }
    
    @objc func fuhan_clkNumT5(_ btn: UIButton) {
        if btn.isSelected { return }
        if btn.tag < 1 { return }
        
        let tufuh_arr1 = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr
        guard let tufuh_d = tufuh_arr1[4] as? [String: Any],
              let tufuh_v = tufuh_d["data"] as? [[String: Any]] else { return }
        
        for i in 1...tufuh_v.count {
            if let tufuh_btnAll = tufuh_scrV5.viewWithTag(i) as? UIButton {
                tufuh_btnAll.isSelected = false
                tufuh_btnAll.titleLabel?.font = TUOKOUXIUSwiftFont.regular(12)
                tufuh_btnAll.backgroundColor = TUOKOUXIUSwiftZTClr2
            }
        }
        
        btn.isSelected = true
        btn.backgroundColor = TUOKOUXIUSwiftZTClr
        btn.titleLabel?.font = TUOKOUXIUSwiftFont.semibold(12)
        fuhan_shoPoiToCenBtn(btn, andNum: 4)
        
        let tufuh_string = tufuh_v[btn.tag - 1]["value"] as? String ?? ""
        self.tufuh_name5 = tufuh_v[btn.tag - 1]["name"] as? String ?? ""
        
        tufuh_clkItemBlk?(tufuh_string, tufuh_ty5!)
    }
    
    @objc func fuhan_clkNumT6(_ btn: UIButton) {
        if btn.isSelected { return }
        if btn.tag < 1 { return }
        
        let tufuh_arr1 = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_expConArr
        guard let tufuh_d = tufuh_arr1[5] as? [String: Any],
              let tufuh_v = tufuh_d["data"] as? [[String: Any]] else { return }
        
        for i in 1...tufuh_v.count {
            if let tufuh_btnAll = tufuh_scrV6.viewWithTag(i) as? UIButton {
                tufuh_btnAll.isSelected = false
                tufuh_btnAll.titleLabel?.font = TUOKOUXIUSwiftFont.regular(12)
                tufuh_btnAll.backgroundColor = TUOKOUXIUSwiftZTClr2
            }
        }
        
        btn.isSelected = true
        btn.backgroundColor = TUOKOUXIUSwiftZTClr
        btn.titleLabel?.font = TUOKOUXIUSwiftFont.semibold(12)
        fuhan_shoPoiToCenBtn(btn, andNum: 5)
        
        let tufuh_string = tufuh_v[btn.tag - 1]["value"] as? String ?? ""
        self.tufuh_name6 = tufuh_v[btn.tag - 1]["name"] as? String ?? ""
        
        tufuh_clkItemBlk?(tufuh_string, tufuh_ty6!)
    }
}
