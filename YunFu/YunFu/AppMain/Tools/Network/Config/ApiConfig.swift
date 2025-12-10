enum ApiConfig {
    static let baseURL = "http://39.97.34.197:8080"

    enum Environment {
        case dev, prod

        var host: String {
            switch self {
            case .dev: return "http://39.97.34.197:8080"
            case .prod: return "http://39.97.34.197:8080"
            }
        }
    }
}
