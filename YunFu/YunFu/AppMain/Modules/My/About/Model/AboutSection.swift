import Foundation

struct AboutSection: Identifiable {
    let id = UUID()            // ⭐ 必须有唯一 id
    let header: String?
    let items: [AboutItem]
}
