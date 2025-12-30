import SwiftUI

@MainActor
enum FocusShieldUIFlow {

    static func start() {

        // 已在拦截 → 控制页
        if FocusShieldService.isBlocking() {
            presentControl()
            return
        }

        // 已选过 → 控制页
        if FocusSelectionStore.shared.hasSelection {
            presentControl()
            return
        }

        // 没权限
        if !FocusShieldService.isAuthorized() {
            Task {
                try? await FocusShieldService.requestAuthorization()
                presentIntro()
            }
            return
        }

        // 首次
        presentIntro()
    }
}



private extension FocusShieldUIFlow {

    // MARK: - Intro（使用自定义 BottomSheet）

    static func presentIntro() {
        let hosting = UIHostingController(
            rootView: FocusIntroView {
                dismissTop {
                    presentPicker()
                }
            }
        )
        
        hosting.view.backgroundColor = .clear

        let sheet = FocusShieldController(
            contentView: hosting.view,
            height: .fixed(752)   // 你可以自己调
        )

        TopPresenter.present(sheet)
    }

    // MARK: - Picker（❗使用系统 Sheet，不用自定义）

    static func presentPicker() {
        let pickerView = FocusPickerView {
            dismissTop {
                presentControl()
            }
        }

        let hosting = UIHostingController(rootView: pickerView)
        hosting.overrideUserInterfaceStyle = .dark
        // 👉 这里是系统样式
        hosting.modalPresentationStyle = .pageSheet

        TopPresenter.present(hosting)
    }

    // MARK: - Control（使用自定义 BottomSheet）

    static func presentControl() {

        guard #available(iOS 17.0, *) else {
            // iOS 16 及以下：不展示 Control（或给一个兜底）
            return
        }

        let hosting = UIHostingController(
            rootView: FocusControlView()
        )

        hosting.view.backgroundColor = .clear

        let sheet = FocusShieldController(
            contentView: hosting.view,
            height: .fixed(640)
        )

        TopPresenter.present(sheet)
    }

    // MARK: - Dismiss Helper

    static func dismissTop(completion: (() -> Void)? = nil) {
        TopPresenter.dismiss(completion: completion)
    }
}
