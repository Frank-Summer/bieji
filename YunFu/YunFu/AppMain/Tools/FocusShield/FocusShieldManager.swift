import Foundation
import FamilyControls
import ManagedSettings
import SwiftUI

@available(iOS 16.0, *)
final class FocusShieldManager: ObservableObject {

    static let shared = FocusShieldManager()
    private init() {}

    private let store = ManagedSettingsStore()

    // 用户选择的 App / 分类
    @Published var selection = FamilyActivitySelection()

    // SwiftUI Binding
    var selectionBinding: Binding<FamilyActivitySelection> {
        Binding(
            get: { self.selection },
            set: { self.selection = $0 }
        )
    }

    /// 是否已经选择过 App
    var hasSelection: Bool {
        !selection.applicationTokens.isEmpty ||
        !selection.categoryTokens.isEmpty
    }

    /// 当前是否正在拦截
    var isShielding: Bool {
        store.shield.applications != nil ||
        store.shield.applicationCategories != .none
    }

    // MARK: - 开启拦截
    func applyShield() {

        guard hasSelection else {
            print("⚠️ [FocusShield] 没有选择任何 App")
            return
        }

        store.shield.applications = selection.applicationTokens
        store.shield.applicationCategories = .specific(selection.categoryTokens)

        print("🔒 [FocusShield] 拦截已开启")
    }

    // MARK: - 关闭拦截
    func clearShield() {
        store.shield.applications = nil
        store.shield.applicationCategories = .none
        print("🔓 [FocusShield] 拦截已关闭")
    }
}
