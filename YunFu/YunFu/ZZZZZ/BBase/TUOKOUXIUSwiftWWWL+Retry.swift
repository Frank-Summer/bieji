
import Alamofire
import Foundation

extension TUOKOUXIUSwiftWWWL {
    
    /// 自动重试请求
    func tukou_requestWithRetry(
        retryCount: Int = 2,
        retryDelay: TimeInterval = 1.0,
        task: @escaping (@escaping (Bool) -> Void) -> Void
    ) {
        var attempts = 0
        
        func run() {
            task { ok in
                if ok {
                    return
                }
                attempts += 1
                
                if attempts <= retryCount {
                    DispatchQueue.main.asyncAfter(deadline: .now() + retryDelay) {
                        run()
                    }
                }
            }
        }
        
        run()
    }
}
