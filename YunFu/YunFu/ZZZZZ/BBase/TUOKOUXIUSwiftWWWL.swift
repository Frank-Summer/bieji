
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
    func tukou_POST(_ url: String,
                    pars: Any?,
                    completion: @escaping TUOKOUXIUHttReqComp) -> DataRequest? {
        return tukou_request(method: .post, url: url, pars: pars, completion: completion)
    }

    @discardableResult
    func tukou_GET(_ url: String,
                   pars: Any?,
                   completion: @escaping TUOKOUXIUHttReqComp) -> DataRequest? {
        return tukou_request(method: .get, url: url, pars: pars, completion: completion)
    }

    @discardableResult
    func tukou_PUT(_ url: String,
                   pars: Any?,
                   completion: @escaping TUOKOUXIUHttReqComp) -> DataRequest? {
        return tukou_request(method: .put, url: url, pars: pars, completion: completion)
    }

    @discardableResult
    func tukou_DELETE(_ url: String,
                      pars: Any?,
                      completion: @escaping TUOKOUXIUHttReqComp) -> DataRequest? {
        return tukou_request(method: .delete, url: url, pars: pars, completion: completion)
    }
    
    private func tukou_reqWithMethod(_ method: HTTPMethod,
                                     url: String,
                                     pars: Any?,
                                     completion: @escaping TUOKOUXIUHttReqComp) {
        
        let fullURL = "\(baseURL)\(url)"
        
        var headers: HTTPHeaders = [:]
        httpHeaders.forEach { headers[$0.key] = $0.value }
        
        var clientDict = httpHeaders
        clientDict["network"] = TUOKOUXIUSwiftNetUt.tukou_getNetT()
        
        if let clientData = try? JSONSerialization.data(withJSONObject: clientDict, options: []),
           let clientStr = String(data: clientData, encoding: .utf8) {
            headers["client"] = clientStr
        }
        
        let encoding: ParameterEncoding =
            (method == .get || method == .delete) ? URLEncoding.default : JSONEncoding.default
        
        let request = AF.request(fullURL,
                                 method: method,
                                 parameters: pars as? [String: Any],
                                 encoding: encoding,
                                 headers: headers)
        
        handleResponse(request, completion: completion)
    }
    
    private func handleResponse(_ request: DataRequest,
                                completion: @escaping TUOKOUXIUHttReqComp) {
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
    }
    
    @discardableResult
    private func tukou_request(method: HTTPMethod,
                               url: String?,
                               pars: Any?,
                               completion: @escaping TUOKOUXIUHttReqComp) -> DataRequest? {

        guard let url = url else {
            completion(nil, NSError(domain: "url nil", code: -999, userInfo: nil))
            return nil
        }
        
        let fullURL = "\(baseURL)\(url)"

        // -------------------------
        // 构建 Headers
        // -------------------------
        var headers: HTTPHeaders = [:]
        httpHeaders.forEach { headers[$0.key] = $0.value }

        var clientDict = httpHeaders
        clientDict["network"] = TUOKOUXIUSwiftNetUt.tukou_getNetT()
        
        if let clientData = try? JSONSerialization.data(withJSONObject: clientDict, options: []),
           let clientStr = String(data: clientData, encoding: .utf8) {
            headers["client"] = clientStr
        }

        // -------------------------
        // 构建 URLRequest（统一设置 timeout）
        // -------------------------
        var urlRequest = try! URLRequest(url: fullURL, method: method, headers: headers)
        urlRequest.timeoutInterval = timeout        // 🔥 单个请求超时控制

        // GET/DELETE 通常放到 URL，POST/PUT 放到 body
        if let params = pars as? [String: Any] {
            if method == .get || method == .delete {
                let encoded = try! URLEncoding.default.encode(urlRequest, with: params)
                urlRequest = encoded
            } else {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            }
        }

        // -------------------------
        // 发起请求
        // -------------------------
        let request = AF.request(urlRequest)
            .validate(contentType: [
                "application/json",
                "text/html",
                "text/json",
                "text/plain",
                "text/javascript",
                "text/xml",
                "image/*"
            ])

        // -------------------------
        // 统一解析（保持你原有逻辑）
        // -------------------------
        request.responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])

                    if let dict = jsonObj as? [String : Any] {
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
        let msg: String = "no data"
        
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
