import AppTrackingTransparency
import StoreKit
import UIKit
import Foundation
import AdSupport
import Kingfisher
import CommonCrypto
import ZIPFoundation

final class TUOKOUXIUSwiftComSJ: NSObject {
    
    static let tukou_sLcom = TUOKOUXIUSwiftComSJ()
    
    private override init() {}
    
    var tufuh_isHTTZ: Bool = false
    var tufuh_isOutBFV: Bool = false


    var tufuh_isPushEnabled: Bool = false
    var tufuh_isDSJu: Bool = false
    var tufuh_isADXS: Bool = false
    var tufuh_isHenPinMP: Bool = false
    
    var tufuh_dataDict: [String: Any]?
    var tufuh_dsJiDict: [String: Any]?
    
    var tufuh_zmArr: NSMutableArray = NSMutableArray()
    var tufuh_phArr: [Any] = []
    var tufuh_dsijuArr: [Any] = []
    var tufuh_dsJiArr: [Any] = []
    
    var tufuh_zmSet: NSMutableSet = NSMutableSet()
    var tufuh_staSArr: [Any] = []
    var tufuh_hhTabsArr: [Any] = []
    var tufuh_xkgDict: [String: Any]?
    var tufuh_routesArr: [Any] = []
    
    var tufuh_iconUrl: String?
    var tufuh_iconUrlExist: Bool = false
    var tufuh_ic_hh_titPl: String?
    var tufuh_ic_adPl: String?
    
    var tufuh_seasNum: Int = 0
    var tufuh_jiCode: Int = 0
    var tufuh_jiNum: Int = 0
    
    var tufuh_v_placeStr: String?
    var tufuh_jiclaIdCode: Int = 0

    
    var tufuh_huazhi: String?
    var tufuh_jiName: String?
    var tufuh_name: String?
    var tufuh_hbUrl: String?
    var tufuh_pingfen: String?
    
    
    var tufuh_expConArr: [Any] = []
    var tufuh_hotArr: [Any] = []
    var tufuh_tttArr: [Any] = []
    
    var tufuh_isGouMaiVpYue: Bool = false
    var tufuh_isXianShiZM: Bool = false
    var tufuh_isLandSXSAD: Bool = false
    var tufuh_isPhotoXS: Bool = false
    var tufuh_isHenP: Bool = false
    var tufuh_isBFRet: Bool = false
    
    var tufuh_bfyeKey: [String: Any]?
    var tufuh_dataStr: String?
    var tufuh_scode: Int = 0

    var tufuh_isTrial: Bool = false
    var tufuh_subPriStr: String?
    var tufuh_isDQKaiGuan: Bool = false
    var tufuh_fwqFailCode: Int = 0
    var tufuh_fwqFailStr: String?
    
    private var tufuh_loadV: UIView?
    
     func tukou_downT(
        _ urlStr: String,
        andPro progress: ((Progress) -> Void)?,
        comHandler completionHandler: @escaping (
            URLResponse?,
            URL?,
            Error?,
            String,
            String
        ) -> Void
    ) {
        var fileName = (urlStr as NSString).lastPathComponent
        if fileName.hasSuffix(".srt") {
            fileName = "123456789.srt"
        }
        
        let cacheDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last ?? ""
        let filePath = (cacheDir as NSString).appendingPathComponent(fileName)
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            try? fileManager.removeItem(atPath: filePath)
        }
        
        guard let url = URL(string: urlStr) else {
            completionHandler(nil, nil, NSError(domain: "InvalidURL", code: -1), "", "")
            return
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 30.0
        
        let task = URLSession.shared.downloadTask(with: request) { tempURL, response, error in
            do {
                guard let tempURL = tempURL else {
                    completionHandler(response, nil, error, "", "")
                    return
                }
                
                let destURL = URL(fileURLWithPath: filePath)
                try? fileManager.removeItem(at: destURL)
                try fileManager.moveItem(at: tempURL, to: destURL)
                
                var lastFileContent: String = ""
                let absPath = destURL.path
                
                if absPath.hasSuffix(".zip") {
                    let desPath = absPath.replacingOccurrences(of: ".zip", with: "")
                    if self.tukou_unzipFile(at: URL(fileURLWithPath: absPath)) {   
                    } else {
                    }
                    let zipURL = URL(fileURLWithPath: absPath)
                    let destURL = URL(fileURLWithPath: desPath)
                    try? FileManager.default.createDirectory(at: destURL, withIntermediateDirectories: true)
                    try? FileManager.default.unzipItem(at: zipURL, to: destURL)
                    
                    let srtPath = desPath.replacingOccurrences(of: ".srt", with: " 2.srt")
                    let srtStr = try? String(contentsOfFile: srtPath, encoding: .utf8)
                    
                    if TUOKOUXISSUUtils.tukou_isStringEmpty(srtStr) {
                        completionHandler(response, destURL, error, "", "")
                        return
                    }
                    
                    let regex = try? NSRegularExpression(pattern: #"^\d+$\n"#, options: [.anchorsMatchLines])
                    let fileContent = regex?.stringByReplacingMatches(in: srtStr ?? "", options: [], range: NSRange(location: 0, length: srtStr?.count ?? 0), withTemplate: "") ?? ""
                    
                    try? fileManager.removeItem(atPath: absPath)
                    try? fileManager.removeItem(atPath: srtPath)
                    
                    lastFileContent = fileContent
                } else if absPath.hasSuffix(".vtt") {
                    let fileData = try? Data(contentsOf: destURL)
                    let fileStr = fileData.flatMap { String(data: $0, encoding: .utf8) } ?? ""
                    try? fileManager.removeItem(at: destURL)
                    lastFileContent = fileStr
                } else if absPath.hasSuffix(".srt") {
                    let srtStr = try? String(contentsOfFile: absPath, encoding: .utf8)
                    if TUOKOUXISSUUtils.tukou_isStringEmpty(srtStr) {
                        completionHandler(response, destURL, error, "", "")
                        return
                    }
                    
                    let regex = try? NSRegularExpression(pattern: #"^\d+$\n"#, options: [.anchorsMatchLines])
                    let fileContent = regex?.stringByReplacingMatches(in: srtStr ?? "", options: [], range: NSRange(location: 0, length: srtStr?.count ?? 0), withTemplate: "") ?? ""
                    
                    try? fileManager.removeItem(atPath: absPath)
                    lastFileContent = fileContent
                }
                
                if error == nil {
                    completionHandler(response, destURL, nil, filePath, lastFileContent)
                } else {
                    var message = "Unknown error"
                    if let err = error as NSError? {
                        if err.code == -1005 {
                            message = "Network anomaly"
                        } else if err.code == -1001 {
                            message = "Request timeout"
                        }
                    }
                    print("message: \(message)")
                    completionHandler(response, destURL, error, "", "")
                }
                
            } catch {
                print("Exception: \(error)")
                completionHandler(nil, nil, error, "", "")
            }
        }
        
        if !TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isOutBFV {
            task.resume()
        }
    }
    
    func tukou_unzipFile(at zipURL: URL) -> Bool {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            let archive = try Archive(url: zipURL, accessMode: .read)
            for entry in archive {
                if entry.path.hasPrefix("__MACOSX/") || entry.path.hasPrefix("._") {
                    continue
                }
                guard let fileName = entry.path.components(separatedBy: "/").last else { continue }
                let entryDestURL = documentsURL.appendingPathComponent(fileName)
                
                if FileManager.default.fileExists(atPath: entryDestURL.path) {
                    try FileManager.default.removeItem(at: entryDestURL)
                }
                _ = try archive.extract(entry, to: entryDestURL)
            }
            return true
        } catch {
            return false
        }
    }
        
    func tukou_reqIdfa() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .notDetermined:
                    break
                case .restricted:
                    break
                case .denied:
                    break
                case .authorized:
                    break
                @unknown default:
                    break
                }
            }
        } else {
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            
            } else {
             
            }
        }
    }
        
    func tukou_dictForJsonD(_ jsonData: Data) -> [String: Any]? {
        guard !jsonData.isEmpty else { return nil }
        if let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments),
           let dict = jsonObject as? [String: Any] {
            return dict
        }
        return nil
    }
        
    func tukoumd_reqBaUrl() -> String? {
        guard let path = Bundle.main.path(forResource: "TUOKOUXIUConfig", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: Any],
              let envStr = dict["Environment"] as? String else {
            return TUOKOUXIUSwiftConst.TUOKOUXIUMaiDevBaseUrl
        }
        
        switch envStr {
        case "Product":
            return TUOKOUXIUSwiftConst.TUOKOUXIUMaiProdBaseUrl
        case "Gamma", "Develop":
            return TUOKOUXIUSwiftConst.TUOKOUXIUMaiDevBaseUrl
        default:
            return TUOKOUXIUSwiftConst.TUOKOUXIUMaiDevBaseUrl
        }
    }
        
    func tukou_jiaZIcon(_ iconUrl: String, andIsOne isOne: Bool) -> UIImage? {
        var iconPath = iconUrl

        if !isOne {
            let tufuh_scaF = UIScreen.main.scale
            if TUOKOUXIUSSApp.tukou_isPad() {
                iconPath = "\(iconUrl)@3x"
            } else {
                if tufuh_scaF == 2.0 {
                    iconPath = "\(iconUrl)@2x"
                } else {
                    iconPath = "\(iconUrl)@3x"
                }
            }
        }
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let fullPath = (documentsPath as NSString).appendingPathComponent(iconPath)

        return UIImage(contentsOfFile: fullPath)
    }
        
    func tukou_bacImGfUrl(_ iconUrl: String) -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        return (documentsPath as NSString).appendingPathComponent(iconUrl)
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
        
    func tukou_shuJJM(_ dict: [String: Any]) -> String {
        guard let tsData = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
            return ""
        }
        let gyStr = TUOKOUXIUSwiftConst.TUOKOUXIUSwiftGYTou +
                    TUOKOUXIUSwiftConst.TUOKOUXIUSwiftAFT + "\n" +
                    TUOKOUXIUSwiftConst.TUOKOUXIUSwiftAFW + "\n" +
                    TUOKOUXIUSwiftConst.TUOKOUXIUSwiftGYWei
        guard let gyData = gyStr.data(using: .utf8) else {
            return ""
        }
        let encData: Data? = gyData.withUnsafeBytes { (ptr: UnsafeRawBufferPointer) -> Data? in
            guard let baseAddress = ptr.baseAddress else { return nil }
            guard let bio = BIO_new_mem_buf(baseAddress, Int32(gyData.count)) else { return nil }
            defer { BIO_free(bio) }
            guard let rsa = PEM_read_bio_RSA_PUBKEY(bio, nil, nil, nil) else { return nil }
            defer { RSA_free(rsa) }
            return TUOKOUXIUSSRSAUtil.tukou_encWithRSA(rsa, plainData: tsData, isPublicKey: true)
        }

        return encData?.base64EncodedString() ?? ""
    }
        
    func tukou_shuJDKM(_ base64String: String) -> String {
        let syStr = TUOKOUXIUSwiftConst.TUOKOUXIUSwiftSYTou +
                    TUOKOUXIUSwiftConst.TUOKOUXIUSwiftAFX + "\n" +
                    TUOKOUXIUSwiftConst.TUOKOUXIUSwiftAFL + "\n" +
                    TUOKOUXIUSwiftConst.TUOKOUXIUSwiftAFE + "\n" +
                    TUOKOUXIUSwiftConst.TUOKOUXIUSwiftAFS + "\n" +
                    TUOKOUXIUSwiftConst.TUOKOUXIUSwiftAFB + "\n" +
                    TUOKOUXIUSwiftConst.TUOKOUXIUSwiftAFZ + "\n" +
                    TUOKOUXIUSwiftConst.TUOKOUXIUSwiftAFZZ + "\n" +
                    TUOKOUXIUSwiftConst.TUOKOUXIUSwiftAFYYY + "\n" +
                    TUOKOUXIUSwiftConst.TUOKOUXIUSwiftSYWei
        guard let keyData = syStr.data(using: .utf8) else { return "" }
        
        var result = ""
        keyData.withUnsafeBytes { ptr in
            guard let baseAddr = ptr.baseAddress else { return }
            guard let bio = BIO_new_mem_buf(baseAddr, Int32(keyData.count)) else { return }
            defer { BIO_free(bio) }
            guard let rsa = PEM_read_bio_RSAPrivateKey(bio, nil, nil, nil) else { return }
            defer { RSA_free(rsa) }
            
            guard let cipherData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters),
                  let cipherStr = String(data: cipherData, encoding: .utf8) else { return }
            
            let segments = cipherStr.components(separatedBy: ",")
            for seg in segments {
                if let segData = Data(base64Encoded: seg, options: .ignoreUnknownCharacters),
                   let decData = TUOKOUXIUSSRSAUtil.tukou_decWithRSA(rsa, cipherData: segData, isPublicKey: false),
                   let decStr = String(data: decData, encoding: .utf8) {
                    result += decStr
                }
            }
        }
        return result
    }
        
    func tukou_backReqUrl(url: URL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(TUOKOUXIUSSApp.tukou_locaLang(), forHTTPHeaderField: "cl")
        request.setValue(TUOKOUXIUSSApp.tukou_sysVer(), forHTTPHeaderField: "osver")
        request.setValue("2", forHTTPHeaderField: "prodid")
        request.setValue(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftAppId, forHTTPHeaderField: "appid")
        request.setValue(TUOKOUXIUSSApp.tukou_phoDevCo(), forHTTPHeaderField: "idid")
        request.setValue(TUOKOUXIUSSApp.tukou_idfi(), forHTTPHeaderField: "bid")
        request.setValue(TUOKOUXIUSSApp.tukou_sysVer(), forHTTPHeaderField: "os-version")
        request.setValue(TUOKOUXIUSSApp.tukou_appVer(), forHTTPHeaderField: "app-version")
        
        let countryCode = Locale.current.regionCode ?? ""
        let countryName = Locale.current.localizedString(forRegionCode: countryCode) ?? ""
        request.setValue(countryName, forHTTPHeaderField: "country")
        request.setValue(countryCode, forHTTPHeaderField: "countrycode")
        
        let vpn = TUOKOUXIUSSApp.tukou_isVPN() ? "1" : "2"
        request.setValue(vpn, forHTTPHeaderField: "vpn")
        
        var lat = "2"
        var idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        if idfa.isEmpty || idfa == "00000000-0000-0000-0000-000000000000" {
            idfa = "00000000-0000-0000-0000-000000000000"
        } else {
            lat = "1"
        }
        request.setValue(idfa, forHTTPHeaderField: "idfa")
        request.setValue(TUOKOUXIUSSApp.tukou_phoIFv(), forHTTPHeaderField: "idfv")
        request.setValue(lat, forHTTPHeaderField: "lat")
        
        let push = self.tufuh_isPushEnabled ? "1" : "2"
        request.setValue(push, forHTTPHeaderField: "push")
        
        return request
    }
        
    func tukou_currVC() -> UIViewController? {
        guard var rVC = TUOKOUXIUSwiftKeyWindow()!.rootViewController else {
            return nil
        }
        while let pVC = rVC.presentedViewController {
            rVC = pVC
        }
        while let nav = rVC as? UINavigationController, let topVC = nav.topViewController {
            rVC = topVC
        }
        return rVC
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
        
        let gifPath = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_bacImGfUrl("gf_tukou_load.gif")
        let gifURL = URL(fileURLWithPath: gifPath)
        DispatchQueue.main.async { aniV.kf.setImage(with: gifURL) }
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
        
    func tukou_bacYMDT() -> String {
        let currDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: currDate)
    }
    
    func fuhan_reqBDUrl(_ tufuh_id: String, andTp tp: String) -> String {
        guard let proArr = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(tufuh_id) else {
            return ""
        }

        if tp == "1" {
            if proArr.count > 4 {
                return "\(proArr[4])"
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
}
