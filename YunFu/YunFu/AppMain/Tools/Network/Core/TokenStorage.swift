import Foundation

final class TokenStorage {

    static let shared = TokenStorage()
    private init() {}

    private let accessKey = "accessToken"
    private let refreshKey = "refreshToken"

    /// 保存双 token
    func saveTokens(access: String, refresh: String) {
        UserDefaults.standard.set(access, forKey: accessKey)
        UserDefaults.standard.set(refresh, forKey: refreshKey)
        UserDefaults.standard.synchronize()
    }

    /// 获取 AccessToken
    var accessToken: String? {
        UserDefaults.standard.string(forKey: accessKey)
    }

    /// 获取 RefreshToken
    var refreshToken: String? {
        UserDefaults.standard.string(forKey: refreshKey)
    }

    /// 清空
    func clear() {
        UserDefaults.standard.removeObject(forKey: accessKey)
        UserDefaults.standard.removeObject(forKey: refreshKey)
    }
}
