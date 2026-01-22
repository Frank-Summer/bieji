
import UIKit
import SnapKit

class TUOKOUXIUExploreVC: UIViewController {
    
    private var tufuh_arr: [String] = [
        "通勤","深睡眠","婴儿安睡","睡午觉","图书馆","健身","瑜伽","跑步",
        "深夜专注","专注","工作","阅读","减压","胎教","宠物陪伴","放松",
        "经期舒展","冥想","打游戏","深夜EMO"
    ]

    private let tufuh_arr2: [String] = [
        "commute","sleep","baby-sleep","siesta","book","gym","yoga","run",
        "latenight-focus","focus","work","read","stress-relief","prenatal-education",
        "pet","relax","period","meditation","game","emo"
    ]
    private var indexItemNum: Int = 0
    private let itemWidth: CGFloat = 76
    private let itemHeight: CGFloat = 87
    private let columnSpacing: CGFloat = 8
    private let rowSpacing: CGFloat = 12
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        Task {
            await AuthService.getExploreDetail()
//            TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_detailModel = self.detailModel
            print("✅ model 获取成功")
        }
    }
    
    private var isExpanded = false

    private let topHeightCollapsed: CGFloat = 130 + TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 40
    private let topHeightExpanded: CGFloat = 545 + TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 40

    private let tableView = UITableView(frame: .zero, style: .plain)
    private var topHeightConstraint: Constraint?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private func applyLayoutConfig(_ layout: UICollectionViewFlowLayout) {
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: rowSpacing, right: 12)
        layout.minimumInteritemSpacing = columnSpacing
        layout.minimumLineSpacing = rowSpacing
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    private func makeExpandedLayout() -> UICollectionViewFlowLayout {
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .vertical
        l.minimumInteritemSpacing = columnSpacing
        l.minimumLineSpacing = rowSpacing
        l.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: rowSpacing, right: 12)
        return l
    }
    
    private func makeCollapsedLayout() -> UICollectionViewFlowLayout {
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .horizontal
        l.minimumInteritemSpacing = columnSpacing
        l.minimumLineSpacing = rowSpacing
        l.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: rowSpacing, right: 12)
        return l
    }
    
    private var didSetupLayout = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = TUOKOUXIUSwiftheiseC
        setupUI()
    }
    
    private func applyLayoutConfig(_ layout: UICollectionViewFlowLayout, isCollapsed: Bool = false) {
        let leftInset: CGFloat = 16
        let rightInset: CGFloat = 16
        layout.sectionInset = UIEdgeInsets(top: 12, left: leftInset, bottom: rowSpacing, right: rightInset)
        layout.minimumLineSpacing = rowSpacing

        if isCollapsed {
            // 横向滚动，item宽度固定
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = columnSpacing
        } else {
            // 竖向滚动，4列，间距自动计算
            layout.scrollDirection = .vertical
            let columns: CGFloat = 4
            let availableWidth = collectionView.bounds.width - leftInset - rightInset
            let columnSpacing = (availableWidth - itemWidth * columns) / (columns - 1)
            layout.minimumInteritemSpacing = columnSpacing
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tufuh_arr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_sortArray
        indexItemNum = 2
        guard !didSetupLayout else { return }
        didSetupLayout = true

        // 初次显示用 collapsed 布局（横向滚动）
        let layout = makeCollapsedLayout()
        applyLayoutConfig(layout, isCollapsed: true)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.reloadData()
        collectionView.setContentOffset(.zero, animated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView === tableView else { return }

        guard isExpanded else { return }

        if scrollView.contentOffset.y > 20 {
            finishExpand()
        }
    }
    
    private func setupUI() {
        let topView = UIView()
        view.addSubview(topView)
        topView.backgroundColor = .black

        topView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.leading.trailing.equalToSuperview()
            topHeightConstraint = $0.height.equalTo(topHeightCollapsed).constraint
        }

        collectionView.backgroundColor = .black
        collectionView.register(TufuhIconCell.self, forCellWithReuseIdentifier: "TufuhIconCellId")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        topView.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 40 + 12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        let containerView = UIView()
        containerView.layer.cornerRadius = 30
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = TUOKOUXIUWhiteA10.cgColor
        containerView.clipsToBounds = true
        containerView.backgroundColor = TUOKOUXIUWhiteA5
        containerView.isUserInteractionEnabled = false

        topView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        let indicatorHitArea = UIView()
        indicatorHitArea.backgroundColor = .clear
        topView.addSubview(indicatorHitArea)

        indicatorHitArea.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(40)
        }

        indicatorHitArea.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))

        let indicator = UIView()
        indicator.backgroundColor = TUOKOUXIUWhiteA30
        indicator.layer.cornerRadius = 3
        indicatorHitArea.addSubview(indicator)

        indicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-15)
            $0.width.equalTo(44)
            $0.height.equalTo(6)
        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUExploreTabVVDefCellId")
        tableView.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell2Id")
        tableView.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell3Id")
        tableView.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell4Id")
        tableView.register(TUOKOUXIUExploreCell2.self, forCellReuseIdentifier: "TUOKOUXIUExploreCell5Id")
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false

        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        UIImageView.tukou_bjImageV(CGRect(x: TUOKOUXIUSwiftSCRE_W/2-72/2, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 15, width: 72, height: 18), superView: self.view, image: UIImage(named: "Explore-title"))
        UIImageView.tukou_bjImageV(CGRect(x: 0, y: 0, width: Int(TUOKOUXIUSwiftSCRE_W), height: Int(TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight) + 76), superView: self.view, image: UIImage(named: "home_top_shadow"))
    }
    
    private var panStartHeight: CGFloat = 0
    private var panProgress: CGFloat = 0
    private var isPanning = false
    
    @objc private func handlePan(_ g: UIPanGestureRecognizer) {

        let translationY = g.translation(in: view).y
        let range = topHeightExpanded - topHeightCollapsed

        switch g.state {

        case .began:
            isPanning = true
            panStartHeight = topHeightConstraint?.layoutConstraints.first?.constant
                ?? (isExpanded ? topHeightExpanded : topHeightCollapsed)
            tableView.isScrollEnabled = false

        case .changed:
            // 上拉是展开（dy < 0）
            let delta = -translationY
            var height = panStartHeight + delta

            height = max(topHeightCollapsed, min(topHeightExpanded, height))

            panProgress = (height - topHeightCollapsed) / range

            topHeightConstraint?.update(offset: height)
            view.layoutIfNeeded()

        case .ended, .cancelled:
            isPanning = false
            tableView.isScrollEnabled = true

            if panProgress > 0.5 {
                finishExpand()
            } else {
                finishCollapse()
            }

        default:
            break
        }
    }
    
    private func finishExpand() {
        guard isExpanded else { return }
        isExpanded = false

        let layout = makeCollapsedLayout()
        applyLayoutConfig(layout)

        collectionView.setCollectionViewLayout(layout, animated: false)
        topHeightConstraint?.update(offset: topHeightCollapsed)

        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.6
        ) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func finishCollapse() {
        guard !isExpanded else { return }
        isExpanded = true

        tableView.setContentOffset(.zero, animated: false)

        let layout = makeExpandedLayout()
        applyLayoutConfig(layout)

        collectionView.setCollectionViewLayout(layout, animated: false)
        topHeightConstraint?.update(offset: topHeightExpanded)

        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 0.6
        ) {
            self.view.layoutIfNeeded()
        }
    }
    
//    private func expand() {
//        guard !isExpanded else { return }
//        isExpanded = true
//
//        tableView.setContentOffset(.zero, animated: false)
//
//        let layout = makeExpandedLayout()
//        applyLayoutConfig(layout)
//
//        collectionView.setCollectionViewLayout(layout, animated: false)
//        topHeightConstraint?.update(offset: topHeightExpanded)
//
//        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.82, initialSpringVelocity: 0.6) {
//            self.view.layoutIfNeeded()
//        }
//    }
//
//    private func collapse() {
//        guard isExpanded else { return }
//        isExpanded = false
//
//        let layout = makeCollapsedLayout()
//        applyLayoutConfig(layout)
//
//        collectionView.setCollectionViewLayout(layout, animated: false)
//        topHeightConstraint?.update(offset: topHeightCollapsed)
//
//        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.6) {
//            self.view.layoutIfNeeded()
//        }
//    }
}

extension TUOKOUXIUExploreVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 265
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 100))
        footerView.backgroundColor = TUOKOUXIUSwiftwuseC
        return footerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell2Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            cell.tufuh_isLock = false
            cell.tukou_nameString("活跃")
            cell.TUOKOUXIUclkItemBlk = { model in
                NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUShowLeiXing"), object: nil)
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell3Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            cell.tufuh_isLock = false
            cell.tukou_nameString("助眠")
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell4Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            cell.tufuh_isLock = false
            cell.tukou_nameString("放松")
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreCell5Id", for: indexPath) as! TUOKOUXIUExploreCell2
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            cell.tufuh_isLock = true
            cell.tukou_nameString("专注")
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUExploreTabVVDefCellId", for: indexPath)
        cell.backgroundColor = TUOKOUXIUSwiftheiseC
        return cell
    }
}

extension TUOKOUXIUExploreVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tufuh_arr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TufuhIconCellId", for: indexPath) as! TufuhIconCell
        cell.config(title: tufuh_arr[indexPath.item], imageName: tufuh_arr2[indexPath.item])
        if indexPath.row == indexItemNum {
            cell.isSelect()
        } else {
            cell.isUnSelect()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == indexItemNum { return }

        indexItemNum = indexPath.row
        collectionView.reloadData()
    }
}

final class TufuhIconCell: UICollectionViewCell {

    private let iconView = UIImageView()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.backgroundColor = .clear

        iconView.contentMode = .scaleAspectFit
        titleLabel.font = TUOKOUXIUSwiftFont.regular(12)
        titleLabel.textColor = TUOKOUXIUSwiftbaiseC
        titleLabel.textAlignment = .center

        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        iconView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(32)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
    }
    
    func isSelect() {
        contentView.backgroundColor = TUOKOUXIUWhiteA10
        contentView.layer.borderColor = TUOKOUXIUWhiteA60.cgColor
        contentView.layer.borderWidth = 1
    }
    
    func isUnSelect() {
        contentView.backgroundColor = TUOKOUXIUSwiftwuseC
        contentView.layer.borderColor = TUOKOUXIUSwiftwuseC.cgColor
        contentView.layer.borderWidth = 0
    }
    
    func config(title: String, imageName: String) {
        titleLabel.text = title
        iconView.image = UIImage(named: imageName)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
