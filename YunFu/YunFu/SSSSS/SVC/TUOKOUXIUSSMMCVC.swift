
import Foundation
import UIKit

class TUOKOUXIUSSMMCVC: TUOKOUXIUSwiftBaseVC, UITextFieldDelegate {
    
    private let tufuh_textF = UITextField()
    private var tufuh_topV: UIView!
    private var tufuh_topNavV: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = TUOKOUXIUSwiftheiseC
        
        tukou_topVi()
    }
    
    func tukou_topVi() {
        tufuh_topV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight), superView: view, bgColor: TUOKOUXIUSwiftheiseC)
        tufuh_topNavV = UIView.tukou_bjView(CGRect(x: 0, y: tufuh_topV.frame.maxY, width: TUOKOUXIUSwiftSCRE_W, height: 56), superView: view, bgColor: TUOKOUXIUSwiftheiseC)
        let tufuh_backIV = UIImageView.tukou_bjImageV(CGRect(x: 10, y: 16, width: 24, height: 24), superView: tufuh_topNavV, image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_nav_top_left", andIsOne: false))
        tufuh_backIV.isUserInteractionEnabled = true
        tufuh_backIV.tukou_addTapGesture(target: self, action: #selector(tukou_goBack))
        
        UILabel.tukou_bjLabel(CGRect(x: 44, y: 17, width: TUOKOUXIUSwiftSCRE_W-88, height: 22), text: "Edit Profile", superView: tufuh_topNavV, textAlignment: .center, font: TUOKOUXIUSwiftFont.semibold(16), textColor: TUOKOUXIUSwiftbaiseC)
        
        UIImageView.tukou_bjImageV(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-40, y: tufuh_topNavV.frame.maxY + 12, width: 80, height: 80), superView: view, image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_st_me", andIsOne: false))
        
        UILabel.tukou_bjLabel(CGRect(x: 12, y: tufuh_topNavV.frame.maxY + 118, width: 100, height: 19), text: "Username", superView: view, textAlignment: .left, font: TUOKOUXIUSwiftFont.semibold(16), textColor: TUOKOUXIUSwiftZTClr2A)
        
        tufuh_textF.frame = CGRect(x: 12, y: tufuh_topNavV.frame.maxY + 145, width: TUOKOUXIUSwiftSCRE_W - 24, height: 48)
        tufuh_textF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 48))
        tufuh_textF.leftViewMode = .always
        tufuh_textF.textColor = TUOKOUXIUSwiftbaiseC
        tufuh_textF.backgroundColor = TUOKOUXIUSwiftZTClr2
        tufuh_textF.layer.cornerRadius = 8
        tufuh_textF.layer.masksToBounds = true
        tufuh_textF.borderStyle = .roundedRect
        tufuh_textF.tintColor = TUOKOUXIUSwiftZTClr
        tufuh_textF.font = TUOKOUXIUSwiftFont.medium(14)
        tufuh_textF.attributedPlaceholder = NSAttributedString(string: "Enter nickname", attributes: [.foregroundColor: TUOKOUXIUSwiftbaiseC])
        tufuh_textF.keyboardType = .default
        tufuh_textF.returnKeyType = .done
        tufuh_textF.delegate = self
        view.addSubview(tufuh_textF)
        
        UIButton.tukou_bjBtn(CGRect(x: 12, y: TUOKOUXIUSwiftSCRE_H - 91, width: TUOKOUXIUSwiftSCRE_W - 24, height: 51), target: self, imageName: nil, superView: view, action: #selector(tukou_gengxin), font: TUOKOUXIUSwiftFont.semibold(16), title: "Update", color: TUOKOUXIUSwiftbaiseC, bgColor: TUOKOUXIUSwiftZTClr, cornerRadius: 8)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc private func tukou_gengxin() {
        guard let text = tufuh_textF.text, !TUOKOUXISSUUtils.tukou_isStringEmpty(text) else {
            TUOKOUXIUSwiftKeyWindow()!.makeToast("The username cannot be empty!", duration: 2.0, position: .center)
            return
        }

        TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jzGFV(TUOKOUXIUSwiftKeyWinRoV)
        UserDefaults.standard.set(tufuh_textF.text, forKey: TUOKOUXIUSwiftConst.TUOKOUXIUSwiftYHMing)

        TUOKOUXIUSwiftDelaBlk(0.15) {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            self.tukou_goBack()
        }
    }
    @objc private func tukou_goBack() {
        navigationController?.popViewController(animated: true)
    }
}
