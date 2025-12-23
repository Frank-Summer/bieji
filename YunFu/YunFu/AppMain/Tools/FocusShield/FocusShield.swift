import UIKit
import FamilyControls
import SwiftUI

public enum FocusShield {

    @available(iOS 16.0, *)
    private static let manager = FocusShieldManager.shared

    /// 总入口（一行调用）
    /// 行为：
    /// - 未授权：请求授权，不弹窗
    /// - 已授权 + 已拦截：不弹窗
    /// - 已授权 + 未拦截：弹提示窗
    public static func toggle(from vc: UIViewController) {

        guard #available(iOS 16.0, *) else {
            print("⚠️ [FocusShield] 仅支持 iOS 16+")
            return
        }

        Task { @MainActor in

            // 1️⃣ 检查授权
            let status = AuthorizationCenter.shared.authorizationStatus

            if status != .approved {
                do {
                    try await AuthorizationCenter.shared
                        .requestAuthorization(for: .individual)
                    print("✅ [FocusShield] 授权成功")
                } catch {
                    print("❌ [FocusShield] 授权失败：\(error)")
                }
                return
            }

            // 2️⃣ 已在拦截中 → 不弹
            if manager.isShielding {
                print("🟢 [FocusShield] 已处于拦截状态")
                return
            }

            // 3️⃣ 弹提示窗
            presentHintSheet(from: vc)
        }
    }

    // MARK: - 提示窗
    @available(iOS 16.0, *)
    @MainActor
    private static func presentHintSheet(from vc: UIViewController) {

        let hintView = FocusShieldHintView {

            // 👉 点击「去设置拦截应用」

            // 未选 App → 先选
            if !manager.hasSelection {
                presentPicker()
                return
            }

            // 已选 → 开启拦截
            manager.applyShield()
        }

        // SwiftUI → UIKit
        let hosting = UIHostingController(rootView: hintView)
        hosting.view.backgroundColor = .clear

        let sheet = FocusShieldController(
            contentView: hosting.view,
            height: .fixed(725)
        )

        // ⚠️ 关键：一定从 Top VC present
        guard let topVC = UIApplication.topMostViewController() else {
            print("❌ [FocusShield] 获取 Top VC 失败")
            return
        }

        print("✅ [FocusShield] 从 \(type(of: topVC)) 弹出 Sheet")
        topVC.present(sheet, animated: false)
    }

    // MARK: - App 选择器
    @available(iOS 16.0, *)
    @MainActor
    private static func presentPicker() {

        guard let topVC = UIApplication.topMostViewController() else {
            return
        }

        let picker = FocusShieldPicker(
            selection: manager.selectionBinding
        )

        let hosting = UIHostingController(rootView: picker)

        // ✅【唯一真正生效的地方】
        hosting.overrideUserInterfaceStyle = .dark


        topVC.present(hosting, animated: true)
    }
}
