import SwiftUI
import FamilyControls

struct FocusPickerView: View {

    @ObservedObject private var store = FocusSelectionStore.shared
    let onDone: () -> Void

    // ⭐ 系统 dismiss（必须）
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            FamilyActivityPicker(selection: $store.selection)
                .navigationTitle("\(LocalizedText.text("focus.action.selectActivity"))")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {

                    // 取消
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("\(LocalizedText.text("focus.action.cancel"))") {
                            dismiss()
                        }
                    }

                    // 完成
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("\(LocalizedText.text("focus.action.done"))") {
                            dismiss()
                            onDone()
                        }
                    }
                }
        }
        .preferredColorScheme(.dark)
    }
}
