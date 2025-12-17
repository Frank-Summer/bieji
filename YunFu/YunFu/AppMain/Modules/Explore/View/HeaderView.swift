
import UIKit

class HeaderView: UIView {

    // MARK: - 数据源
    private let tufuh_arr: [String] = ["通勤","深睡眠","婴儿安睡","睡午觉","图书馆","健身","瑜伽","跑步","深夜专注","专注","工作","阅读","减压","胎教","宠物陪伴","放松","经期舒展","冥想","打游戏","深夜EMO"]
    private let tufuh_arr2: [String] = [
        "commute","sleep","baby-sleep","siesta","book","gym","yoga","run","latenight-focus","focus","work","read","stress-relief","prenatal-education","pet","relax","period","meditation","game","emo"
    ]

    // MARK: - 固定布局参数（按你最终需求）
    private let itemWidth: CGFloat = 76
    private let itemHeight: CGFloat = 87

    private let columnSpacing: CGFloat = 12   // 横向间距
    private let rowSpacing: CGFloat = 14      // 纵向间距

    private let itemsPerRow = 4
    
    /// 新增回调，Header 高度变化时触发
    var onHeightChange: ((CGFloat) -> Void)?

    // MARK: - 高度
    var minHeight: CGFloat { 12 + itemHeight + 14 }
    var maxHeight: CGFloat {
        let totalItems = tufuh_arr.count
        let rows = CGFloat(ceil(Double(totalItems) / 4.0))   // 每行 4 个
        return 12 + rows * itemHeight + (rows - 1) * rowSpacing + 14
    }

    // MARK: - 状态
    private(set) var isExpanded = false
    private var dragOffset: CGFloat = 0

    // MARK: - UI
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    var heightConstraint: NSLayoutConstraint!

    // MARK: - 宽度属性（用于 layoutSubviews 更新）
    private var collapsedWidth: CGFloat = 0
    private var expandedWidth: CGFloat = 0
    
    private var indexItemNum: Int = 0
    
    private let dragHandle: UIView = {
        let view = UIView()
        view.backgroundColor = TUOKOUXIUWhiteA30
        view.layer.cornerRadius = 3
        return view
    }()
    
    // 在 class HeaderView 的属性区
    private var contentWidthConstraint: NSLayoutConstraint?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = TUOKOUXIUSwiftwuseC

        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false

        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])

        heightConstraint = heightAnchor.constraint(equalToConstant: minHeight)
        heightConstraint.isActive = true
        
        addSubview(dragHandle)
        dragHandle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dragHandle.centerXAnchor.constraint(equalTo: centerXAnchor),
            dragHandle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            dragHandle.widthAnchor.constraint(equalToConstant: 36),
            dragHandle.heightAnchor.constraint(equalToConstant: 6)
        ])
        // 在 setupUI() 的 NSLayoutConstraint.activate([...]) 之后添加：
        contentWidthConstraint = contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        contentWidthConstraint?.isActive = true
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        pan.cancelsTouchesInView = false // 不拦截按钮点击事件
        addGestureRecognizer(pan)
    }

    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let currentHeight = heightConstraint?.constant ?? minHeight
        updateIcons(for: currentHeight)
    }

    // MARK: - 手势
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let tableView = superview as? UITableView else { return }
        
        let dy = gesture.translation(in: self).y
        gesture.setTranslation(.zero, in: self)

        // 计算新的高度
        var newHeight = heightConstraint?.constant ?? minHeight
        newHeight += dy
        newHeight = max(minHeight, min(maxHeight, newHeight))
        
        // 更新图标布局
        updateIcons(for: newHeight)
        
        // 通知 VC 或更新 tableHeaderView
        onHeightChange?(newHeight)
        heightConstraint?.constant = newHeight
        var headerFrame = tableView.tableHeaderView?.frame ?? .zero
        headerFrame.size.height = newHeight
        tableView.tableHeaderView?.frame = headerFrame

        // 手势结束时决定展开或收起
        if gesture.state == .ended || gesture.state == .cancelled {
            let velocity = gesture.velocity(in: self).y
            let shouldExpand = (newHeight - minHeight > (maxHeight - minHeight)/2) || velocity > 200
            animateExpand(shouldExpand, tableView: tableView)
        }
    }

    func animateExpand(_ expand: Bool, tableView: UITableView) {
        isExpanded = expand
        let targetHeight = expand ? maxHeight : minHeight

        UIView.animate(withDuration: 0.35,
                       delay: 0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseOut) {
            self.heightConstraint?.constant = targetHeight
            self.updateIcons(for: targetHeight)

            // 更新 tableHeaderView 高度
            var frame = tableView.tableHeaderView?.frame ?? .zero
            frame.size.height = targetHeight
            tableView.tableHeaderView?.frame = frame
        }
    }

    /// 新版：固定网格布局 + 自动边距计算
    private func updateIcons(for height: CGFloat) {
        let isCollapsed = height <= minHeight + 1
        let progress = (height - minHeight) / (maxHeight - minHeight)
        let screenW = bounds.width

        // —— 计算左右边距（重点） ——
        let totalItemsWidth = CGFloat(itemsPerRow) * itemWidth
        let totalSpacingWidth = CGFloat(itemsPerRow - 1) * columnSpacing
        let remain = screenW - totalItemsWidth - totalSpacingWidth
        let horizontalPadding = max(0, remain / 2)

        // ******** 清空旧 cell（必须保留） ********
        contentView.subviews.forEach { $0.removeFromSuperview() }

        // 多少行
        let rows = Int(ceil(Double(tufuh_arr.count) / Double(itemsPerRow)))

        for i in 0..<tufuh_arr.count {

            let cell = makeIconCell(index: i)

            let row: Int
            let col: Int

            if isCollapsed {
                // —— 收起态：所有 item 横向排成一行 ——
                row = 0
                col = i
            } else {
                // —— 展开态：正常 4 列网格 ——
                row = i / itemsPerRow
                col = i % itemsPerRow
            }

            let x = horizontalPadding + CGFloat(col) * (itemWidth + columnSpacing)
            let y = 12 + CGFloat(row) * (itemHeight + rowSpacing)

            cell.frame = CGRect(x: x, y: y, width: itemWidth, height: itemHeight)

            contentView.addSubview(cell)
        }

        // —— contentView 高度 ——
        let totalHeight: CGFloat

        if isCollapsed {
            totalHeight = minHeight
        } else {
            totalHeight =
                12 +
                CGFloat(rows) * itemHeight +
                CGFloat(rows - 1) * rowSpacing +
                12
        }

        contentView.frame.size.height = totalHeight

        // —— 横向滚动控制 ——
        // 接近最小高度，认为是「收起态」

        scrollView.isScrollEnabled = isCollapsed
        scrollView.alwaysBounceHorizontal = isCollapsed
        scrollView.showsHorizontalScrollIndicator = isCollapsed

        // content 宽度：收起时横向一行全部图标，展开时=屏宽
        let collapsedWidth = horizontalPadding * 2 +
            CGFloat(tufuh_arr.count) * (itemWidth + columnSpacing) -
            columnSpacing

        let expandedWidth = screenW

        let curWidth = lerp(start: collapsedWidth, end: expandedWidth, p: progress)
        contentWidthConstraint?.constant = max(curWidth, screenW)

        contentView.layoutIfNeeded()
        scrollView.layoutIfNeeded()
    }

    private func makeIconCell(index: Int) -> UIView {
        let button = UIButton(type: .custom)
        button.tag = index+1
        button.backgroundColor = TUOKOUXIUSwiftwuseC
        button.layer.cornerRadius = 20
        button.clipsToBounds = true

        // StackView 容器
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6
        stack.isUserInteractionEnabled = false
        // 图片
        let imageView = UIImageView(image: UIImage(named: tufuh_arr2[index]))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true

        // 文案
        let label = UILabel()
        label.text = tufuh_arr[index]
        label.font = TUOKOUXIUSwiftFont.regular(12)
        label.textColor = TUOKOUXIUSwiftbaiseC

        // 添加到 StackView
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(label)
        stack.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(stack)

        // StackView 居中约束
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        if indexItemNum > 0 {
            if index + 1 == indexItemNum {
                button.isSelected = true
                button.backgroundColor = TUOKOUXIUWhiteA10
                button.layer.borderColor = TUOKOUXIUWhiteA60.cgColor
                button.layer.borderWidth = 1
            } else {
                button.backgroundColor = TUOKOUXIUSwiftwuseC
                button.layer.borderColor = TUOKOUXIUSwiftwuseC.cgColor
                button.layer.borderWidth = 0
            }
        } else {
            // 默认选中逻辑
            if index == 2 {
                button.isSelected = true
                indexItemNum = 3
                button.backgroundColor = TUOKOUXIUWhiteA10
                button.layer.borderColor = TUOKOUXIUWhiteA60.cgColor
                button.layer.borderWidth = 1
            } else {
                button.backgroundColor = TUOKOUXIUSwiftwuseC
                button.layer.borderColor = TUOKOUXIUSwiftwuseC.cgColor
                button.layer.borderWidth = 0
            }
        }

        button.addTarget(self, action: #selector(clickTypeUpdate(_:)), for: .touchUpInside)
        return button
    }
                                 
    @objc func clickTypeUpdate(_ btn: UIButton) {
        // 如果点的是同一个按钮，直接返回
        if btn.tag == indexItemNum { return }

        // 取消上一个按钮的选中状态
        if let previousBtn = contentView.viewWithTag(indexItemNum) as? UIButton {
            previousBtn.isSelected = false
            previousBtn.backgroundColor = TUOKOUXIUSwiftwuseC
            previousBtn.layer.borderColor = TUOKOUXIUSwiftwuseC.cgColor
            previousBtn.layer.borderWidth = 0
        }

        // 设置当前按钮为选中状态
        btn.isSelected = true
        btn.backgroundColor = TUOKOUXIUWhiteA10
        btn.layer.borderColor = TUOKOUXIUWhiteA60.cgColor
        btn.layer.borderWidth = 1

        // 更新索引
        indexItemNum = btn.tag

        print("选中了按钮 \(btn.tag)")
    }

    // MARK: - 工具
    private func lerp(start: CGFloat, end: CGFloat, p: CGFloat) -> CGFloat {
        return start + (end - start) * p
    }
}
