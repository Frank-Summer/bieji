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
    //场景列表
    static func getScenesList() async -> ScenesResponse? {

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeHM = formatter.string(from: Date())

        let params: [String: Any] = [
            "time": timeHM,
        ]

        let result = await HTTPClient.shared.request(
            ApiEndpoint.getScenesList,
            method: "POST",
            params: params
        )

        guard
            let result = result,
            result.code == 0,
            let body = result.bodydata
        else {
            return nil
        }

        return ScenesResponse.parseScenesResponse(body: body)
    }
    //音乐详情
    static func getMusicDetail(Uuid:String) async -> MusicModel? {

        let params: [String: Any] = [
            "songUuid": Uuid,
        ]

        let result = await HTTPClient.shared.request(
            ApiEndpoint.getMusicDetail,
            method: "GET",
            params: params
        )

        guard
            let result = result,
            result.code == 0,
            let body = result.bodydata
        else {
            return nil
        }
        let model: MusicModel? = MusicModel.parseDetail(body: body)
        let isFavorite = model?.isFavorite
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isFavorite = isFavorite ?? false
        TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_songId = model?.id
        return model
    }
    //探索详情
    static func getExploreDetail() async -> [SceneSection]? {

        let result = await HTTPClient.shared.request(
            ApiEndpoint.getExploreDetail,
            method: "GET"
        )

        guard
            let result = result,
            result.code == 0,
            let body = result.bodydata
        else {
            return nil
        }

        return ExploreModel.parse(body: body)
    }
    //收藏
    static func postFavoritesAdd(Uuid: Int) async -> Bool {
        let params: [String: Any] = [
            "songId": Uuid,
        ]
        let result = await HTTPClient.shared.request(
            ApiEndpoint.favoritesAdd,
            method: "POST",
            params: params
        )
        guard
            let result = result,
            result.code == 0,
            let body = result.bodydata
        else {
            return false
        }

        print("收藏成功", body)
        return true
    }
    //取消收藏
    static func postFavoritesRemove(Uuid: Int) async -> Bool {
        let params: [String: Any] = [
            "songId": Uuid,
        ]
        let result = await HTTPClient.shared.request(
            ApiEndpoint.favoritesRemove,
            method: "DELETE",
            params: params
        )
        guard
            let result = result,
            result.code == 0,
            let body = result.bodydata
        else {
            return false
        }

        print("取消收藏成功", body)
        return true
    }
    //播放历史添加
    static func postHistoryAdd(Uuid: Int) async -> Bool {
        let params: [String: Any] = [
            "songId": String(Uuid),
        ]
        let result = await HTTPClient.shared.request(
            ApiEndpoint.historyAdd,
            method: "POST",
            params: params
        )
        guard
            let result = result,
            result.code == 0,
            let body = result.bodydata
        else {
            return false
        }

        print("播放历史添加成功", body)
        return true
    }
}
