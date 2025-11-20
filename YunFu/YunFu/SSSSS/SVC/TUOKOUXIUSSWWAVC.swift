
import Foundation
import UIKit

class TUOKOUXIUSSWWAVC: TUOKOUXIUSwiftBaseVC {
    var tufuh_titS: String = ""
    var tufuh_conS: String = ""
    
    private var tufuh_topV: UIView!
    private var tufuh_tNavV: UIView!
    private var tufuh_mScrV: UIScrollView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TUOKOUXIUSwiftbaiseC
        tufuh_topV = UIView.tukou_bjView(
            CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight),
            superView: view,
            bgColor: TUOKOUXIUSwiftheiseC
        )
        
        tufuh_tNavV = UIView.tukou_bjView(
            CGRect(x: 0, y: tufuh_topV.frame.maxY, width: TUOKOUXIUSwiftSCRE_W, height: 56),
            superView: view,
            bgColor: TUOKOUXIUSwiftheiseC
        )
        let tufuh_iV = UIImageView.tukou_bjImageV(
            CGRect(x: 10, y: 16, width: 24, height: 24),
            superView: tufuh_tNavV,
            image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_nav_top_left", andIsOne: false)
        )
        tufuh_iV.isUserInteractionEnabled = true
        tufuh_iV.tukou_addTapGesture(target: self, action: #selector(tukou_goBack))
        
        UILabel.tukou_bjLabel(
            CGRect(x: TUOKOUXIUSwiftSCRE_W/2 - 100, y: 17, width: 200, height: 22),
            text: tufuh_titS,
            superView: tufuh_tNavV,
            textAlignment: .center,
            font: TUOKOUXIUSwiftFont.semibold(17),
            textColor: TUOKOUXIUSwiftbaiseC
        )
        tufuh_mScrV = UIScrollView.tukou_bjScrollV(
            CGRect(x: 0, y: tufuh_tNavV.frame.maxY, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H - tufuh_tNavV.frame.maxY),
            superView: view,
            bgColor: nil
        )
        let tufuh_sss = tufuh_conS.replacingOccurrences(of: "￥", with: "\n")
        let tufuh_maxSize = CGSize(width: TUOKOUXIUSwiftSCRE_W - 20, height: CGFloat.greatestFiniteMagnitude)
        let tufuh_textHeight = TUOKOUXIUSSStringUtils.tukou_sizWithT(tufuh_sss, font: TUOKOUXIUSwiftFont.regular(15), maxSize: tufuh_maxSize).height

        let tufuh_h = tufuh_textHeight + 20
        
        let contL = UILabel.tukou_bjLabel(
            CGRect(x: 10, y: 0, width: TUOKOUXIUSwiftSCRE_W - 20, height: tufuh_h),
            text: tufuh_sss,
            superView: tufuh_mScrV,
            textAlignment: .left,
            font: TUOKOUXIUSwiftFont.regular(15),
            textColor: TUOKOUXIUSwiftheiseC
        )
        
        contL.numberOfLines = 0
                tufuh_mScrV.contentSize = CGSize(width: TUOKOUXIUSwiftSCRE_W, height: tufuh_h + 30)
    }
    
    @objc func tukou_goBack() {
        navigationController?.popViewController(animated: true)
    }
}
