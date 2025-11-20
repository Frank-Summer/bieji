
import Foundation

typealias TUOKOUXIUBackBlk = (_ string: String, _ array: [Any]) -> Void

class TUOKOUXIUSwiftJMMana : NSObject {
    
    var tufuh_dataBlk: TUOKOUXIUBackBlk?
    
    private var tufuh_pId: String = ""
    private var tufuh_ssnid: String = ""
    private var tufuh_epsid: String = ""
    private var tufuh_claCodId: String = ""
    private var tufuh_dataDict: [String: Any] = [:]
    private var tufuh_type: String = ""
    private var tufuh_isFirLoad: Bool = false
    
    func tukou_strFormStr(_ string: String,
                          andpid pid: String,
                          andtype type: String,
                          andDict dict: [String: Any],
                          andssnid ssnid: String,
                          andepsid epsid: String) {
        print("-----------------come")
        tufuh_isFirLoad = true
        
        if string.isEmpty || pid.isEmpty || type.isEmpty || ssnid.isEmpty || epsid.isEmpty || dict.isEmpty {
            tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)
            return
        }
        
        tufuh_claCodId = string
        tufuh_dataDict = dict
        tufuh_type = type
        tufuh_pId = pid
        tufuh_ssnid = ssnid
        tufuh_epsid = epsid
        
        tukou_gtDowLoa()
    }
    func tukou_strFormStr45() -> Bool {

        if tufuh_ssnid == "0" && tufuh_epsid == "0" {

            guard let tufuh_plsArr = tufuh_dataDict["pls"] as? [Any], tufuh_plsArr.count >= 2 else {
                
                DispatchQueue.main.async {
                    self.tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)
                }
                return false
            }


            if let tufuh_plsStr = tufuh_plsArr[1] as? String, tufuh_plsStr.isEmpty {

                DispatchQueue.main.async {
                    self.tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)
                }
                return false
            }

            guard let tufuh_plsDict2 = tufuh_plsArr[1] as? [String: Any],
                  let tufuh_dseStr = tufuh_plsDict2["dserver"] as? String,
                  let tufuh_dseData = tufuh_dseStr.data(using: .utf8),
                  !tufuh_dseStr.isEmpty else {
                
                DispatchQueue.main.async {
                    self.tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)
                }
                return false
            }

            guard let tufuh_dseArr = try? JSONSerialization.jsonObject(with: tufuh_dseData, options: []) as? [[String: Any]] else {
                return false
            }

            for tufuh_dictN2 in tufuh_dseArr {
                guard let tufuh_arrN2 = tufuh_dictN2["list"] as? [[String: Any]] else { continue }
                for tufuh_dictN3 in tufuh_arrN2 {
                    guard let tufuh_arrN3 = tufuh_dictN3[TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[28] as! String] as? [[String: Any]],
                          let tufuh_dictN4 = tufuh_arrN3.first,
                          let tufuh_mgCode = tufuh_dictN4[TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[27] as! String] else { continue }

                    if "\(tufuh_mgCode)" == tufuh_claCodId {
                        tufuh_ssnid = "\(tufuh_dictN2["ssid"] ?? "0")"
                        tufuh_epsid = "\(tufuh_dictN4["code"] ?? "0")"
                        return true
                    }
                }
            }

            print("------------------")
            if tufuh_ssnid == "0" && tufuh_epsid == "0" {
                
                DispatchQueue.main.async {
                    self.tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)
                }
                return false
            }
        }
        return true
    }

    func tukou_messBlk(_ message: String) {
        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isOutBFV { return }
        
        TUOKOUXIUSwiftKeyWindow()!.makeToast(message, duration: 2.0, position: .center)
        print("-----------------error")
        
        if let dataBlk = self.tufuh_dataBlk {
            dataBlk("", [])
        }
    }

    func tukou_strFormStr5() -> String {
        guard let tufuh_plsArr = tufuh_dataDict["pls"] as? [Any], tufuh_plsArr.count >= 2 else {
            
            DispatchQueue.main.async {
                self.tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)
            }
            return ""
        }
        
        if let plsStr = tufuh_plsArr[1] as? String, plsStr.isEmpty {
            
            DispatchQueue.main.async {
                self.tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)
            }
            return ""
        }
        
        guard let tufuh_plsDict = tufuh_plsArr[1] as? [String: Any],
              let code = tufuh_plsDict["code"] as? String else {
            return ""
        }
        
        return code
    }
    
    func tukou_gtDowLoa() {
        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isOutBFV { return }

        var tufuh_d: [String: Any]
        
        if tufuh_type == "1" {
            guard tukou_strFormStr45() else { return }
            tufuh_d = [
                "pid": tufuh_pId,
                "ssn_id": tufuh_ssnid,
                "eps_id": tufuh_epsid,
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[27] as! String: tufuh_claCodId,
                "bid": TUOKOUXIUSSApp.tukou_idfi()
            ]
        } else {
            let tufuh_dldCode = tukou_strFormStr5()
            if TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_dldCode) {
                
                DispatchQueue.main.async {
                    self.tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)
                }
                return
            }
            tufuh_d = [
                "pid": tufuh_pId,
                "ssn_id": "0",
                "eps_id": "0",
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[27] as! String: tufuh_claCodId,
                "bid": TUOKOUXIUSSApp.tukou_idfi()
            ]
        }

        print("-----------------dld=\(tufuh_d)")
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_bfyeKey = tufuh_d
        let tufuh_ba64Str = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_shuJJM(tufuh_d)
        
        if TUOKOUXISSUUtils.tukou_isStringEmpty(tufuh_ba64Str) {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }
        
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_dataStr = ""
        let params: [Any] = [tufuh_ba64Str]

        TUOKOUXIUSwiftWWWL.tukou_shared.tukou_requWithURL(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[13] as? String,
                                                           pars: params) { dataDict, isSuccess in
            if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isOutBFV { return }
            if isSuccess {
                if let str = dataDict as? String {
                    if str == "1003" {
                        let vc = TUOKOUXIUSwiftBaseVC()
                        vc.tukou_checkCode(str) { isSuccess2 in
                            if isSuccess2 {
                                self.tukou_gtDowLoa()
                            }
                        }
                        return
                    }
                } else {
                    self.tukou_loadDataFail2(dataDict)
                    return
                }
                DispatchQueue.global(qos: .default).async {
                    TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_dataStr = dataDict as? String ?? ""
                    let tufuh_dataStr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_shuJDKM(dataDict as! String)
                    
                    DispatchQueue.main.async {
                        self.tukou_loadDataStr3(tufuh_dataStr, andCode: dataDict as? String ?? "")
                    }
                }
            } else {
                self.tukou_loadDataFail(dataDict)
            }
        }
    }

    func tukou_loadDataFail2(_ dataDict: Any?) {
        if tufuh_isFirLoad {
            tufuh_isFirLoad = false
            tukou_gtDowLoa()
            return
        }
        
        tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)
        
    }

    func tukou_loadDataFail(_ dataDict: Any?) {
        if tufuh_isFirLoad {
            tufuh_isFirLoad = false
            tukou_gtDowLoa()
            return
        }

        tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)

        if let str = dataDict as? String {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_dataStr = str
        } else if let dict = dataDict as? [String: Any] {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_dataStr = String(data: jsonData, encoding: .utf8) ?? "<Serialization failed>"
            } catch {
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_dataStr = "<\(error)>"
            }
        }

    }

    func tukou_loadDataStr3(_ dataString: String?, andCode code: String) {
        guard let dataString = dataString, !TUOKOUXISSUUtils.tukou_isStringEmpty(dataString) else {
            tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)

            return
        }

        guard let jsonData = dataString.data(using: .utf8),
              let tufuh_dic = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
            tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)

            return
        }

        guard let tufuh_dataStr2 = tufuh_dic["playurl"] as? String,
              let jsonData2 = tufuh_dataStr2.data(using: .utf8),
              let tufuh_dic2 = try? JSONSerialization.jsonObject(with: jsonData2) as? [String: Any],
              let tufuh_url = tufuh_dic2["sources"] as? String else {
            tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)

            return
        }

        if tufuh_url.contains(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[11] as! String) || tufuh_url.contains(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[12] as! String) {
            let tufuh_zmArr2 = tukou_paixuArr(tufuh_dic2["tracks"] as? [[String: Any]] ?? [])
            tufuh_dataBlk?(tufuh_url, tufuh_zmArr2)
        } else {
            tukou_messBlk(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[5] as! String)
        }
    }

    func tukou_paixuArr(_ array: [[String: Any]]) -> [[String: Any]] {
        guard !array.isEmpty else { return [] }
        return array.sorted { ($0["label"] as? String ?? "") < ($1["label"] as? String ?? "") }
    }
}
