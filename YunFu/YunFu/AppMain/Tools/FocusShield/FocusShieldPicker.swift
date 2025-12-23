import SwiftUI
import FamilyControls

@available(iOS 16.0, *)
struct FocusShieldPicker: View {

    @Environment(\.dismiss) private var dismiss
    @Binding var selection: FamilyActivitySelection

    // ✅ 关键：每次进来都是新 Picker
    @State private var pickerID = UUID()

    var body: some View {
        NavigationView {
            FamilyActivityPicker(selection: $selection)
                .id(pickerID)   // ⭐⭐⭐ 核心修复
                .navigationTitle("选择要拦截的 App")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("取消") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("完成") {
                            dismiss()
                        }
                    }
                }
        }
        .onAppear {
            // ⭐ 每次出现都换一个 ID，彻底杜绝“第二次不撑开”
            pickerID = UUID()
        }
    }
}
