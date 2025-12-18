import Foundation

final class AuthService {

    /// 发送验证码
    static func code(
        phone: String,
        countryCode: String,
        purpose: String
    ) async -> BaseModel<[String: AnyCodable]>? {
        await HTTPClient.shared.request(
            ApiEndpoint.code,
            method: "POST",
            params: [
                "phone": phone,
                "countryCode": countryCode,
                "purpose": purpose
            ]
        )
    }

    /// 使用手机号 + 验证码登录（自动保存双 Token）
    static func login_phone_code(
        phone: String,
        countryCode: String,
        verificationCode: String
    ) async -> BaseModel<[String: AnyCodable]>? {

        let body: [String: Any] = [
            "loginType": "PHONE_CODE",
            "credentials": [
                "phone": phone,
                "countryCode": countryCode,
                "verificationCode": verificationCode
            ]
        ]

        let response = await HTTPClient.shared.request(
            ApiEndpoint.login,
            method: "POST",
            params: body
        )

        guard let data = response?.bodydata else {
            print("⚠️ 登录返回数据为空")
            return response
        }

        // ✅ 自动提取 token 并保存
        if let accessToken = data["accessToken"]?.value(String.self),
           let refreshToken = data["refreshToken"]?.value(String.self) {

            print("✅ 登录成功，AccessToken: \(accessToken)")
            print("♻️ RefreshToken: \(refreshToken)")

            // ✅ 全局持久化存储（UserDefaults）
            TokenStorage.shared.saveTokens(access: accessToken, refresh: refreshToken)
        } else {
            print("⚠️ 登录返回未包含 token 字段")
        }

        return response
    }
    
    
    static func login_apple(
        identityToken: String
    ) async -> BaseModel<[String: AnyCodable]>? {

        let body: [String: Any] = [
            "loginType": "APPLE",
            "credentials": [
                "identityToken": identityToken,
            
            ]
        ]

        let response = await HTTPClient.shared.request(
            ApiEndpoint.login,
            method: "POST",
            params: body
        )

        guard let data = response?.bodydata else {
            print("⚠️ 登录返回数据为空")
            return response
        }

        // ✅ 自动提取 token 并保存
        if let accessToken = data["accessToken"]?.value(String.self),
           let refreshToken = data["refreshToken"]?.value(String.self) {

            print("✅ 登录成功，AccessToken: \(accessToken)")
            print("♻️ RefreshToken: \(refreshToken)")

            // ✅ 全局持久化存储（UserDefaults）
            TokenStorage.shared.saveTokens(access: accessToken, refresh: refreshToken)
        } else {
            print("⚠️ 登录返回未包含 token 字段")
        }

        return response
    }
    
    
    
    
    static func getlist() async -> [SceneModel] {

        // 1️⃣ 当前时间（时:分）
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeHM = formatter.string(from: Date())


        // 4️⃣ 组装请求参数
        let params: [String: Any] = [
            "time": timeHM,
        ]

        // 5️⃣ 发起请求
        let result = await HTTPClient.shared.request(
            ApiEndpoint.getlist,
            method: "POST",
            params: params
        )

        guard
            let result = result,
            result.code == 0,
            let body = result.bodydata
        else {
            return []
        }

        return SceneModel.parseScenes(body: body)
    }
    
    
}
