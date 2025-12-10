import SwiftUI

struct ContentView: View {
    // --- 1. 数据源 ---
    private let topIcons = ["star", "heart", "bell", "person"]
    private let gridIcons = [
        "house", "magnifyingglass", "paperplane", "bookmark",
        "flame", "bolt", "cloud", "umbrella",
        "folder", "gear", "tray", "doc",
        "music.note", "video", "camera", "phone"
    ]
    private var allIcons: [String] { topIcons + gridIcons }
    
    // --- 2. 常量定义 ---
    private let bottomBarHeight: CGFloat = 56
    private let collapsedSpacing: CGFloat = 12
    private let expandedSpacing: CGFloat = 20
    
    // 图标容器大小 (包含图片+文字)
    // 调大一点以容纳大图标
    private let itemHeight: CGFloat = 70
    
    // --- 3. 高度计算 ---
    // 收起时高度：顶部padding 12 + item高度 + 底部余量
    private var minHeight: CGFloat { 12 + itemHeight + 12 }
    
    // 展开时高度：自动计算 5 行的高度
    private var maxHeight: CGFloat {
        let rows = 5.0
        let verticalPadding: CGFloat = 24 // Top 12 + Bottom 12
        return (CGFloat(rows) * itemHeight) + (CGFloat(rows - 1) * expandedSpacing) + verticalPadding
    }
    
    // 状态
    @State private var isExpanded = false
    @State private var dragOffset: CGFloat = 0
    
    // 动态高度
    private var currentHeight: CGFloat {
        let baseHeight = isExpanded ? maxHeight : minHeight
        return min(max(baseHeight + dragOffset, minHeight), maxHeight)
    }
    
    // 核心进度：0.0 (收起) ~ 1.0 (展开)
    private var progress: CGFloat {
        return (currentHeight - minHeight) / (maxHeight - minHeight)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                // 顶栏
                headerView
                    .zIndex(1)

                // 内容
                contentScrollView
            }
            
            // 底栏
            Text("底栏")
                .frame(maxWidth: .infinity, maxHeight: bottomBarHeight)
                .background(Color(.systemGray6))
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    // MARK: - 核心修改：手动布局引擎
    private var headerView: some View {
        GeometryReader { proxy in
            let W = proxy.size.width
            
            // 1. 计算两种状态下的单元格宽度
            // 收起状态：一行约4.5个
            let collapsedItemWidth = (W - 16 * 2 - collapsedSpacing * 4) / 4.5
            // 展开状态：一行4个
            let expandedItemWidth = (W - 16 * 2 - expandedSpacing * 3) / 4
            
            // 2. 当前插值宽度
            let currentItemWidth = lerp(start: collapsedItemWidth, end: expandedItemWidth, p: progress)
            let currentSpacing = lerp(start: collapsedSpacing, end: expandedSpacing, p: progress)
            
            // 3. 计算整个容器的内容宽度
            // 收起时：所有图标排成一行，很宽
            let collapsedContentWidth = 16 + CGFloat(allIcons.count) * (collapsedItemWidth + collapsedSpacing) + 16
            // 展开时：宽度就是屏幕宽度
            let expandedContentWidth = W
            
            let currentContentWidth = lerp(start: collapsedContentWidth, end: expandedContentWidth, p: progress)
            
            // 使用 ScrollView 包裹，实现收起时的横向滚动
            ScrollView(.horizontal, showsIndicators: false) {
                // ZStack 代替 Grid，实现绝对定位
                ZStack(alignment: .topLeading) {
                    ForEach(0..<allIcons.count, id: \.self) { index in
                        // 计算每个图标的坐标
                        let pos = calculatePosition(
                            index: index,
                            progress: progress,
                            collapsedWidth: collapsedItemWidth,
                            expandedWidth: expandedItemWidth,
                            collapsedSpacing: collapsedSpacing,
                            expandedSpacing: expandedSpacing
                        )
                        
                        // 图标单元格
                        VStack(spacing: 4) {
                            Image(systemName: allIcons[index])
                                .font(.system(size: 30)) // 大图标
                                .frame(height: 36)
                            
                            Text("icon\(index + 1)")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        .frame(width: currentItemWidth, height: itemHeight)
                        // ★★★ 核心：绝对定位 ★★★
                        .position(x: pos.x + currentItemWidth / 2, y: pos.y + itemHeight / 2)
                    }
                }
                .frame(width: currentContentWidth, height: maxHeight) // 容器撑开，保证 ScrollView 可滚
            }
            // 当展开时（progress > 0.1），禁止横向滚动，以免干扰体验
            .disabled(progress > 0.1)
        }
        .frame(height: currentHeight, alignment: .top)
        .clipped()
        .background(Color.white)
        .overlay(DragHandle().offset(y: -4), alignment: .bottom)
        .contentShape(Rectangle())
        .gesture(headerDragGesture)
    }

    // MARK: - 坐标计算引擎
    
    // 线性插值函数 (Linear Interpolation)
    func lerp(start: CGFloat, end: CGFloat, p: CGFloat) -> CGFloat {
        return start + (end - start) * p
    }
    
    func calculatePosition(index: Int, progress: CGFloat,
                           collapsedWidth: CGFloat, expandedWidth: CGFloat,
                           collapsedSpacing: CGFloat, expandedSpacing: CGFloat) -> CGPoint {
        
        let padding: CGFloat = 16
        
        // --- 1. 计算收起时的位置 (Start) ---
        // 所有图标排成一行: x 递增, y = 12
        let startX = padding + CGFloat(index) * (collapsedWidth + collapsedSpacing)
        let startY: CGFloat = 12
        
        // --- 2. 计算展开时的位置 (End) ---
        // 4列网格布局
        let col = index % 4
        let row = index / 4
        let endX = padding + CGFloat(col) * (expandedWidth + expandedSpacing)
        let endY = 12 + CGFloat(row) * (itemHeight + expandedSpacing)
        
        // --- 3. 插值 ---
        let currentX = lerp(start: startX, end: endX, p: progress)
        let currentY = lerp(start: startY, end: endY, p: progress)
        
        return CGPoint(x: currentX, y: currentY)
    }
    
    // MARK: - 其他部分保持不变
    
    private var contentScrollView: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(0..<20) { i in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.15))
                        .frame(height: 100)
                        .overlay(Text("Item \(i)"))
                }
            }
            .padding(16)
            .padding(.bottom, bottomBarHeight + 20)
        }
        .simultaneousGesture(
            DragGesture().onChanged { value in
                if isExpanded && value.translation.height < -10 {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                        isExpanded = false
                        dragOffset = 0
                    }
                }
            }
        )
    }
    
    private var headerDragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                dragOffset = value.translation.height
            }
            .onEnded { value in
                let velocity = value.predictedEndLocation.y - value.location.y
                let threshold = (maxHeight - minHeight) / 2
                let shouldExpand = isExpanded
                    ? (dragOffset > -threshold && velocity > -100)
                    : (dragOffset > threshold || velocity > 100)
                
                withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                    isExpanded = shouldExpand
                    dragOffset = 0
                }
            }
    }
}

struct DragHandle: View {
    var body: some View {
        Capsule()
            .fill(Color.gray.opacity(0.4))
            .frame(width: 40, height: 4)
            .frame(height: 20)
            .contentShape(Rectangle())
    }
}
