
import UIKit
import Foundation
import IQKeyboardManagerSwift
import Combine
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var launchWindow: UIWindow?       // ⭐️ 启动动画 window
    private var cancellables = Set<AnyCancellable>()
    var tufuh_souT: DispatchSourceTimer?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // 音频后台播放设置
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AudioSession 初始化失败: \(error)")
        }

        // 网络监听注册
        TUOKOUXIUSwiftNetUt.tukou_regObsNetSta()

        // 键盘管理
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false

        // 🚀 判断双 Token 是否存在
        let hasToken = TokenStorage.shared.accessToken != nil &&
                       TokenStorage.shared.refreshToken != nil

        if hasToken {
            // ✅ 已登录用户 → 启动动画后进入主界面
            showLaunchAnimationWindow(enterMain: true)
        } else {
            // ❌ 未登录用户 → 启动动画后进入登录页
            showLaunchAnimationWindow(enterMain: false)
        }

        return true
    }

    // MARK: - 启动动画
    func showLaunchAnimationWindow(enterMain: Bool) {
        let launchVC = SplashViewController()
        let lw = UIWindow(frame: UIScreen.main.bounds)
        lw.windowLevel = .alert + 1
        lw.rootViewController = launchVC
        lw.makeKeyAndVisible()
        self.launchWindow = lw

        // 启动动画完成回调
        launchVC.onFinished = { [weak self] in
            guard let self = self else { return }

            UIView.animate(withDuration: 0.35, animations: {
                lw.alpha = 0
            }, completion: { _ in
                self.launchWindow = nil

                // ✅ 动画结束后跳转逻辑
                if enterMain {
                    self.tukou_enter()
                } else {
                    self.showLoginPage()
                }
            })
        }
    }

    // MARK: - 登录页
    func showLoginPage() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white

        let loginVC = LoginViewController()
        loginVC.onLoginSuccess = { [weak self] in
            self?.tukou_enter()
        }

        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()
    }

    // MARK: - 主界面
    func tukou_enter() {
//        _ = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL
        window = UIWindow(frame: UIScreen.main.bounds)

        let tufuh_tabBaVC = TUOKOUXIUSwiftTBar()

        let homeVC = HomeMainVC()
        let homeNav = TUOKOUXIUSwiftBaNavC(rootViewController: homeVC)
        homeNav.navigationBar.isHidden = true

        let tufuh_tarVC2 = TUOKOUXIUExploreVC()
        let tufuh_tsNav = TUOKOUXIUSwiftBaNavC(rootViewController: tufuh_tarVC2)
        tufuh_tsNav.navigationBar.isHidden = true

        let myVC = TUOKOUXIUSwiftMy()
        let myNav = TUOKOUXIUSwiftBaNavC(rootViewController: myVC)
        myNav.navigationBar.isHidden = true

        tufuh_tabBaVC.tufuh_tabbVCArr = [tufuh_tsNav, homeNav, myNav]
        window?.rootViewController = tufuh_tabBaVC
        window?.makeKeyAndVisible()
    }

    // MARK: - 生命周期相关（保留原逻辑）
    func tukou_entBackG() {
        tufuh_souT?.cancel()
    }

    private func tukou_entForegr() {
        tufuh_souT?.cancel()
        self.fuhan_creaDispT()
    }

    func fuhan_creaDispT() {
        let queue = DispatchQueue.global(qos: .default)
        tufuh_souT = DispatchSource.makeTimerSource(queue: queue)
        let startDelay = DispatchTime.now() + 1.0
        tufuh_souT?.schedule(deadline: startDelay, repeating: 1.0, leeway: .milliseconds(100))
        tufuh_souT?.setEventHandler { [weak self] in
            self?.tukou_lunxunJK()
        }
        tufuh_souT?.resume()
    }

    func tukou_lunxunJK() {
        if TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0 {
            tufuh_souT?.cancel()
            NotificationCenter.default.removeObserver(self)
            DispatchQueue.main.async {
                self.tukou_enter()
            }
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
//        TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_guanBShuJ()
    }
}
