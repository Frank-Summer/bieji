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

        print("🌍 [HTTP] 请求接口：\(ApiConfig.baseURL + endpoint)")
        print("➡️ 请求方式：\(method)")

        // 打印请求体
        if let params = params,
           let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("📦 请求参数：\n\(jsonString)")
        }

        guard let url = URL(string: ApiConfig.baseURL + endpoint) else {
            return BaseModel(code: 998, msg: "URL 无效", bodydata: nil)
        }

        var req = URLRequest(url: url)
        req.httpMethod = method
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if method != "GET", let params = params {
            req.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }

        // 注入 Token
        TokenInterceptor.shared.injectToken(into: &req)

        do {
            let (data, response) = try await URLSession.shared.data(for: req)
            guard let http = response as? HTTPURLResponse else {
                return BaseModel(code: 997, msg: "无效响应", bodydata: nil)
            }

            // 打印返回内容
            if let bodyString = String(data: data, encoding: .utf8) {
                print("⬅️ [HTTP \(http.statusCode)] 返回内容：\n\(bodyString)")
            }

            // ---------- 成功 ----------
            if http.statusCode == 200 {
                do {
                    // 尝试标准解码
                    let decoded = try JSONDecoder().decode(BaseModel<[String: AnyCodable]>.self, from: data)
                    print("✅ 解析成功 → code:\(decoded.code ?? -1) msg:\(decoded.msg ?? "-")")
                    return decoded
                } catch {
                    print("⚠️ 标准解析失败，尝试手动提取字段")

                    // ✅ Fallback: 手动解析 JSON
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    guard let json = jsonObject as? [String: Any] else {
                        return BaseModel(code: 999, msg: "返回非 JSON 格式", bodydata: nil)
                    }

                    let code = json["code"] as? Int ?? -1
                    let msg = json["msg"] as? String ?? "未知错误"
                    let dataDict = json["data"] as? [String: Any] ?? [:]

                    // 将 dataDict 转为 AnyCodable
                    var converted: [String: AnyCodable] = [:]
                    for (key, value) in dataDict {
                        converted[key] = AnyCodable(value)
                    }

                    return BaseModel(code: code, msg: msg, bodydata: converted)
                }
            }

            // ---------- Token 过期 ----------
            else if http.statusCode == 401 && !retry {
                print("🔄 Token 过期，尝试刷新中…")
                if await TokenInterceptor.shared.refreshToken() {
                    return await request(endpoint, method: method, params: params, retry: true)
                }
                return BaseModel(code: 401, msg: "登录过期", bodydata: nil)
            }

            // ---------- 其他错误 ----------
            return BaseModel(code: http.statusCode, msg: "请求失败 (\(http.statusCode))", bodydata: nil)

        } catch {
            print("❌ 网络异常：\(error.localizedDescription)")
            return BaseModel(code: 999, msg: "网络异常：\(error.localizedDescription)", bodydata: nil)
        }
    }
}
