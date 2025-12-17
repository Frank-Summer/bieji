import Foundation
import AuthenticationServices
import GoogleSignIn
import UIKit

final class LoginViewModel: NSObject {

    // MARK: - 回调
    var onLoginSuccess: ((LoginUser) -> Void)?
    var onLoginError: ((String) -> Void)?

    // MARK: - Apple 登录
    func startAppleLogin(from view: UIView) {
        print("🍎 开始 Apple 登录流程")

        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    // MARK: - Google 登录
    func startGoogleLogin(from rootVC: UIViewController) {
        print("🔍 开始 Google 登录流程")

        let clientID = "205971285604-7p5872iacnfm1ic4v4328a6jv52g1o3k.apps.googleusercontent.com"
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { [weak self] result, error in
            guard let self = self else { return }

            if let error = error {
                self.onLoginError?("Google 登录失败：\(error.localizedDescription)")
                return
            }

            guard let user = result?.user else {
                self.onLoginError?("未获取到用户信息")
                return
            }

            let loginUser = LoginUser(
                id: user.userID ?? "",
                name: user.profile?.name ?? "",
                email: user.profile?.email ?? "",
                avatar: user.profile?.imageURL(withDimension: 120)?.absoluteString,
                idToken: user.idToken?.tokenString,
                accessToken: user.accessToken.tokenString
            )

            print("✅ Google 登录成功：\(loginUser.email)")
            self.onLoginSuccess?(loginUser)
        }
    }
}

// MARK: - Apple 登录代理
extension LoginViewModel: ASAuthorizationControllerDelegate,
                          ASAuthorizationControllerPresentationContextProviding {

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }

        // identityToken: Data -> String
        guard
            let tokenData = credential.identityToken,
            let identityToken = String(data: tokenData, encoding: .utf8)
        else {
            onLoginError?("无法获取 Apple identityToken")
            return
        }

        let loginUser = LoginUser(
            id: credential.user,
            name: credential.fullName?.givenName ?? "",
            email: credential.email ?? "",
            avatar: nil,
            idToken: identityToken,
            accessToken: nil
        )

        // ⚠️ 系统回调是同步的，必须用 Task
        Task { [weak self] in
            guard let self = self else { return }

            let result = await AuthService.login_apple(identityToken: identityToken)

            if result?.code == 0 {
                self.onLoginSuccess?(loginUser)
            } else {
                self.onLoginError?(result?.msg ?? "Apple 登录失败")
            }
        }
    }

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        onLoginError?("Apple 登录失败：\(error.localizedDescription)")
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first { $0.isKeyWindow } ?? UIWindow()
    }
}
