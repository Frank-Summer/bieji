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

        guard let refresh = TokenStorage.shared.refreshToken,
              !refresh.isEmpty else {
            print("⚠️ 无 refreshToken，无法刷新")
            return false
        }

        print("🔄 开始刷新 Token")

        do {
            let url = URL(string: ApiConfig.baseURL + ApiEndpoint.refreshtoken)!
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")

            // ⚠️ 和 Flutter 一致：不要加 Authorization
            req.httpBody = try JSONSerialization.data(
                withJSONObject: ["refreshToken": refresh]
            )

            let (data, response) = try await URLSession.shared.data(for: req)

            guard let http = response as? HTTPURLResponse else {
                print("❌ 刷新失败：无 HTTP 响应")
                return false
            }

            print("🔄 刷新状态码:", http.statusCode)

            if let body = String(data: data, encoding: .utf8) {
                print("🔄 刷新返回内容:\n", body)
            }

            guard http.statusCode == 200 else {
                return false
            }

            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            let dataDict = json?["data"] as? [String: Any]

            // ✅ 和 Flutter 对齐的字段名
            if let newAccess = dataDict?["newAccessToken"] as? String {

                // refreshToken 后端如果没给，就继续用旧的
                let newRefresh = dataDict?["refreshToken"] as? String ?? refresh

                TokenStorage.shared.saveTokens(
                    access: newAccess,
                    refresh: newRefresh
                )

                print("✅ Token 刷新成功")
                return true
            }

            print("❌ 刷新成功但未返回 newAccessToken")
            return false

        } catch {
            print("❌ 刷新 Token 异常:", error)
            return false
        }
    }
}
