import SwiftUI

struct FocusIntroView: View {

    let onStart: () -> Void

    var body: some View {

        VStack(spacing: 0) {

            // MARK: - 标题（真正左右居中，紧贴顶部）
            Text("\(LocalizedText.text("focus.title"))")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.top, 24)

            // MARK: - 内容区（左对齐）
            VStack(alignment: .leading, spacing: 0) {

                // 插画
                Image("familycontrols_01")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 320, height: 320)
                    .padding(.top, 24)

                // Headline
                Text("\(LocalizedText.text("focus.intro.title"))")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.top, 24)

                // 描述
                Text("\(LocalizedText.text("focus.intro.description"))")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.top, 12)

                // Feature List（间距绝对一致）
                VStack(alignment: .leading, spacing: 8) {
                    FeatureRow(icon: "yoga", text: "\(LocalizedText.text("focus.scene.meditation"))")
                    FeatureRow(icon: "sleep", text: "\(LocalizedText.text("focus.scene.sleep"))")
                    FeatureRow(icon: "run", text: "\(LocalizedText.text("focus.scene.exercise"))")
                }
                .padding(.top, 12)

                // Button（居中）
                Button(action: {
                    onStart()
                }) {
                    Text("\(LocalizedText.text("focus.intro.actionHint"))")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 327, height: 48)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.4), lineWidth: 1)
                        )
                }
                .padding(.top, 22)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .background(Color.clear)
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

// MARK: - Feature Row（高度锁死，间距永远一致）
private struct FeatureRow: View {

    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {

            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)

            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.85))
                .lineLimit(1)
        }
        .frame(height: 20)
    }
}
