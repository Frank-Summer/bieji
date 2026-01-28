
import UIKit
import AVFoundation
import Kingfisher

class HomeSubVC: TUOKOUXIUSwiftBaseVC, UITableViewDelegate, UITableViewDataSource {
    private var isPlayerSetup = false

    var tufuh_num: Int = 0
    var tufuh_isFirstLoad: Bool = false
    
    // MARK: - 公共/UI
    private let playerView = VideoPlayerView()           // 只创建一次
    private let loadingView: UIActivityIndicatorView = { // 调试时 所有loadingView都给注释 之后需要解开
        let lv = UIActivityIndicatorView(style: .large)
        lv.color = .white
        lv.hidesWhenStopped = true
        return lv
    }()

    lazy var tufuh_tabV: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .black
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    func urlAddToken(url: URL) -> AVPlayerItem {
        var headers: [String: String] = [:]

        if let token = TokenStorage.shared.accessToken {
            headers["Authorization"] = "Bearer \(token)"
            // 如果你后端不是 Bearer，自行改
            // headers["token"] = token
        }

        let asset = AVURLAsset(
            url: url,
            options: [
                "AVURLAssetHTTPHeaderFieldsKey": headers
            ]
        )

        let item = AVPlayerItem(asset: asset)
        return item
    }

    // MARK: - 播放器状态
    var videoURL: URL?
    var detailModel: MusicModel?

    var player: AVPlayer?          // AVPlayer 类属性（可复用或替换 item）
    
    private var statusObservation: NSKeyValueObservation?
    var tufuh_gaiV: UIView?
    var tufuh_gaiViamgeView: UIImageView?
    var tufuh_gaiVtitleL: UILabel?
    var tufuh_gaiIconIV: UIImageView?
    var tufuh_gaiVcontentL: UILabel?
    let tufuh_model:SceneModel?
    // 标志，表示是否已经在 cell 上UILabel化了播放器（避免重复）
    private var didSetupPlayerInCell = false

    // MARK: - 生命周期
    init(tufuh_model: SceneModel) {
        self.tufuh_model = tufuh_model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    func makeURLs(from strings: [String]) -> [URL] {
        strings.compactMap { str in
            let encoded = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            return encoded.flatMap { URL(string: $0) }
        }
    }
    @objc private func loadMusicDetail(_ notification: Notification) {
        guard let model = notification.object as? MusicItem else { return }
        
        Task {
            let url = model.songUuid
            self.detailModel = await AuthService.getMusicDetail(Uuid: url)
            
            print("✅ 点击探索页cell加载详情 获取成功")
            self.videoURL = URL(string: self.detailModel?.videoFileUrl ?? "")
            if let urlStrings = self.detailModel?.musicFileUrl, !urlStrings.isEmpty {
                let urls = makeURLs(from: urlStrings)

                AudioPlayerManager.shared.playAudios(with: urls)
            }
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_metaInfo = self.detailModel?.meta
            tufuh_tabV.reloadData()

            TUOKOUXIUSwiftDelaBlk(0.1) {
                NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUEnterDetailView"), object: nil)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // view 已经 attach 到 window，此时如果 cell 已经 layout，会触发 VideoPlayerCell.onReadyForPlayer -> setupPlayerInCell
        // 如果第一次还没在 cell 上初始化，我们在这里再次尝试（兜底）
        guard TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_selectNum == self.tufuh_num else { return }
        
        trySetupPlayerIfNeeded()
        if self.tufuh_isFirstLoad {
            if TUOKOUXIUSwiftComSJ.tukou_sLcom.isClickLeftAndRight {
                TUOKOUXIUSwiftComSJ.tukou_sLcom.isClickLeftAndRight = false
                return
            }
            if let urlStrings = self.detailModel?.musicFileUrl, !urlStrings.isEmpty {
                let urls = makeURLs(from: urlStrings)
                AudioPlayerManager.shared.playAudios(with: urls)
            }
        }else{
            print("✅ 333333")
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_selectNum == self.tufuh_num else { return }
        // 当页面返回时，如果播放器已有 item 且 ready，则恢复播放（scroll 控制会判断是否可见）
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.player?.currentItem?.status == .readyToPlay {
                if isFirstCellVisible {
                    self.playerView.play()
                }
            }
        }
//        queuePlayer?.play()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 暂停并保留 item（如果你希望切走时销毁，可以调用 cleanup()）
        playerView.pause()
//        queuePlayer?.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loadMusicDetail(_:)),
            name: NSNotification.Name("TUOKOUXIULoadMusicDetail"),
            object: nil
        )
        Task {
            self.tufuh_isFirstLoad = true
            if let uids = self.tufuh_model?.songUuids, uids.count > TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_selectNum {
                guard let url = self.tufuh_model?.songUuids[TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_selectNum] else { return }
                self.detailModel = await AuthService.getMusicDetail(Uuid: url)
                
                print("✅ 第一次进入 获取成功")
                self.videoURL = URL(string: self.detailModel?.videoFileUrl ?? "")
                if let urlStrings = self.detailModel?.musicFileUrl, !urlStrings.isEmpty {
                    let urls = makeURLs(from: urlStrings)

                    AudioPlayerManager.shared.playAudios(with: urls)
                }
                TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_metaInfo = self.detailModel?.meta
                tufuh_tabV.reloadData()
                NotificationCenter.default.post(name: Notification.Name("TUOKOUXIURefreshHomeWindow"), object: nil)
            }
        }

        // 1) 先创建 tableView（不要在 viewDidLoad 中触发 cell 的 layout 或 访问可见 cells）
        view.addSubview(tufuh_tabV)
        tufuh_tabV.frame = view.bounds
        tufuh_tabV.register(VideoPlayerCell.self, forCellReuseIdentifier: VideoPlayerCell.identifier)
        tufuh_tabV.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUHHHTabVVDefCellId")
        tufuh_tabV.register(HomeSubContentCell1.self, forCellReuseIdentifier: "HomeSubContentCell1Id")
        tufuh_tabV.register(HomeSubContentCell2.self, forCellReuseIdentifier: "HomeSubContentCell2Id")
        tufuh_tabV.register(HomeSubContentCell3.self, forCellReuseIdentifier: "HomeSubContentCell3Id")
        tufuh_tabV.register(HomeSubContentCell4.self, forCellReuseIdentifier: "HomeSubContentCell4Id")

        tufuh_tabV.register(HomeSubContentCell7.self, forCellReuseIdentifier: "HomeSubContentCell7Id")
        tufuh_tabV.register(HomeSubContentCell8.self, forCellReuseIdentifier: "HomeSubContentCell8Id")
        
        // loading
//        view.addSubview(loadingView)
//        loadingView.center = view.center
//        loadingView.startAnimating()

        // 监听前后台恢复
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification, object: nil)
        //刷新页面
        NotificationCenter.default.addObserver(self, selector: #selector(refreshSubView),
                                               name: Notification.Name("TUOKOUXIURefreshSubView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toTop),
                                               name: Notification.Name("TUOKOUXIUToTop"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enterMainView),
                                               name: Notification.Name("TUOKOUXIUEnterMainView"), object: nil)

        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isEnterApp {
            let gaiV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H), superView: view, bgColor: .black)
            tufuh_gaiV = gaiV
            let gaiIV = UIImageView.tukou_bjImageV(CGRect(x: 24, y: 140, width: TUOKOUXIUSwiftSCRE_W-48, height: TUOKOUXIUSwiftSCRE_H-270), superView: gaiV, image: nil)
//            gaiIV.backgroundColor = .black
            gaiIV.layer.cornerRadius = 35
            gaiIV.layer.masksToBounds = true
            tufuh_gaiViamgeView = gaiIV
            
            let gaiLeftIV = UIImageView.tukou_bjImageV(CGRect(x: 24, y: TUOKOUXIUSwiftSCRE_H-270-150, width: 40, height: 40), superView: gaiIV, image: nil)
            tufuh_gaiIconIV = gaiLeftIV
            let gaiTitleL = UILabel.tukou_bjLabel(CGRect(x: gaiLeftIV.frame.maxX + 20, y: TUOKOUXIUSwiftSCRE_H-270-150, width: TUOKOUXIUSwiftSCRE_W-48-24-24-40-20, height: 40), text: "", superView: gaiIV, textAlignment: .left, font: TUOKOUXIUSwiftFont.semibold(24), textColor: .white)
            tufuh_gaiVtitleL = gaiTitleL
            let gaiContentL = UILabel.tukou_bjLabel(CGRect(x: 24, y: gaiLeftIV.frame.maxY+10, width: TUOKOUXIUSwiftSCRE_W-48-24-24, height: 70), text: "", superView: gaiIV, textAlignment: .left, font: TUOKOUXIUSwiftFont.regular(17), textColor: .white)
            tufuh_gaiVcontentL = gaiContentL
            gaiContentL.numberOfLines = 0
            if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray.count > 0 {
                refreshData()
            }
        }
    }
    
    @objc func toTop() {
        tufuh_tabV.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    @objc private func refreshData() {
        let model:SceneModel = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray[tufuh_num]
        let tufuh_ulrString = model.backgroundUrl
        let tufuh_titleString = model.displayCopyTitle
        let tufuh_contentString = model.displayCopy
        
        tufuh_gaiViamgeView?.kf.setImage(with: URL(string: tufuh_ulrString),
            options: [
            .requestModifier(ImageAuthModifier())
        ])
        let name = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_sortArray[TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_selectNum]
        tufuh_gaiIconIV?.image = UIImage(named: name.iconName)
        tufuh_gaiVtitleL?.text = tufuh_titleString
        tufuh_gaiVcontentL?.text = tufuh_contentString
    }
    
    @objc private func enterMainView() {
        tufuh_gaiV?.isHidden = true
        tufuh_gaiViamgeView?.removeFromSuperview()
        tufuh_gaiIconIV?.removeFromSuperview()
        tufuh_gaiVtitleL?.removeFromSuperview()
        tufuh_gaiVcontentL?.removeFromSuperview()
        tufuh_gaiV?.removeFromSuperview()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.player?.currentItem?.status == .readyToPlay {
                if isFirstCellVisible {
                    self.playerView.play()
                }
            }
        }
    }
    
    @objc private func refreshSubView() {
        let firstIndexPath = IndexPath(row: 0, section: 1)
        let secondIndexPath = IndexPath(row: 1, section: 1)
        let indexPathsToReload = [firstIndexPath, secondIndexPath]

        // 3. 在主线程中执行UI刷新
        DispatchQueue.main.async {
            // 使用 .automatic 动画可以让系统选择最合适的过渡效果
            self.tufuh_tabV.reloadRows(at: indexPathsToReload, with: .automatic)
        }
    }
    
    // MARK: - 尝试初始化播放器（兜底）
    private func trySetupPlayerIfNeeded() {

        // 防止重复初始化
        if isPlayerSetup { return }

        // 确保 table 已经在 window 上（否则依然会白屏）
        guard view.window != nil else { return }

        // 尝试找到第一个 cell
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = tufuh_tabV.cellForRow(at: indexPath) as? VideoPlayerCell else { return }

        // 触发真正的播放器加载
        setupPlayerInCell(cell: cell)

        isPlayerSetup = true
    }

    deinit {
        // 移除通知 & KVO & cleanup
        NotificationCenter.default.removeObserver(self)
        playerView.cleanup()
    }

    func numberOfSections(in tableView: UITableView) -> Int { 2 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 6
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return TUOKOUXIUSwiftSCRE_H
        } else {
            if indexPath.row == 0 {
                if self.detailModel?.meta != nil, self.detailModel?.introductions != nil {
                    let introductions = self.detailModel?.introductions ?? ""
                    
                    let height = TUOKOUXIUSSStringUtils.tukou_textSize(text: introductions, font: TUOKOUXIUSwiftFont.regular(18), maxSize: CGSize(width: TUOKOUXIUSwiftSCRE_W - 48, height: .greatestFiniteMagnitude) ,lineSpacing: 10).height
                    if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isOpenHomeMusicExpand {
                        return 164 + height + 10
                    }
                    return 194 + height + 10
                } else {
                    return 0.01
                }
            } else if indexPath.row == 1 {
                if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isOpenHomeMusicExpand {
                    return 0.01
                }
                if let explpreArray = self.detailModel?.explore, explpreArray.count > 0 {
                    return 185 * TUOKOUXIUDeviceInfo.scaleX + 28 + 32 + 16
                } else {
                    return 0.01
                }
            } else if indexPath.row == 2 {
                if let bannersArray = self.detailModel?.banners, bannersArray.count > 0 {
                    return 320 * TUOKOUXIUDeviceInfo.scaleX + 32
                } else {
                    return 0.01
                }
            } else if indexPath.row == 3 {
                if let principles = self.detailModel?.acousticTech?.principles, principles.count > 0 {
                    let pri: AcousticSection = principles[0]
                    let itemsArray:[AcousticItem] = pri.items
                    var tagH = 0
                    var desH = 0
                    for item in itemsArray {
                        let itemStr = item.description
                        tagH = tagH + 40
                        let height = TUOKOUXIUSSStringUtils.tukou_textSize(text:
                            itemStr,
                            font: TUOKOUXIUSwiftFont.regular(14),
                            maxSize: CGSize(width: TUOKOUXIUSwiftSCRE_W - 48, height: .greatestFiniteMagnitude), lineSpacing: 6
                        ).height
                        desH = desH + Int(height) + 10
                    }
                    return CGFloat(16 + 24 + tagH + desH + 15)
                } else {
                    return 0.01
                }
            } else if indexPath.row == 4 {
                if let instruments = self.detailModel?.acousticTech?.instruments, instruments.count > 0 {
                    let aco: AcousticSection = instruments[0]
                    let itemsArray:[AcousticItem] = aco.items
                    var desH = 0
                    for item in itemsArray {
                        let nameStr = item.name ?? ""
                        let width = TUOKOUXIUSSStringUtils.tukou_sizWithT(
                            nameStr,
                            font: TUOKOUXIUSwiftFont.semibold(14),
                            maxSize: CGSize(width: TUOKOUXIUSwiftSCRE_W, height: 24)
                        ).width
                        let itemStr = item.description
                        
                        let height = TUOKOUXIUSSStringUtils.tukou_textSize(text:
                            itemStr,
                            font: TUOKOUXIUSwiftFont.regular(14),
                            maxSize: CGSize(width: TUOKOUXIUSwiftSCRE_W - width - 48 - 34, height: .greatestFiniteMagnitude), lineSpacing: 6
                        ).height
                        desH = desH + Int(height) + 10
                    }
                    return CGFloat(40 + 10 + desH + 12)
                } else {
                    return 0.01
                }
            } else if indexPath.row == 5 {
                if let socialProofs = self.detailModel?.socialProofs, socialProofs.count > 0 {
                    return 16 + 16 + 134
                } else {
                    return 0.01
                }
            }
        }
        return 0.01
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView(frame: .init(x: 0,y: 0,width: TUOKOUXIUSwiftSCRE_W,height: 0.01))
        v.backgroundColor = TUOKOUXIUSwiftheiseC
        return v
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 0.01 }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { section == 0 ? 0.01 : 100.0 }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let h = section == 0 ? 0.01 : 100.0
        let v = UIView(frame: .init(x: 0,y: 0,width: TUOKOUXIUSwiftSCRE_W,height: h))
        v.backgroundColor = TUOKOUXIUSwiftheiseC
        return v
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: VideoPlayerCell.identifier, for: indexPath) as! VideoPlayerCell
            // 当 cell layout 完成后回调 setupPlayerInCell（避免 table 在未 attach 时就 layout）
            cell.onReadyForPlayer = { [weak self, weak cell] in
                guard let self = self, let cell = cell else { return }
                if let urlString = self.detailModel?.videoCoverUrl, let url = URL(string: urlString) {
                    cell.containerIV.kf.setImage(with: url, options: [.transition(.fade(0.3)), .requestModifier(ImageAuthModifier())])
                }
                // 确保仅执行一次（VideoPlayerCell 内部也保证只回调一次）
                self.setupPlayerInCell(cell: cell)
            }
            return cell
        } else {
            if indexPath.row == 0 {
                if let meta = self.detailModel?.meta, let introductions = self.detailModel?.introductions {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell1Id", for: indexPath) as! HomeSubContentCell1
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                    
                    cell.tukou_resModel(meta: meta, introductions: introductions)
                    
                    cell.tukou_refresh()
                    return cell
                } else {
                    let cell = UITableViewCell()
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                    return cell
                }
            } else if indexPath.row == 1 {
                if let explpreArray = self.detailModel?.explore, explpreArray.count > 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell2Id", for: indexPath) as! HomeSubContentCell2
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                    
                    cell.tukou_resModel(explpreArray: explpreArray)
                    
                    cell.tukou_refresh()
                    cell.TUOKOUXIUHomeClkItemBlk = { model in
                        self.toTop()
                        self.clickCellLoadDetail(model.musicUuid)
                    }
                    return cell
                } else {
                    let cell = UITableViewCell()
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                    return cell
                }
            } else if indexPath.row == 2 {
                if let bannersArray = self.detailModel?.banners, bannersArray.count > 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell3Id", for: indexPath) as! HomeSubContentCell3
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                    
                    cell.tukou_resModel(banners: bannersArray)
                    
                    return cell
                } else {
                    let cell = UITableViewCell()
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                    return cell
                }
            } else if indexPath.row == 3 {
                if let principles = self.detailModel?.acousticTech?.principles, principles.count > 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell4Id", for: indexPath) as! HomeSubContentCell4
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                    cell.tukou_resModel(tufuh_principlesArray: principles)
                    return cell
                } else {
                    let cell = UITableViewCell()
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                    return cell
                }
            } else if indexPath.row == 4 {
                if let instruments = self.detailModel?.acousticTech?.instruments, instruments.count > 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell7Id", for: indexPath) as! HomeSubContentCell7
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                
                    cell.tukou_resModel(tufuh_instrumentsArray: instruments)
                
                    return cell
                } else {
                    let cell = UITableViewCell()
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                    return cell
                }
            } else {
                if let socialProofs = self.detailModel?.socialProofs, socialProofs.count > 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell8Id", for: indexPath) as! HomeSubContentCell8
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                
                    cell.tukou_resModel(tufuh_socialProofsArray: socialProofs)
                
                    return cell
                } else {
                    let cell = UITableViewCell()
                    cell.backgroundColor = TUOKOUXIUSwiftheiseC
                    return cell
                }
            }
        }
    }
    
    private func clickCellLoadDetail(_ url: String) {
        Task {
            self.detailModel = await AuthService.getMusicDetail(Uuid: url)
            
            print("✅ 点击cell加载详情 获取成功")
            self.videoURL = URL(string: self.detailModel?.videoFileUrl ?? "")
            if let urlStrings = self.detailModel?.musicFileUrl, !urlStrings.isEmpty {
                let urls = makeURLs(from: urlStrings)
                AudioPlayerManager.shared.playAudios(with: urls)
            }
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_metaInfo = self.detailModel?.meta
            tufuh_tabV.reloadData()
            TUOKOUXIUSwiftDelaBlk(0.1) {
                NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUEnterDetailView"), object: nil)
            }
//            playerView.refreshLayer()
            self.playerView.play()
        }
    }

    // MARK: - 滚动控制（顶部 progress + 第一个 cell 可见性控制播放/暂停）
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == self.tufuh_tabV else { return }
        let offsetY = self.tufuh_tabV.contentOffset.y
        let progress = min(max(offsetY / 80.0, 0), 1)
        NotificationCenter.default.post(name: NSNotification.Name("TUOKOUXIUUpdaWScroll"), object: nil,
                                        userInfo: ["progress": progress])

        // 1️⃣ 第一个 cell 不可见 → 直接 pause
        guard isFirstCellVisible else {
            playerView.pause()
            return
        }
        // 2️⃣ 可见，但 item 还没 ready → 等待（保持 loading）
//        guard player?.currentItem?.status == .readyToPlay else {
            // 若还没 ready，保持 loading 状态
//          loadingView.startAnimating()
//            return
//        }
        // 3️⃣ 可见 + ready → play
        playerView.play()
    }

    // MARK: - 核心：在 cell 完成 layout 后才 attach player 并创建 item
    private func setupPlayerInCell(cell: VideoPlayerCell) {
        guard (videoURL != nil) else { return }
        // 防止重复 setup
        guard !didSetupPlayerInCell else { return }
        didSetupPlayerInCell = true

        // 1. 把 playerView attach 到 cell 的容器（此时 cell 已 layout 且在 view 层级）
        if playerView.superview != cell.containerView {
            playerView.removeFromSuperview()
            playerView.frame = cell.containerView.bounds
            playerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            cell.containerView.addSubview(playerView)
        }

        // 2. 开始创建 AVPlayerItem & AVPlayer（注意：不要先调用 play，等 status ready 后再 play）
        // 显示 loading（如果还在 loading）
//        loadingView.startAnimating()
        
        videoPlayInit(newVideoURL: videoURL!)
        
        // 让 layer 的显示属性设置正确
        playerView.configure()
        playerView.refreshLayer()
    }
    
    private func videoPlayInit(newVideoURL: URL) {
        let newItem = urlAddToken(url: newVideoURL)

        // 3️⃣ 监听 status（自动释放，不会崩）
        statusObservation = newItem.observe(\.status, options: [.initial, .new]) { [weak self] item, _ in
            guard let self else { return }

            DispatchQueue.main.async {
                switch item.status {
                case .readyToPlay:
                    if self.isFirstCellVisible {
                        self.playerView.play()
                    }
                case .failed:
                    // 播放失败也要隐藏 loading，并可以做重试逻辑
//                    self.loadingView.stopAnimating()
                    // 可选：显示错误 UI / 重试按钮
                    break
                default:
                    break
                }
            }
        }

        // 4️⃣ 创建或替换 player
        if player == nil {
            player = AVPlayer(playerItem: newItem)
            player?.isMuted = true
            playerView.setPlayer(player)
        } else {
            player?.replaceCurrentItem(with: newItem)
        }
        // 只监听当前 video item
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidPlayToEnd(_:)),
            name: .AVPlayerItemDidPlayToEndTime,
            object: newItem
        )
    }
    
    @objc private func playerDidPlayToEnd(_ notification: Notification) {
        guard let finishedItem = notification.object as? AVPlayerItem else { return }
        // 再判断一次是否可见
        guard self.isFirstCellVisible else { return }
        // 回到起点
        if finishedItem == player?.currentItem {
            playerView.refreshLayer()
            player?.seek(to: .zero)
            self.playerView.play()
        }
    }

    // MARK: - KVO 回调（仅监听 item.status）
    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "status", let item = object as? AVPlayerItem else { return }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if item.status == .readyToPlay {
                // item ready → 停止 loading 并播放（仅在 cell 可见时播放）
//                self.loadingView.stopAnimating()
                // 只有当第一个 cell 可见时才自动播放，避免在不可见时开始播放
                if self.isFirstCellVisible {
                    self.playerView.play()
                }
            } else if item.status == .failed {
                // 播放失败也要隐藏 loading，并可以做重试逻辑
//                self.loadingView.stopAnimating()
                // 可选：显示错误 UI / 重试按钮
            }
        }
    }

    // MARK: - 回前台恢复
    @objc private func appDidBecomeActive() {
//        queuePlayer?.play()
        playerView.refreshLayer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) { [weak self] in
            guard let self = self else { return }
            guard self.player?.currentItem?.status == .readyToPlay else {
//                 self.loadingView.startAnimating()
                return
            }
            // 仅在第一个 cell 可见时恢复播放
            if self.isFirstCellVisible {
                self.playerView.play()
            }
        }
    }

    // MARK: - 供外部调用：手动销毁播放器（如果父 VC 切走并想释放）
    func destroyPlayer() {
//        queuePlayer?.pause()
        playerView.cleanup()
        player = nil
        didSetupPlayerInCell = false
    }
}

extension HomeSubVC {
    var isFirstCellVisible: Bool {
        let indexPath = IndexPath(row: 0, section: 0)

        guard let cell = tufuh_tabV.cellForRow(at: indexPath) else {
            return false
        }

        let cellFrame = tufuh_tabV.convert(cell.frame, to: view)

        return !(cellFrame.maxY < 0 || cellFrame.minY > view.bounds.height)
    }
}
