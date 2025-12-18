
import UIKit
import AVFoundation
import Kingfisher

class HomeSubVC: TUOKOUXIUSwiftBaseVC, UITableViewDelegate, UITableViewDataSource {
    private var isPlayerSetup = false
    var tufuh_num: Int = 0
    
    // MARK: - 公共/UI
    private let playerView = VideoPlayerView()           // 只创建一次
    private let loadingView: UIActivityIndicatorView = {
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
    
    func playAudio(with url: URL) {
        let item = AVPlayerItem(url: url)

        if audioPlayer == nil {
            audioPlayer = AVPlayer(playerItem: item)
        } else {
            audioPlayer?.replaceCurrentItem(with: item)
        }

        audioPlayer?.volume = 1.0
        audioPlayer?.play()
    }
    
    func stopAudio() {
        audioPlayer?.pause()
        audioPlayer = nil
    }

    // MARK: - 播放器状态
    let videoURL: URL?               // 当前子控制器视频 URL（初始化注入）
    //音频
    private var audioPlayer: AVPlayer?
    let audioURL: URL?
    var player: AVPlayer?          // AVPlayer 类属性（可复用或替换 item）
    private var observedItem: AVPlayerItem? // 当前正在监听的 item（用于安全移除 KVO）
    var tufuh_gaiV: UIView?
    var tufuh_gaiViamgeView: UIImageView?
    var tufuh_gaiVtitleL: UILabel?
    var tufuh_gaiVcontentL: UILabel?
    // 标志，表示是否已经在 cell 上UILabel化了播放器（避免重复）
    private var didSetupPlayerInCell = false

    // MARK: - 生命周期
    init(videoURL: URL, audioURL: URL) {
        self.videoURL = videoURL
        self.audioURL = audioURL
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        // 1) 先创建 tableView（不要在 viewDidLoad 中触发 cell 的 layout 或 访问可见 cells）
        view.addSubview(tufuh_tabV)
        tufuh_tabV.frame = view.bounds
        tufuh_tabV.register(VideoPlayerCell.self, forCellReuseIdentifier: VideoPlayerCell.identifier)
        tufuh_tabV.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUHHHTabVVDefCellId")
        tufuh_tabV.register(HomeSubContentCell1.self, forCellReuseIdentifier: "HomeSubContentCell1Id")
        tufuh_tabV.register(HomeSubContentCell2.self, forCellReuseIdentifier: "HomeSubContentCell2Id")
        tufuh_tabV.register(HomeSubContentCell3.self, forCellReuseIdentifier: "HomeSubContentCell3Id")
        tufuh_tabV.register(HomeSubContentCell4.self, forCellReuseIdentifier: "HomeSubContentCell4Id")
        tufuh_tabV.register(HomeSubContentCell5.self, forCellReuseIdentifier: "HomeSubContentCell5Id")
        tufuh_tabV.register(HomeSubContentCell6.self, forCellReuseIdentifier: "HomeSubContentCell6Id")
        tufuh_tabV.register(HomeSubContentCell7.self, forCellReuseIdentifier: "HomeSubContentCell7Id")
        tufuh_tabV.register(HomeSubContentCell8.self, forCellReuseIdentifier: "HomeSubContentCell8Id")
        
        // loading
        view.addSubview(loadingView)
        loadingView.center = view.center
        loadingView.startAnimating()
        
//        if (self.audioURL != nil) {
//            playAudio(with: self.audioURL)
//        }

        // 监听前后台恢复
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioPause),
                                               name: Notification.Name("TUOKOUXIUAudioPause"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(audioPlay),
                                               name: Notification.Name("TUOKOUXIUAudioPlay"), object: nil)
        //刷新页面
        NotificationCenter.default.addObserver(self, selector: #selector(refreshSubView),
                                               name: Notification.Name("TUOKOUXIURefreshSubView"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(enterMainView),
                                               name: Notification.Name("TUOKOUXIUEnterMainView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData),
                                               name: Notification.Name("TUOKOUXIURefreshData"), object: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
            if let audioURL = self.audioURL {
                playAudio(with: audioURL)
            }
        }
        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isEnterApp {
            let gaiV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H), superView: view, bgColor: .black)
            tufuh_gaiV = gaiV
            let gaiIV = UIImageView.tukou_bjImageV(CGRect(x: 24, y: 140, width: TUOKOUXIUSwiftSCRE_W-48, height: TUOKOUXIUSwiftSCRE_H-270), superView: gaiV, image: nil)
//            gaiIV.backgroundColor = .black
            gaiIV.layer.cornerRadius = 35
            gaiIV.layer.masksToBounds = true
            tufuh_gaiViamgeView = gaiIV
            
            let gaiLeftIV = UIImageView.tukou_bjImageV(CGRect(x: 24, y: TUOKOUXIUSwiftSCRE_H-270-150, width: 40, height: 40), superView: gaiIV, image: UIImage(named: "sleep"))
            let gaiTitleL = UILabel.tukou_bjLabel(CGRect(x: gaiLeftIV.frame.maxX + 20, y: TUOKOUXIUSwiftSCRE_H-270-150, width: TUOKOUXIUSwiftSCRE_W-48-24-24-40-20, height: 40), text: "", superView: gaiIV, textAlignment: .left, font: TUOKOUXIUSwiftFont.semibold(24), textColor: .white)
            tufuh_gaiVtitleL = gaiTitleL
            let gaiContentL = UILabel.tukou_bjLabel(CGRect(x: 24, y: gaiLeftIV.frame.maxY+10, width: TUOKOUXIUSwiftSCRE_W-48-24-24, height: 70), text: "", superView: gaiIV, textAlignment: .left, font: TUOKOUXIUSwiftFont.regular(17), textColor: .white)
            tufuh_gaiVcontentL = gaiContentL
            gaiContentL.numberOfLines = 0
        }
    }
    
    @objc private func refreshData() {
        let model:SceneModel = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_homeArray[tufuh_num]
        let tufuh_ulrString = model.backgroundUrl
        let tufuh_titleString = model.displayCopyTitle
        let tufuh_contentString = model.displayCopy
        tufuh_gaiViamgeView?.kf.setImage(with: URL(string: tufuh_ulrString))
        tufuh_gaiVtitleL?.text = tufuh_titleString
        tufuh_gaiVcontentL?.text = tufuh_contentString
    }
    
    @objc private func enterMainView() {
        tufuh_gaiV?.isHidden = true
        tufuh_gaiViamgeView?.removeFromSuperview()
        tufuh_gaiVtitleL?.removeFromSuperview()
        tufuh_gaiVcontentL?.removeFromSuperview()
        tufuh_gaiV?.removeFromSuperview()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.player?.currentItem?.status == .readyToPlay {
                self.playerView.play()
            }
        }
    }
    
    @objc private func refreshSubView() {
//        tufuh_tabV.reloadData()
        let firstIndexPath = IndexPath(row: 0, section: 1)
        let secondIndexPath = IndexPath(row: 1, section: 1)
        let indexPathsToReload = [firstIndexPath, secondIndexPath]

        // 3. 在主线程中执行UI刷新
        DispatchQueue.main.async {
            // 使用 .automatic 动画可以让系统选择最合适的过渡效果
            self.tufuh_tabV.reloadRows(at: indexPathsToReload, with: .automatic)
        }
    }
    
    @objc private func audioPause() {
        audioPlayer?.pause()
    }
    
    @objc private func audioPlay() {
        audioPlayer?.play()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // view 已经 attach 到 window，此时如果 cell 已经 layout，会触发 VideoPlayerCell.onReadyForPlayer -> setupPlayerInCell
        // 如果第一次还没在 cell 上初始化，我们在这里再次尝试（兜底）
        trySetupPlayerIfNeeded()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 当页面返回时，如果播放器已有 item 且 ready，则恢复播放（scroll 控制会判断是否可见）
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.player?.currentItem?.status == .readyToPlay {
                self.playerView.play()
            }
        }
//        audioPlayer?.play()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 暂停并保留 item（如果你希望切走时销毁，可以调用 cleanup()）
        playerView.pause()
//        audioPlayer?.pause()
    }

    deinit {
        // 移除通知 & KVO & cleanup
        NotificationCenter.default.removeObserver(self)
        removeObserverFromCurrentItem()
        playerView.cleanup()
    }

    // MARK: - tableView 数据源/代理
    func numberOfSections(in tableView: UITableView) -> Int { 2 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 8
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return TUOKOUXIUSwiftSCRE_H
        } else {
            if indexPath.row == 0 {
                if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isOpenHomeMusicExpand {
                    return 388
                }
                return 418  //content 224
            } else if indexPath.row == 1 {
                if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_isOpenHomeMusicExpand {
                    return 0.01
                }
                return 185 * TUOKOUXIUDeviceInfo.scaleX + 28 + 32 + 16
            } else if indexPath.row == 2 {
                return 320 * TUOKOUXIUDeviceInfo.scaleX + 32
            } else if indexPath.row == 3 {
                return 16 + 24 + 10 + 20 + 80 + 20 //content 80
            } else if indexPath.row == 4 {
                return 10 + 20 + 10 + 120 //content 120
            } else if indexPath.row == 5 {
                return 10 + 20 + 10 + 80  //content 80
            } else if indexPath.row == 6 {
                return 16 + 24 + 10 + 262 + 12 //content 262
            } else if indexPath.row == 7 {
                return 16 + 16 + 134
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
                // 确保仅执行一次（VideoPlayerCell 内部也保证只回调一次）
                self.setupPlayerInCell(cell: cell)
            }
            return cell
        } else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell1Id", for: indexPath) as! HomeSubContentCell1
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                cell.tukou_refresh()
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell2Id", for: indexPath) as! HomeSubContentCell2
                cell.tukou_refresh()
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell3Id", for: indexPath) as! HomeSubContentCell3
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell4Id", for: indexPath) as! HomeSubContentCell4
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                return cell
            } else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell5Id", for: indexPath) as! HomeSubContentCell5
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                return cell
            } else if indexPath.row == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell6Id", for: indexPath) as! HomeSubContentCell6
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                return cell
            } else if indexPath.row == 6 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell7Id", for: indexPath) as! HomeSubContentCell7
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell8Id", for: indexPath) as! HomeSubContentCell8
                cell.backgroundColor = TUOKOUXIUSwiftheiseC
                return cell
            }
        }
    }

    // MARK: - 滚动控制（顶部 progress + 第一个 cell 可见性控制播放/暂停）
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == self.tufuh_tabV else { return }
        let offsetY = self.tufuh_tabV.contentOffset.y
        let progress = min(max(offsetY / 80.0, 0), 1)
        NotificationCenter.default.post(name: NSNotification.Name("TUOKOUXIUUpdaWScroll"), object: nil,
                                        userInfo: ["progress": progress])

        // 控制第一个 cell 的播放/暂停（只控制 play/pause，不做 item 切换）
        if let firstCell = tufuh_tabV.cellForRow(at: IndexPath(row: 0, section: 0)) as? VideoPlayerCell {
            let cellFrame = tufuh_tabV.convert(firstCell.frame, to: view)
            if cellFrame.maxY < 0 || cellFrame.minY > view.bounds.height {
                playerView.pause()
            } else {
                // 只有 item ready 时才 play
                if player?.currentItem?.status == .readyToPlay {
                    playerView.play()
                } else {
                    // 若还没 ready，保持 loading 状态
                    loadingView.startAnimating()
                }
            }
        }
    }

    // MARK: - 核心：在 cell 完成 layout 后才 attach player 并创建 item
    private func setupPlayerInCell(cell: VideoPlayerCell) {
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
        loadingView.startAnimating()

        // 移除对旧 item 的观察（如果有）
        removeObserverFromCurrentItem()

        // 创建新的 item 并监听 status
        let item = AVPlayerItem(url: videoURL!)
        observedItem = item
        item.addObserver(self, forKeyPath: "status", options: [.new, .initial], context: nil)

        // 创建或替换 player
        if player == nil {
            player = AVPlayer(playerItem: item)
            player?.isMuted = true
            playerView.setPlayer(player)
        } else {
            // 替换 currentItem（player 已存在）
            player?.replaceCurrentItem(with: item)
            // 确保 playerView 的 player 引用正确
            if playerView.player !== player {
                playerView.setPlayer(player)
            }
        }
        // 让 layer 的显示属性设置正确
        playerView.configure(url: videoURL!)
        playerView.refreshLayer()
    }

    // MARK: - 切换视频（外部调用，例如父 VC 切分页时）
    func playNewVideo(_ newVideoURL: URL) {
        // 当需要切换到新 URL 时：
        // 1. 暂停当前播放
        playerView.pause()
        loadingView.startAnimating()

        // 2. 移除旧 item observer
        removeObserverFromCurrentItem()

        // 3. 创建新 item 并替换
        let newItem = AVPlayerItem(url: newVideoURL)
        observedItem = newItem
        newItem.addObserver(self, forKeyPath: "status", options: [.new, .initial], context: nil)

        if player == nil {
            player = AVPlayer(playerItem: newItem)
            player?.isMuted = true
            playerView.setPlayer(player)
        } else {
            player?.replaceCurrentItem(with: newItem)
            if playerView.player !== player { playerView.setPlayer(player) }
        }

        // 确保 playerView 在第一个 cell 上（如果 cell 已经在屏幕上）
        if let firstCell = tufuh_tabV.cellForRow(at: IndexPath(row: 0, section: 0)) as? VideoPlayerCell {
            if playerView.superview != firstCell.containerView {
                playerView.removeFromSuperview()
                playerView.frame = firstCell.containerView.bounds
                playerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                firstCell.containerView.addSubview(playerView)
            }
        }
        playAudio(with: audioURL!)
        // 切换后等待 status == .readyToPlay 的 KVO 回调触发播放（observeValue 中处理）
    }

    // MARK: - KVO 回调（仅监听 item.status）
    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "status", let item = object as? AVPlayerItem else { return }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if item.status == .readyToPlay {
                // item ready → 停止 loading 并播放（仅在 cell 可见时播放）
                self.loadingView.stopAnimating()
                // 只有当第一个 cell 可见时才自动播放，避免在不可见时开始播放
                if let firstCell = self.tufuh_tabV.cellForRow(at: IndexPath(row: 0, section: 0)) as? VideoPlayerCell {
                    let cellFrame = self.tufuh_tabV.convert(firstCell.frame, to: self.view)
                    if !(cellFrame.maxY < 0 || cellFrame.minY > self.view.bounds.height) {
                        self.playerView.play()
                    }
                }
            } else if item.status == .failed {
                // 播放失败也要隐藏 loading，并可以做重试逻辑
                self.loadingView.stopAnimating()
                // 可选：显示错误 UI / 重试按钮
            }
        }
    }

    // MARK: - helper: 移除旧 item 的 KVO
    private func removeObserverFromCurrentItem() {
        if let item = observedItem {
            // 安全移除（避免重复移除导致崩溃）
            if item.observationInfo != nil {
                // 使用 try/catch 避免重复移除异常
                do {
                    item.removeObserver(self, forKeyPath: "status")
                } catch {
                    // 已移除或不存在，不处理
                }
            }
            observedItem = nil
        }
    }

    // MARK: - 回前台恢复
    @objc private func appDidBecomeActive() {
//        audioPlayer?.play()
        playerView.refreshLayer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) { [weak self] in
            guard let self = self else { return }
            if self.player?.currentItem?.status == .readyToPlay {
                // 仅在第一个 cell 可见时恢复播放
                if let firstCell = self.tufuh_tabV.cellForRow(at: IndexPath(row: 0, section: 0)) as? VideoPlayerCell {
                    let cellFrame = self.tufuh_tabV.convert(firstCell.frame, to: self.view)
                    if !(cellFrame.maxY < 0 || cellFrame.minY > self.view.bounds.height) {
                        self.playerView.play()
                    }
                }
            } else {
                self.loadingView.startAnimating()
            }
        }
    }

    // MARK: - 供外部调用：手动销毁播放器（如果父 VC 切走并想释放）
    func destroyPlayer() {
        playerView.pause()
        audioPlayer?.pause()
        removeObserverFromCurrentItem()
        playerView.cleanup()
        player = nil
        didSetupPlayerInCell = false
    }
}
