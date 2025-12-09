
import Foundation

class TUOKOU_TaskQueue {
    static let shared = TUOKOU_TaskQueue()
    
    private let queue = DispatchQueue(label: "tukou.request.queue", attributes: .concurrent)
    private let semaphore: DispatchSemaphore
    
    init(maxConcurrent: Int = 3) {
        self.semaphore = DispatchSemaphore(value: maxConcurrent)
    }
    
    func addTask(_ block: @escaping () -> Void) {
        queue.async {
            self.semaphore.wait()
            block()
            self.semaphore.signal()
        }
    }
}
