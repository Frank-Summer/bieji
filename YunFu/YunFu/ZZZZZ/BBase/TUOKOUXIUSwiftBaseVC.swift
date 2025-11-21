
import Foundation
import UIKit
import Alamofire
import Combine

typealias TUOKOUXIU_SuccessBlk = (_ isSuccess: Bool) -> Void

class TUOKOUXIUSwiftBaseVC: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    var tufuh_block: TUOKOUXIU_SuccessBlk?
    var tufuh_isFirTke: Bool = false
    var tufuh_isFirTkeRes: Bool = false
    var tufuh_isFirRouT: Bool = false
    var tufuh_isFirRouTRes: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
            let navBar = UINavigationBarAppearance()
            navBar.backgroundColor = TUOKOUXIUSwiftbaiseC
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBar
            self.navigationController?.navigationBar.standardAppearance = navBar
        
    }
    
    func tukou_checkCode(_ dataDict: Any?, andResultBlk block: TUOKOUXIU_SuccessBlk?) {
        guard let tufuh_c = dataDict as? String else { return }
        
        if tufuh_c == "1003" {
            tukou_reqTK()
            self.tufuh_block = block
        } else {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            
        }
    }
    
    func tukou_loadDataStr(_ dataString: String?) {
        guard let dataString = dataString else {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            reportFail(reason: "data format error2")
            return
        }
        if dataString.isEmpty {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            reportFail(reason: "data null")
            return
        }
        guard let jsonData = dataString.data(using: .utf8),
              let tufuh_dict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            reportFail(reason: "data format error3")
            return
        }
        let tufuh_tk = tufuh_dict["tk"] as? String

        guard let tufuh_tk, !tufuh_tk.isEmpty else {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            reportFail(reason: "token null")
            return
        }
        
        let tufuh_staSArr = tufuh_dict["staticresources"] as? [[String: Any]] ?? []
        
        let sLcom = TUOKOUXIUSwiftComSJ.tukou_sLcom
        if sLcom.tufuh_staSArr.isEmpty {
            sLcom.tufuh_staSArr = tufuh_staSArr
        }
        
        if sLcom.tufuh_hhTabsArr.isEmpty {
            sLcom.tufuh_hhTabsArr = tufuh_dict["toptabs"] as! [Any]
        }

//        if TUOKOUXISSUUtils.tukou_isStringEmpty(sLcom.tufuh_ic_adPl) {
//            tukou_goAdPl(true)
//        }
//        if TUOKOUXISSUUtils.tukou_isStringEmpty(sLcom.tufuh_ic_hh_titPl) {
//            tukou_goAdPl(false)
//        }
//        if TUOKOUXISSUUtils.tukou_isStringEmpty(sLcom.tufuh_iconUrl) {
//            if let dict = tufuh_staSArr.first(where: { ($0["key"] as? String) == "iconUrl" }) {
//                sLcom.tufuh_iconUrl = dict["value"] as? String
//            }
//            
//            guard let iconUrl = sLcom.tufuh_iconUrl else { return }
//            let tufuh_arr = iconUrl.components(separatedBy: "/")
//            let tufuh_fileName = tufuh_arr.last ?? ""
//            let tufuh_p = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/\(tufuh_fileName)") ?? ""
//            
//            let tufuh_ver = UserDefaults.standard.string(forKey: "TUOKOUXIUappVersion")
//            if TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_ver) {
//                UserDefaults.standard.set(TUOKOUXIUSSApp.tukou_appVer(), forKey: "TUOKOUXIUappVersion")
//            } else if TUOKOUXIUSSApp.tukou_appVer() != tufuh_ver, FileManager.default.fileExists(atPath: tufuh_p) {
//                try? FileManager.default.removeItem(atPath: tufuh_p)
//            }
//            
//            if FileManager.default.fileExists(atPath: tufuh_p) {
//                if let attr = try? FileManager.default.attributesOfItem(atPath: tufuh_p),
//                   let fileSize = attr[.size] as? UInt64, fileSize < 1_500_000 {
//                    try? FileManager.default.removeItem(atPath: tufuh_p)
//                    tukou_goDLIcon()
//                } else {
//                    sLcom.tufuh_iconUrlExist = true
//                }
//            } else {
//                tukou_goDLIcon()
//            }
//        }

        TUOKOUXIUSwiftWWWL.tukou_shared.tukou_conComHttHead(["token": tufuh_tk])
        tukou_reqCenter()
    }
    
    private func reportFail(reason: String) {

    }
    
//    private func tukou_goAdPl(_ isAdPl: Bool) {
//        let tufuh_scaF = UIScreen.main.scale
//        let sLcom = TUOKOUXIUSwiftComSJ.tukou_sLcom
//        let tufuh_staSArr = sLcom.tufuh_staSArr
//        
//        var tufuh_adPl: String
//        var tufuh_adPl2: String
//        
//        if isAdPl {
//            tufuh_adPl = "ic_ad_placeholder2"
//            tufuh_adPl2 = "ic_ad_placeholder3"
//        } else {
//            tufuh_adPl = "ic_home_title_l2"
//            tufuh_adPl2 = "ic_home_title_l3"
//        }
//        
//        var tufuh_imageDict2: [String: Any]? = nil
//        
//        if tufuh_scaF == 2.0 {
//            tufuh_imageDict2 = tufuh_staSArr.compactMap { $0 as? [String: Any] }
//                    .first { $0["key"] as? String == tufuh_adPl }
//        } else {
//            tufuh_imageDict2 = tufuh_staSArr.compactMap { $0 as? [String: Any] }
//                    .first { $0["key"] as? String == tufuh_adPl2 }
//        }
//        
//        guard let tufuh_value = tufuh_imageDict2?["value"] as? String else { return }
//        
//        if isAdPl {
//            sLcom.tufuh_ic_adPl = tufuh_value
//        } else {
//            sLcom.tufuh_ic_hh_titPl = tufuh_value
//        }
//    }
    
    private func tukou_goDLIcon() {
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_iconUrlExist = false
        
        guard let iconUrlStr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_iconUrl,
              let iconUrl = URL(string: iconUrlStr) else { return }
        
        let fileName = iconUrl.lastPathComponent
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let localPath = documentsPath.appendingPathComponent(fileName)
        
        let destination: DownloadRequest.Destination = { _, _ in
            return (localPath, [.removePreviousFile, .createIntermediateDirectories])
        }
        AF.download(iconUrl, to: destination).downloadProgress { progress in}.response { response in
            if response.fileURL != nil {
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_iconUrlExist = true
                
                if TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_unzipFile(at: response.fileURL!) {
                } else {
                }
                self.tufuh_block?(true)
            } else {
                self.tukou_reqIconUrl()
            }
        }
    }
    
    private func tukou_reqIconUrl() {
        guard let iconUrlStr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_iconUrl,
              let iconUrl = URL(string: iconUrlStr) else { return }
        
        let fileName = iconUrl.lastPathComponent
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let localPath = documentsPath.appendingPathComponent(fileName)
        
        let destination: DownloadRequest.Destination = { _, _ in
            return (localPath, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        AF.download(iconUrl, to: destination)
            .downloadProgress { progress in

            }
            .response { response in
                if let fileURL = response.fileURL {
                    TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_iconUrlExist = true

                    if TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_unzipFile(at: fileURL) {
                    } else {
                    }
                    self.tufuh_block?(true)
                }
            }
    }
    
    func tukou_reqTK() {
        let params: [String: Any] = [
            "did": TUOKOUXIUSSApp.tukou_phoDevCo(),
            "plm": "0",
            "bid": TUOKOUXIUSSApp.tukou_idfi(),
            "ver": TUOKOUXIUSSApp.tukou_appVer(),
            "dmn": TUOKOUXIUSSApp.tukou_devModN(),
            "sver": TUOKOUXIUSSApp.tukou_sysVer()
        ]

        let ba64Str = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_shuJJM(params)
           if TUOKOUXISSUUtils.tukou_isStringEmpty(ba64Str) {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }

        TUOKOUXIUSwiftWWWL.tukou_shared.tukou_requWithURL(TUOKOUXIUSwiftConst.TUOKOUXIUyhdl,
                                                      pars: [ba64Str]) { dataDict, isSuccess in
            if isSuccess {
                if let dataStr = dataDict as? String {
                    DispatchQueue.global(qos: .default).async {
                        let decodedStr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_shuJDKM(dataStr)
                        DispatchQueue.main.async {
                            self.tukou_loadDataStr(decodedStr)
                        }
                    }
                } else {
                    TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
                    TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
                }
            } else {
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            }
        }
    }
    
    private func tukou_reqCenter() {
        let params: [String: Any] = [
            "cd": TUOKOUXIUSwiftConst.TUOKOUXIUSwiftcdKey,
            "ps": [["pn": TUOKOUXIUSSApp.tukou_idfi(),
                    "pv": TUOKOUXIUSSApp.tukou_appVer(),
                    "tp": "1"]]
                                    ]
        
        let ba64Str = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_shuJJM(params)
        if TUOKOUXISSUUtils.tukou_isStringEmpty(ba64Str) {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }
        
        TUOKOUXIUSwiftWWWL.tukou_shared.tukou_requWithURL(TUOKOUXIUSwiftConst.TUOKOUXIUjkzx, pars: [ba64Str]) { dataDict, isSuccess in
            if isSuccess {
                guard let dataDict = dataDict else {
                    self.tukou_checkCode("1003", andResultBlk: nil)
                    return
                }
                
                if let dataStr = dataDict as? String {
                    self.tukou_checkCode(dataStr, andResultBlk: nil)
                    return
                }
                
                if let dataDic = dataDict as? [String: Any], let dataObject = dataDic["data"] {
                    if let dataArray = dataObject as? [[String: Any]], !dataArray.isEmpty {
                        TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_routesArr = dataArray
                        
                        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_iconUrlExist {
                            self.tufuh_block?(true)
                        }
                    } else {
                        self.tukou_checkCode("1003", andResultBlk: nil)
                    }
                } else {
                    self.tukou_checkCode("1003", andResultBlk: nil)
                }
            } else {
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            }
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
