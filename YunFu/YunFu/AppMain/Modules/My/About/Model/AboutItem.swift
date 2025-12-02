import Foundation

struct AboutItem: Identifiable {
    let id = UUID()            // ⭐ 必须有唯一 id
    let icon: String
    let title: String
    let rightIcon: String
    let action: () -> Void
}
