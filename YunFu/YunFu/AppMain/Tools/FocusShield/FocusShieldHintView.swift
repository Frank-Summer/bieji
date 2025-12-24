import SwiftUI

/// FocusShield 提示视图（SwiftUI 版本）
///
/// 用途：
/// - 提示「应用拦截 / 专注模式已开启」
/// - 可用于 BottomSheet / Sheet / UIHostingController
///
/// 作者：Frank
/// 创建时间：2025-12
struct FocusShieldHintView: View {

    /// 点击按钮回调
    var onAction: (() -> Void)?

    var body: some View {

        VStack(spacing: 0) {

            // MARK: - 标题（真正左右居中，紧贴顶部）
            Text("应用程序拦截")
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
                Text("您的数字结界已就位")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.top, 24)

                // 描述
                Text("""
欢迎开启「应用拦截」！
这是【别急】为不同生活场景设计的防护罩：
""")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.top, 12)

                // Feature List（间距绝对一致）
                VStack(alignment: .leading, spacing: 8) {
                    FeatureRow(icon: "yoga", text: "冥想时 - 自动屏蔽消息通知")
                    FeatureRow(icon: "sleep", text: "睡眠时 - 拦截短视频和游戏")
                    FeatureRow(icon: "run", text: "运动时 - 关闭社交软件红点焦虑")
                }
                .padding(.top, 12)

                // Button（居中）
                Button(action: {
                    onAction?()
                }) {
                    Text("去设置拦截应用")
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
        // MARK: - 外边距
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
