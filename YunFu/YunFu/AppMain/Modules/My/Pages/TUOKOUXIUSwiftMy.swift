
import UIKit
import Foundation
import SwiftUI

//我的页面
class TUOKOUXIUSwiftMy: TUOKOUXIUSwiftBaseVC {
    
    
    // 头像
    public let profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 33
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // 网名
    public let userName: UILabel = {
        let label = UILabel()
        label.text = "快乐不快乐..."
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // VIP 到期时间
    public let vipDate: UILabel = {
        let label = UILabel()
        label.text = "2025.06.08"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // VIP 图标
    public let vipLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 设置按钮
    public let setting: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 行容器
    private let headerContainer = UIView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // MARK: - Header 容器
        headerContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerContainer)
        
        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            headerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerContainer.heightAnchor.constraint(equalToConstant: 76)
        ])
        
        // 添加子视图
        headerContainer.addSubview(profilePicture)
        headerContainer.addSubview(userName)
        headerContainer.addSubview(vipDate)
        headerContainer.addSubview(vipLogo)
        headerContainer.addSubview(setting)
        
        // MARK: - 布局
        NSLayoutConstraint.activate([
            // 头像
            profilePicture.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor),
            profilePicture.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
            profilePicture.widthAnchor.constraint(equalToConstant: 66),
            profilePicture.heightAnchor.constraint(equalToConstant: 66),
            
            // 用户名（在头像右边、稍上）
            userName.leadingAnchor.constraint(equalTo: profilePicture.trailingAnchor, constant: 7),
            userName.topAnchor.constraint(equalTo: profilePicture.topAnchor, constant: 5),
            
            // VIP 时间（在用户名下方 4pt）
            vipDate.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            vipDate.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 4),
            
            // VIP 图标（在 VIP 时间右侧 5pt）
            vipLogo.leadingAnchor.constraint(equalTo: vipDate.trailingAnchor, constant: 5),
            vipLogo.centerYAnchor.constraint(equalTo: vipDate.centerYAnchor),
            vipLogo.widthAnchor.constraint(equalToConstant: 16),
            vipLogo.heightAnchor.constraint(equalToConstant: 16),
            
            // Setting 按钮（最右侧）
            setting.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
            setting.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor),
            setting.widthAnchor.constraint(equalToConstant: 24),
            setting.heightAnchor.constraint(equalToConstant: 24)
        ])
        
//        // MARK: - 图片资源
//        profilePicture.image = ResourceKit.image("logo", module: MyViewController.self)
//        vipLogo.image = ResourceKit.image("my_vip", module: MyViewController.self)
//        setting.image = ResourceKit.image("my_setting", module: MyViewController.self)
//        
        // ✅ SwiftUI 按钮行组件
        let buttonRow = MyButtonRowView(actions: .init(
            onMyCollection: { print("点击 我的收藏") },
            onMyRecent: { print("点击 最近播放") }
        ))
        // 给组件增加上下 padding 8pt
        let paddedButtonRow = buttonRow
        
        // ✅ 用 UIHostingController 包装
        let hostingVC = UIHostingController(rootView: paddedButtonRow)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
        
        // ✅ 布局在 headerContainer 下方
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingVC.view.topAnchor.constraint(equalTo: headerContainer.bottomAnchor), // header 下方间距 8
            hostingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
