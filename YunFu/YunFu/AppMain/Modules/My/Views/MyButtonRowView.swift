//
//  MyButtonRowView.swift
//  MyFeature
//
//  作者（Author） : Frank
//  创建时间       : 2025-10-31
//  文件用途       : SwiftUI 两个按钮的横向组件（左右 20，上下 8 边距；单个按钮 161×60；企业级样式）
//  使用示例       : MyButtonRowView(actions: .init(onMyCollection: {...}, onMyRecent: {...}))
//

import SwiftUI

// 按钮回调集合（便于注入与单测）
public struct MyButtonRowActions {
    public let onMyCollection: () -> Void
    public let onMyRecent: () -> Void
    public init(onMyCollection: @escaping () -> Void, onMyRecent: @escaping () -> Void) {
        self.onMyCollection = onMyCollection
        self.onMyRecent = onMyRecent
    }
}

public struct MyButtonRowView: View {
    
    private let actions: MyButtonRowActions
    
    public init(actions: MyButtonRowActions) {
        self.actions = actions
    }
    
    public var body: some View {
        HStack(spacing: 16) {                                  // 两个按钮横排，间距 16
            FeatureButton(title: "我的收藏", icon: "heart.fill") { // 左：我的收藏
                performNav(actions.onMyCollection)
            }
            FeatureButton(title: "最近播放", icon: "clock.fill") { // 右：最近播放
                performNav(actions.onMyRecent)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)         // 占满可用宽度
        .padding(.vertical, 8)                                  // ⬆️⬇️ 上下边距 8
        .padding(.horizontal, 20)                               // ⬅️➡️ 左右边距 20
    }
    
    // 把导航动作延后到下一帧 + 轻触感
    private func performNav(_ action: @escaping () -> Void) {
        let haptic = UIImpactFeedbackGenerator(style: .light)
        haptic.impactOccurred()
        DispatchQueue.main.async { action() }
    }
}

// 单个按钮样式：宽 161，高 60，左对齐；描边 + 圆角 20；浅白蒙层
struct FeatureButton: View {
    let title: String
    let icon: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                Text(title)
                    .font(.system(size: 16, weight: .medium))
            }
            .foregroundColor(.primary)
            .frame(width: 161, height: 60, alignment: .center)
            .background(Color.white.opacity(0.05))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 0.5)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}
