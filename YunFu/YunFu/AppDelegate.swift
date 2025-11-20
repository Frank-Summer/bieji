
import UIKit
import Foundation
import IQKeyboardManagerSwift
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    private var cancellables = Set<AnyCancellable>()

    var tufuh_souT: DispatchSourceTimer?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        TUOKOUXIUSwiftNetUt.tukou_regObsNetSta()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        if (TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0) {

                self.tukou_enter()
                return true

        } else {
            NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
                .sink { [weak self] _ in self?.tukou_entBackG() }
                .store(in: &cancellables)

            NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
                .sink { [weak self] _ in self?.tukou_entForegr() }
                .store(in: &cancellables)

            self.fuhan_creaDispT()
        }

        return true
    }

    func tukou_entBackG() {
        if let souT = self.tufuh_souT {
            souT.cancel()
        }
    }

    private func tukou_entForegr() {
        if let souT = self.tufuh_souT {
            souT.cancel()
        }
        if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_xkgDict != nil {
            NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
            return
        }

        self.fuhan_creaDispT()
    }

    func fuhan_creaDispT() {
        let queue = DispatchQueue.global(qos: .default)
        self.tufuh_souT = DispatchSource.makeTimerSource(queue: queue)
        let startDelay = DispatchTime.now() + 1.0
        self.tufuh_souT?.schedule(deadline: startDelay, repeating: 1.0, leeway: .milliseconds(100))
        self.tufuh_souT?.setEventHandler { [weak self] in
            self?.tukou_lunxunJK()
        }
        self.tufuh_souT?.resume()
    }

    func tukou_lunxunJK() {
        if (TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0) {
            if let souT = self.tufuh_souT {
                souT.cancel()
            }

            NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
            if Thread.isMainThread {
                self.tukou_lunxunJK2()
            } else {
                DispatchQueue.main.async {
                    self.tukou_lunxunJK2()
                }
            }
        }
    }
    func tukou_lunxunJK2() {
        self.tukou_enter()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_guanBShuJ()
    }
    func tukou_enter() {

        _ = TUOKOUXIUSwiftShuJCC.tukou_shuJuDL
        window = UIWindow(frame: UIScreen.main.bounds)

        let tufuh_tabBaVC = TUOKOUXIUSwiftTBar()

        let tufuh_tarVC1 = TUOKOUXIUSwiftHHHVC()
        let tufuh_homeNav = TUOKOUXIUSwiftBaNavC(rootViewController: tufuh_tarVC1)
        tufuh_homeNav.navigationBar.isHidden = true

        let tufuh_tarVC2 = TUOKOUXIUSwiftTTSSVC()
        let tufuh_tsNav = TUOKOUXIUSwiftBaNavC(rootViewController: tufuh_tarVC2)
        tufuh_tsNav.navigationBar.isHidden = true

        let tufuh_tarVC4 = TUOKOUXIUSwiftSSZVC()
        let tufuh_myNav = TUOKOUXIUSwiftBaNavC(rootViewController: tufuh_tarVC4)
        tufuh_myNav.navigationBar.isHidden = true

        tufuh_tabBaVC.tufuh_tabbVCArr = [tufuh_homeNav, tufuh_tsNav, tufuh_myNav]

        tufuh_tabBaVC.tukou_setTabBTitArr(
            ["Home", "Explore", "Me"],
            texClr: UIColor.TUOKOUXIUSSRGB(r: 144, g: 147, b: 153),
            selTexClr: TUOKOUXIUSwiftbaiseC,
            barBgClr: UIColor.TUOKOUXIUSSRGBA(r: 51, g: 51, b: 51, a: 0.86)
        )

        window?.rootViewController = tufuh_tabBaVC
        window?.makeKeyAndVisible()
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}
