enum ApiConfig {
    static let baseURL = "https://backend.bieji.qiyin.art"

    enum Environment {
        case dev, prod

        var host: String {
            switch self {
            case .dev: return "https://backend.bieji.qiyin.art"
            case .prod: return "https://backend.bieji.qiyin.art"
            }
        }
    }
}
