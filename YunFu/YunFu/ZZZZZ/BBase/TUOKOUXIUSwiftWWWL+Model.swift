
import Foundation

extension TUOKOUXIUSwiftWWWL {

    // MARK: - GET 自动解析Model
    func tukou_GET_Model<T: Codable>(
        _ url: String,
        pars: [String: Any]?,
        model: T.Type,
        completion: @escaping (_ model: T?, _ ok: Bool) -> Void
    ) {
        self.tukou_GET(url, pars: pars) { data, ok in
            self.decodeModel(data: data, ok: (ok != nil), type: model, completion: completion)
        }
    }

    // MARK: - POST 自动解析Model
    func tukou_POST_Model<T: Codable>(
        _ url: String,
        pars: Any?,
        model: T.Type,
        completion: @escaping (_ model: T?, _ ok: Bool) -> Void
    ) {
        self.tukou_POST(url, pars: pars) { data, error in
            let ok = (error == nil)
            self.decodeModel(data: data, ok: ok, type: model, completion: completion)
        }
    }

    // MARK: - PUT
    func tukou_PUT_Model<T: Codable>(
        _ url: String,
        pars: Any?,
        model: T.Type,
        completion: @escaping (_ model: T?, _ ok: Bool) -> Void
    ) {
        self.tukou_PUT(url, pars: pars) { data, ok in
            self.decodeModel(data: data, ok: (ok != nil), type: model, completion: completion)
        }
    }

    // MARK: - DELETE
    func tukou_DELETE_Model<T: Codable>(
        _ url: String,
        pars: [String: Any]?,
        model: T.Type,
        completion: @escaping (_ model: T?, _ ok: Bool) -> Void
    ) {
        self.tukou_DELETE(url, pars: pars) { data, ok in
            self.decodeModel(data: data, ok: (ok != nil), type: model, completion: completion)
        }
    }
    
    
    // MARK: - 通用JSON → Model 转换
    private func decodeModel<T: Codable>(
        data: Any?,
        ok: Bool,
        type: T.Type,
        completion: @escaping (_ model: T?, _ ok: Bool) -> Void
    ) {
        guard ok, let json = data else {
            completion(nil, false)
            return
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            
            // 优先解析 data 字段
            if let dict = json as? [String: Any],
               let inner = dict["data"] {
                
                let innerData = try JSONSerialization.data(withJSONObject: inner, options: [])
                let model = try JSONDecoder().decode(type, from: innerData)
                completion(model, true)
                return
            }
            
            // 直接解析根节点
            let model = try JSONDecoder().decode(type, from: jsonData)
            completion(model, true)
            
        } catch {
            print("❌ Model decode error:", error)
            completion(nil, false)
        }
    }
}
