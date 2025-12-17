import Foundation

final class HTTPClient {

    static let shared = HTTPClient()
    private init() {}

    /// 高兼容通用请求
    func request(
        _ endpoint: String,
        method: String = "POST",
        params: [String: Any]? = nil,
        retry: Bool = false
    ) async -> BaseModel<[String: AnyCodable]>? {

        let upperMethod = method.uppercased()
        let baseUrl = ApiConfig.baseURL + endpoint

        print("🌍 [HTTP] 请求接口：\(baseUrl)")
        print("➡️ 请求方式：\(upperMethod)")

        // MARK: - 打印请求参数
        if let params = params,
           let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("📦 请求参数：\n\(jsonString)")
        }

        // MARK: - 构建 URL
        var url: URL?
        if upperMethod == "GET" || upperMethod == "DELETE" {
            if let params = params,
               var comps = URLComponents(string: baseUrl) {
                comps.queryItems = params.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
                url = comps.url
            } else {
                url = URL(string: baseUrl)
            }
        } else {
            url = URL(string: baseUrl)
        }

        guard let finalURL = url else {
            print("❌ URL 无效")
            return BaseModel(code: 998, msg: "URL 无效", bodydata: nil)
        }

        // MARK: - 构建请求
        var req = URLRequest(url: finalURL)
        req.httpMethod = upperMethod
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Language Header
        req.setValue(LanguageProvider.current, forHTTPHeaderField: "Language")

        // 请求体
        if ["POST", "PUT", "PATCH"].contains(upperMethod),
           let params = params {
            req.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }

        // 注入 Token
        TokenInterceptor.shared.injectToken(into: &req)

        // MARK: - ✅ 打印最终请求头
        print("🧾 [HTTP] 最终请求头 Headers：")
        if let headers = req.allHTTPHeaderFields, !headers.isEmpty {
            for (key, value) in headers {
                print("  \(key): \(value)")
            }
        } else {
            print("  <empty>")
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: req)

            guard let http = response as? HTTPURLResponse else {
                print("❌ 无效响应")
                return BaseModel(code: 997, msg: "无效响应", bodydata: nil)
            }

            if let bodyString = String(data: data, encoding: .utf8) {
                print("⬅️ [HTTP \(http.statusCode)] 返回内容：\n\(bodyString)")
            }

            // MARK: - 成功
            if http.statusCode == 200 {
                do {
                    let decoded = try JSONDecoder()
                        .decode(BaseModel<[String: AnyCodable]>.self, from: data)
                    return decoded
                } catch {
                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                    guard let json = jsonObject as? [String: Any] else {
                        return BaseModel(code: 999, msg: "返回非 JSON", bodydata: nil)
                    }

                    let code = json["code"] as? Int ?? -1
                    let msg = json["msg"] as? String ?? "未知错误"
                    let dataDict = json["data"] as? [String: Any] ?? [:]

                    var converted: [String: AnyCodable] = [:]
                    for (k, v) in dataDict {
                        converted[k] = AnyCodable(v)
                    }

                    return BaseModel(code: code, msg: msg, bodydata: converted)
                }
            }

            // MARK: - Token 过期
            if http.statusCode == 401 && !retry {
                print("⚠️ 命中 401，尝试刷新 Token")
                if await TokenInterceptor.shared.refreshToken() {
                    print("🔁 Token 刷新成功，重试请求")
                    return await request(endpoint, method: method, params: params, retry: true)
                }
                return BaseModel(code: 401, msg: "登录过期", bodydata: nil)
            }

            return BaseModel(
                code: http.statusCode,
                msg: "请求失败 (\(http.statusCode))",
                bodydata: nil
            )

        } catch {
            print("❌ 网络异常：\(error.localizedDescription)")
            return BaseModel(
                code: 999,
                msg: "网络异常：\(error.localizedDescription)",
                bodydata: nil
            )
        }
    }
}
