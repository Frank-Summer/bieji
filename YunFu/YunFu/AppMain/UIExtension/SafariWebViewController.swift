import UIKit
import SafariServices

/// 通用网页展示组件（基于 SFSafariViewController）
final class SafariWebViewController: NSObject {

    /// 展示网页
    /// - Parameters:
    ///   - from: 当前的 UIViewController（用于 present）
    ///   - url: 目标网页 URL 字符串
    ///   - title: 可选标题（仅用于导航栏）
    static func present(from: UIViewController, url: String, title: String? = nil) {
        guard let link = URL(string: url) else {
            print("❌ 无效的 URL: \(url)")
            return
        }

        // ✅ 创建 Safari 视图控制器
        let safariVC = SFSafariViewController(url: link)
        safariVC.preferredBarTintColor = .black     // 背景色
        safariVC.preferredControlTintColor = .white // 控件颜色
        safariVC.dismissButtonStyle = .close        // 左上角“关闭”样式
        safariVC.modalPresentationStyle = .formSheet

        // ✅ 如果有标题，在导航栏显示
        if let title = title {
            safariVC.title = title
        }

        from.present(safariVC, animated: true)
    }
}
