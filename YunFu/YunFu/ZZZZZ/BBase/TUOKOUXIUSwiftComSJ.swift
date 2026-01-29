import AppTrackingTransparency
import UIKit
import Foundation
import AdSupport
import Kingfisher
import CommonCrypto
import ZIPFoundation

final class TUOKOUXIUSwiftComSJ: NSObject {
    
    static let tukou_sLcom = TUOKOUXIUSwiftComSJ()
    
    private override init() {}
    
    var tufuh_isOpenHomeMusicExpand: Bool = false
    var tufuh_isEnterApp: Bool = true
    var tufuh_homeArray: [SceneModel] = []
    var tufuh_sortArray: [String] = []
    var tufuh_selectNum: Int = 0
    var tufuh_metaInfo: MetaInfo?
    var isClickLeftAndRight: Bool = false
    var isAlarmBellOpen: Bool = false
    var tufuh_iconUrl: String?
    var tufuh_iconUrlExist: Bool = false
    var tufuh_v_placeStr: String?
    var tufuh_isTrial: Bool = false
    private var tufuh_loadV: UIView?
        
    func tukou_jiaZIcon(_ iconUrl: String, andIsOne isOne: Bool) -> UIImage? {
        var iconPath = iconUrl

        if !isOne {
            let tufuh_scaF = UIScreen.main.scale

                if tufuh_scaF == 2.0 {
                    iconPath = "\(iconUrl)@2x"
                } else {
                    iconPath = "\(iconUrl)@3x"
                }
            
        }
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let fullPath = (documentsPath as NSString).appendingPathComponent(iconPath)

        return UIImage(contentsOfFile: fullPath)
    }
        
    func tukou_tipsV() {
        if Thread.isMainThread {
            TUOKOUXIUSwiftKeyWindow()!.makeToast("Content load failure, please try again later!", duration: 4.0, position: .center)
        } else {
            DispatchQueue.main.async {
                TUOKOUXIUSwiftKeyWindow()!.makeToast("Content load failure, please try again later!", duration: 4.0, position: .center)
            }
        }
    }
        
    func tukou_jzGFV(_ view: UIView?) {
        tukou_gbGFV()
        
        guard let view = view else { return }
        
        let width = min(TUOKOUXIUSwiftSCRE_W, TUOKOUXIUSwiftSCRE_H)
        let height = max(TUOKOUXIUSwiftSCRE_W, TUOKOUXIUSwiftSCRE_H)
        
        let loadV = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        loadV.backgroundColor = TUOKOUXIUSwiftwuseC
        view.addSubview(loadV)
        self.tufuh_loadV = loadV
        
        let aniV = AnimatedImageView(frame: CGRect(x: width/2 - 19.5, y: height/2 - 18, width: 39, height: 36))
        aniV.center = loadV.center
        loadV.addSubview(aniV)
        
        if let gifURL = Bundle.main.url(forResource: "gf_tukou_load", withExtension: "gif") {
            DispatchQueue.main.async {
                aniV.kf.setImage(with: gifURL)
            }
        }
    }
        
    func tukou_gbGFV() {
        if Thread.isMainThread {
            if let loadV = self.tufuh_loadV {
                loadV.isHidden = true
                loadV.removeFromSuperview()
                self.tufuh_loadV = nil
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                if let loadV = self?.tufuh_loadV {
                    loadV.isHidden = true
                    loadV.removeFromSuperview()
                    self?.tufuh_loadV = nil
                }
            }
        }
    }

}
