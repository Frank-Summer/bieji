
import Foundation
import Alamofire

typealias TUOKOUXIUHttReqComp = (_ resObj: Any?, _ error: Error?) -> Void

class TUOKOUXIUSwiftWWWL : NSObject {
    
    static let tukou_shared = TUOKOUXIUSwiftWWWL()
    
    private var httpHeaders: [String: String] = [:]
    private var baseURL: String = TUOKOUXIUSwiftConst.TUOKOUXIUProdBaseUrl
    private var timeout: TimeInterval = 30.0
    
    private override init() {}
    
    func tukou_conComHttHead(_ headers: [String: String]?) {
        if let headers = headers {
            self.httpHeaders = headers
        }
    }
    
    func tukou_requWithURL(_ url: String?,
                           pars: Any?,
                           completion: ((_ dataDict: Any?, _ isSuccess: Bool) -> Void)?) {
        guard let url = url else {
            completion?(nil, false)
            return
        }
        
        tukou_POST(url, pars: pars) { resObj, error in
            self.tukou_dealResObj(resObj, error: error, completion: completion)
        }
    }
    
    @discardableResult
    private func tukou_POST(_ url: String,
                            pars: Any?,
                            completion: @escaping TUOKOUXIUHttReqComp) -> DataRequest? {
        return tukou_reqWitHttUrl(url, pars: pars, completion: completion)
    }
    
    @discardableResult
    private func tukou_reqWitHttUrl(_ url: String,
                                    pars: Any?,
                                    completion: @escaping TUOKOUXIUHttReqComp) -> DataRequest? {
        
        let fullURL = "\(baseURL)\(url)"
        
        var headers: HTTPHeaders = [:]
        httpHeaders.forEach { headers[$0.key] = $0.value }

        var clientDict = httpHeaders
        clientDict["network"] = TUOKOUXIUSwiftNetUt.tukou_getNetT()

        if let clientData = try? JSONSerialization.data(withJSONObject: clientDict, options: []),
           let clientStr = String(data: clientData, encoding: .utf8) {
            headers["client"] = clientStr
        }
        
        let encoding: ParameterEncoding = JSONEncoding.default
        let request: DataRequest
        
        if let params = pars as? [String: Any] {
            request = AF.request(fullURL,
                                 method: .post,
                                 parameters: params,
                                 encoding: encoding,
                                 headers: headers)
        } else if let arr = pars as? [Any] {
            var urlRequest = try! URLRequest(url: fullURL, method: .post, headers: headers)
            urlRequest.timeoutInterval = timeout
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: arr, options: [])

            request = AF.request(urlRequest)
                .validate(contentType: [
                    "application/json",
                    "text/html",
                    "text/json",
                    "text/plain",
                    "text/javascript",
                    "text/xml",
                    "image/*"
                ])
        } else {
            request = AF.request(fullURL,
                                 method: .post,
                                 parameters: nil,
                                 encoding: encoding,
                                 headers: headers)
        }
        
        request.responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    if let dict = jsonObj as? [String: Any] {
                        completion(dict, nil)
                    } else if let arr = jsonObj as? [Any] {
                        completion(arr, nil)
                    } else {
                        let str = String(data: data, encoding: .utf8)
                        completion(str ?? data, nil)
                    }
                } catch {
                    let str = String(data: data, encoding: .utf8)
                    completion(str ?? data, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
        return request
    }
    
    private func tukou_dealResObj(_ resObj: Any?,
                                  error: Error?,
                                  completion: ((_ dataDict: Any?, _ isSuccess: Bool) -> Void)?) {
        if let error = error {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_fwqFailCode = (error as NSError).code
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_fwqFailStr = error.localizedDescription
            
            if (error as NSError).code == 3840 {
                return
            }
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            
            completion?(nil, false)
            return
        }
        guard let resObj = resObj as? [String: Any] else {
            completion?(nil, false)
            return
        }
        tukou_parseResObj(resObj, completion: completion)
    }
    
    private func tukou_parseResObj(_ resObj: [String: Any],
                                   completion: ((_ dataDict: Any?, _ isSuccess: Bool) -> Void)?) {
        
        let dataDict: Any? = resObj["data"] ?? resObj
        let code = (resObj["code"] as? Int) ?? -1
        var msg: String = "no data"
        
        if code == 0 {
            if let jsonData = try? JSONSerialization.data(withJSONObject: resObj, options: .prettyPrinted),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_fwqFailStr = jsonString
            } else {
                msg = (dataDict as? [String: Any])?["msg"] as? String ?? "no msg"
                if msg.count < 200 {
                    TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_fwqFailStr = msg
                }
            }
        }
        
        if code == 1003 {
            completion?("1003", true)
            return
        }
        if code == 1002 {
            completion?("app die", false)
            return
        }
        if code == 1005 {
            TUOKOUXIUSwiftKeyWindow()!.makeToast(msg, duration: 2.0, position: .center)
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            return
        }
        completion?(dataDict, code == 1)
    }
}
