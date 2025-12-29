import SwiftUI
import FamilyControls
import ManagedSettings

@available(iOS 17.0, *)
struct FocusControlView: View {

    // MARK: - 全局选择（唯一真源）
    @ObservedObject private var store = FocusSelectionStore.shared

    // MARK: - Picker 控制
    @State private var showPicker = false

    // MARK: - 是否正在拦截（系统真实状态）
    @State private var isBlocking = FocusShieldService.isBlocking()

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - 顶部图
            Image("familycontrols_02")
                .resizable()
                .scaledToFit()
                .frame(width: 330, height: 330)
                .padding(.top, 12)

            // MARK: - 标题 + 说明
            VStack(alignment: .leading, spacing: 6) {
                Text("\(LocalizedText.text("focus.title"))")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)

                let totalCount =
                    store.selection.applicationTokens.count +
                    store.selection.categoryTokens.count

                HStack {
                    Text("\(LocalizedText.text("focus.status.blocking"))")
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.8))

                    Spacer()

                    Text("\(LocalizedText.text("focus.count.prefix")) \(totalCount) \(LocalizedText.text("focus.count.suffix"))")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 24)
            .padding(.horizontal, 24)

            // MARK: - 卡片
            VStack(spacing: 12) {

                // ⭐ icon 行 + 编辑按钮
                HStack(spacing: 11) {

                    iconPreviewRow

                    Spacer()

                    Button {
                        showPicker = true
                    } label: {
                        Text("\(LocalizedText.text("focus.action.edit"))")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.black)
                            .frame(width: 48, height: 32)
                            .background(Color.white.opacity(0.6)) // #FFFFFF · 60%
                            .cornerRadius(8)
                    }
                }
            }
            .padding(16)
            .background(Color.white.opacity(0.06))
            .cornerRadius(12)
            .padding(.top, 16)
            .padding(.horizontal, 24)

            // MARK: - 主操作按钮（白色描边 / 透明背景）
            Button {
                toggleBlocking()
            } label: {
                Text(isBlocking ? "\(LocalizedText.text("focus.action.stop"))" : "\(LocalizedText.text("focus.action.start"))")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white, lineWidth: 1)
                    )
            }
            .padding(.top, 24)
            .padding(.horizontal, 24)
            .disabled(!store.hasSelection)

            Spacer()
        }

        // MARK: - Picker
        .sheet(isPresented: $showPicker) {
            FocusPickerView {
                showPicker = false
            }
        }
        .onAppear {
            isBlocking = FocusShieldService.isBlocking()
        }
    }

    // MARK: - 图标预览行（App + 类别）
    private var iconPreviewRow: some View {
        HStack(spacing: 11) {

            let appTokens = Array(store.selection.applicationTokens).prefix(5)
            let categoryTokens = Array(store.selection.categoryTokens).prefix(5)

            let totalCount =
                store.selection.applicationTokens.count +
                store.selection.categoryTokens.count

            let maxDisplay = 5
            let displayedCategories = min(categoryTokens.count, maxDisplay)
            let remainingSlots = max(0, maxDisplay - displayedCategories)
            let displayedApps = min(appTokens.count, remainingSlots)

            if appTokens.isEmpty && categoryTokens.isEmpty {
                Text("\(LocalizedText.text("ocus.status.noneSelected"))")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.4))
            } else {

                // 类别 icon
                ForEach(categoryTokens.prefix(displayedCategories), id: \.self) { token in
                    Label(token)
                        .labelStyle(.iconOnly)
                        .frame(width: 32, height: 32)
                        .background(Color.white.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }

                // App icon
                ForEach(appTokens.prefix(displayedApps), id: \.self) { token in
                    Label(token)
                        .labelStyle(.iconOnly)
                        .frame(width: 32, height: 32)
                        .background(Color.white.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }

                let displayedCount = displayedCategories + displayedApps

                if totalCount > displayedCount {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white.opacity(0.9))
                        .frame(width: 32, height: 32)
                        .background(Color.black.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - 拦截逻辑
    private func toggleBlocking() {
        if isBlocking {
            FocusShieldService.stopBlocking()
        } else {
            FocusShieldService.startBlocking()
        }
        isBlocking.toggle()
    }
}
