import FamilyControls
import ManagedSettings

@MainActor
enum FocusShieldService {

    private static let store = ManagedSettingsStore()

    // 权限
    static func isAuthorized() -> Bool {
        AuthorizationCenter.shared.authorizationStatus == .approved
    }

    static func requestAuthorization() async throws {
        try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
    }

    // 是否正在拦截
    static func isBlocking() -> Bool {
        store.shield.applications != nil ||
        store.shield.applicationCategories != nil
    }

    // 开始拦截
    static func startBlocking() {
        let selection = FocusSelectionStore.shared.selection
        store.shield.applications = selection.applicationTokens
        store.shield.applicationCategories = .specific(selection.categoryTokens)
    }

    // 取消拦截
    static func stopBlocking() {
        store.shield.applications = nil
        store.shield.applicationCategories = nil
    }
}
