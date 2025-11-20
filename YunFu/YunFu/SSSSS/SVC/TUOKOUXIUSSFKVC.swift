
import Foundation
import UIKit

let TUOKOUXIUFeedbackStr                 =  "Enter your feedback content..."
let TUOKOUXIUEmailStr                    = "Enter your email"

class TUOKOUXIUSSFKVC: TUOKOUXIUSwiftBaseVC, UITextViewDelegate {
    
    private let tufuh_fTextV = UITextView()
    private let tufuh_eTextV = UITextView()
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
        
        tufuh_topV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight), superView: view, bgColor: TUOKOUXIUSwiftheiseC)
        tufuh_topNavV = UIView.tukou_bjView(CGRect(x: 0, y: tufuh_topV.frame.maxY, width: TUOKOUXIUSwiftSCRE_W, height: 56), superView: view, bgColor: TUOKOUXIUSwiftheiseC)
        
        let tufuh_backIV = UIImageView.tukou_bjImageV(CGRect(x: 10, y: 16, width: 24, height: 24), superView: tufuh_topNavV, image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_nav_top_left", andIsOne: false))
        tufuh_backIV.isUserInteractionEnabled = true
        tufuh_backIV.tukou_addTapGesture(target: self, action: #selector(tukou_goBack))
        
        UILabel.tukou_bjLabel(CGRect(x: TUOKOUXIUSwiftSCRE_W/2 - 100, y: 17, width: 200, height: 22), text: "Feedback", superView: tufuh_topNavV, textAlignment: .center, font: TUOKOUXIUSwiftFont.semibold(17), textColor: TUOKOUXIUSwiftbaiseC)
        
        let tufuh_feedbackL = UILabel.tukou_bjLabel(CGRect(x: 20, y: tufuh_topNavV.frame.maxY + 15, width: 200, height: 22), text: "Feedback content", superView: view, textAlignment: .left, font: TUOKOUXIUSwiftFont.semibold(17), textColor: TUOKOUXIUSwiftZTClr2A)
        
        tufuh_fTextV.frame = CGRect(x: 12, y: tufuh_feedbackL.frame.maxY + 5, width: TUOKOUXIUSwiftSCRE_W - 24, height: 220)
        tufuh_fTextV.text = TUOKOUXIUFeedbackStr
        tufuh_fTextV.backgroundColor = TUOKOUXIUSwiftZTClr2
        tufuh_fTextV.returnKeyType = .done
        tufuh_fTextV.delegate = self
        tufuh_fTextV.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        tufuh_fTextV.showsVerticalScrollIndicator = false
        tufuh_fTextV.layer.cornerRadius = 8
        tufuh_fTextV.font = TUOKOUXIUSwiftFont.medium(14)
        tufuh_fTextV.textColor = TUOKOUXIUSwiftZTClr4A
        tufuh_fTextV.tintColor = TUOKOUXIUSwiftbaiseC
        tufuh_fTextV.layer.masksToBounds = true
        view.addSubview(tufuh_fTextV)
        
        let tufuh_emailL = UILabel.tukou_bjLabel(CGRect(x: 12, y: tufuh_fTextV.frame.maxY + 20, width: 200, height: 22), text: "Email", superView: view, textAlignment: .left, font: TUOKOUXIUSwiftFont.semibold(16), textColor: TUOKOUXIUSwiftZTClr2A)
        
        tufuh_eTextV.frame = CGRect(x: 12, y: tufuh_emailL.frame.maxY + 5, width: TUOKOUXIUSwiftSCRE_W - 24, height: 48)
        tufuh_eTextV.text = TUOKOUXIUEmailStr
        tufuh_eTextV.backgroundColor = TUOKOUXIUSwiftZTClr2
        tufuh_eTextV.font = TUOKOUXIUSwiftFont.medium(14)
        tufuh_eTextV.returnKeyType = .done
        tufuh_eTextV.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        tufuh_eTextV.delegate = self
        tufuh_eTextV.showsVerticalScrollIndicator = false
        tufuh_eTextV.layer.cornerRadius = 8
        tufuh_eTextV.textColor = TUOKOUXIUSwiftZTClr4A
        tufuh_eTextV.tintColor = TUOKOUXIUSwiftbaiseC
        tufuh_eTextV.layer.masksToBounds = true
        view.addSubview(tufuh_eTextV)
        
        let tufuh_submitL = UILabel.tukou_bjLabel(CGRect(x: 12, y: TUOKOUXIUSwiftSCRE_H - 91, width: TUOKOUXIUSwiftSCRE_W - 24, height: 51), text: "Submit", superView: view, textAlignment: .center, font: TUOKOUXIUSwiftFont.semibold(16), textColor: TUOKOUXIUSwiftbaiseC)
        tufuh_submitL.backgroundColor = TUOKOUXIUSwiftZTClr
        tufuh_submitL.isUserInteractionEnabled = true
        tufuh_submitL.layer.cornerRadius = 8
        tufuh_submitL.layer.masksToBounds = true
        
        tufuh_submitL.tukou_addTapGesture(target: self, action: #selector(tukou_clickDone))
    }
    
    @objc private func tukou_clickDone() {
        guard (TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0) else {
            TUOKOUXIUSwiftKeyWindow()!.makeToast("Network connection failed!", duration: 2.0, position: .center)
            return
        }

        let message = tufuh_fTextV.text ?? ""
        if message.isEmpty || message == TUOKOUXIUFeedbackStr {
            TUOKOUXIUSwiftKeyWindow()!.makeToast("Please enter your feedback content!", duration: 2.0, position: .center)
            return
        }

        let email = tufuh_eTextV.text ?? ""
        if email.isEmpty || email == TUOKOUXIUEmailStr {
            TUOKOUXIUSwiftKeyWindow()!.makeToast("Please enter your email!", duration: 2.0, position: .center)
            return
        }

        TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jzGFV(TUOKOUXIUSwiftKeyWinRoV)
        TUOKOUXIUSwiftDelaBlk(1.0) {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftDelaBlk(0.1) {
                TUOKOUXIUSwiftKeyWindow()!.makeToast("Feedback successful!", duration: 2.0, position: .center)
                TUOKOUXIUSwiftDelaBlk(0.2) { [self] in
                    tukou_goBack()
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func tukou_goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.isEmpty {
            if textView === tufuh_fTextV {
                textView.text = TUOKOUXIUFeedbackStr
                textView.textColor = TUOKOUXIUSwiftZTClr4A
            } else {
                textView.text = TUOKOUXIUEmailStr
                textView.textColor = TUOKOUXIUSwiftZTClr4A
            }
        } else {
            textView.textColor = TUOKOUXIUSwiftbaiseC
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView === tufuh_fTextV && textView.text == TUOKOUXIUFeedbackStr {
            textView.text = ""
            textView.textColor = TUOKOUXIUSwiftbaiseC
        } else if textView === tufuh_eTextV && textView.text == TUOKOUXIUEmailStr {
            textView.text = ""
            textView.textColor = TUOKOUXIUSwiftbaiseC
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            view.endEditing(true)
            return false
        }
        return true
    }
}
