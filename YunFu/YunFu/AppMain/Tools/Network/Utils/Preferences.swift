import Foundation

final class Preferences {
    static let shared = Preferences()
    private let defaults = UserDefaults.standard

    func set(_ value: String, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    func string(forKey key: String) -> String? {
        defaults.string(forKey: key)
    }

    func remove(_ key: String) {
        defaults.removeObject(forKey: key)
    }
}
