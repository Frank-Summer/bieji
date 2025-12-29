import SwiftUI          // ObservableObject / @Published
import Combine          // @Published（保险）
import Foundation       // UserDefaults / JSONEncoder
import FamilyControls   // FamilyActivitySelection

@MainActor
final class FocusSelectionStore: ObservableObject {

    static let shared = FocusSelectionStore()

    @Published var selection: FamilyActivitySelection {
        didSet {
            save()
        }
    }

    private let key = "focus.selection"

    private init() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode(
                FamilyActivitySelection.self,
                from: data
           ) {
            selection = decoded
        } else {
            selection = FamilyActivitySelection()
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(selection) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    var hasSelection: Bool {
        !selection.applicationTokens.isEmpty ||
        !selection.categoryTokens.isEmpty
    }
}
