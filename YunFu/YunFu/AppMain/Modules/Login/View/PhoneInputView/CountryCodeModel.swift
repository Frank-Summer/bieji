import Foundation

struct CountryName: Codable {
    let zh: String
    let en: String
}

struct CountryCodeItem: Codable {
    let country: CountryName
    let code: String
    let maxLength: Int
    let format: String?
}

final class CountryCodeLoader {
    static func load() -> [CountryCodeItem] {
        guard let url = Bundle.main.url(forResource: "CountryCodes", withExtension: "json") else {
            print("❌ CountryCodes.json 未找到")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([CountryCodeItem].self, from: data)
        } catch {
            print("❌ JSON 解析失败:", error)
            return []
        }
    }
}
