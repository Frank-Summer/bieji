//
//  MyButtonRowView.swift
//  MyFeature
//

import SwiftUI

// 回调集合
public struct MyButtonRowActions {
    public let onMyCollection: () -> Void
    public let onMyRecent: () -> Void
    public init(onMyCollection: @escaping () -> Void,
                onMyRecent: @escaping () -> Void) {
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
        HStack(spacing: 16) {
            
            /// 左：我的收藏（本地图片）
            FeatureButton(
                title: "我的收藏",
                iconName: "my_collect"   // ← 改成本地图片
            ) {
                performNav(actions.onMyCollection)
            }
            
            /// 右：最近播放（本地图片）
            FeatureButton(
                title: "最近播放",
                iconName: "my_history"     // ← 改成本地图片
            ) {
                performNav(actions.onMyRecent)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
    }
    
    private func performNav(_ action: @escaping () -> Void) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        DispatchQueue.main.async { action() }
    }
}


struct FeatureButton: View {
    
    let title: String
    let iconName: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                
                // ← 使用 Swift Package 本地图片
                Image(iconName)  // SwiftUI 自动找资源
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
            }
            .foregroundColor(.white)
            .frame(width: 161, height: 60)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}
