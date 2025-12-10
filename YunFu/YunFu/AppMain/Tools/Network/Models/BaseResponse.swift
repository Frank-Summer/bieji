import Foundation

/// 通用基础模型
struct BaseModel<T: Codable>: Codable {
    var code: Int?
    var msg: String?
    var bodydata: T?

    enum CodingKeys: String, CodingKey {
        case code
        case msg
        case bodydata = "data" // 服务器字段名
    }
}
