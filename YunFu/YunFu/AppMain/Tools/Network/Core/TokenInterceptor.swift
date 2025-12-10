import Foundation

final class TokenInterceptor {

    static let shared = TokenInterceptor()
    private init() {}

    /// 注入 Token 到请求头
    func injectToken(into request: inout URLRequest) {
        if let token = TokenStorage.shared.accessToken, !token.isEmpty {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }

    /// 刷新 Token
    func refreshToken() async -> Bool {
        guard let refresh = TokenStorage.shared.refreshToken else {
            print("⚠️ 无 refreshToken，无法刷新")
            return false
        }

        do {
            let url = URL(string: ApiConfig.baseURL + ApiEndpoint.refreshtoken)!
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
            req.httpBody = try JSONSerialization.data(withJSONObject: ["refreshToken": refresh])

            let (data, response) = try await URLSession.shared.data(for: req)
            guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
                return false
            }

            // 尝试解析新 token
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            let newData = json?["data"] as? [String: Any]
            let newAccess = newData?["accessToken"] as? String
            let newRefresh = newData?["refreshToken"] as? String

            if let a = newAccess, let r = newRefresh {
                TokenStorage.shared.saveTokens(access: a, refresh: r)
                print("🔄 Token 已刷新并保存")
                return true
            }
            return false

        } catch {
            print("❌ 刷新 Token 异常：\(error)")
            return false
        }
    }
}
