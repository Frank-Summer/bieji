
import Foundation
import SystemConfiguration

enum TUOKOUXIUSwiftENUM_NetStas: Int {
    case notReachable = 0
    case reachWiFi
    case reachWWAN
}

class TUOKOUXIUSwiftReachabi {

    private var reachRef: SCNetworkReachability?
    
    init?(hostName: String) {
        guard let ref = SCNetworkReachabilityCreateWithName(nil, hostName) else {
            return nil
        }
        self.reachRef = ref
    }
    
    init?(address: sockaddr) {
        var addr = address
        guard let ref = SCNetworkReachabilityCreateWithAddress(nil, &addr) else {
            return nil
        }
        self.reachRef = ref
    }
    
    static func forInternetConnection() -> TUOKOUXIUSwiftReachabi? {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        return withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { ptr in
                TUOKOUXIUSwiftReachabi(address: ptr.pointee)
            }
        }
    }
    
    deinit {
        stopNotify()
    }
    

    private let reachCallback: SCNetworkReachabilityCallBack = { (_, flags, info) in

        guard let info = info else { return }
        let reachability = Unmanaged<TUOKOUXIUSwiftReachabi>.fromOpaque(info).takeUnretainedValue()

        print("Reachability changed flags: \(flags), instance: \(reachability)")
    }
    

    @discardableResult
    func startNotify() -> Bool {
        guard let reachRef else { return false }
        var context = SCNetworkReachabilityContext(
            version: 0,
            info: UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()),
            retain: nil,
            release: nil,
            copyDescription: nil
        )
        
        if SCNetworkReachabilitySetCallback(reachRef, reachCallback, &context) {
            if SCNetworkReachabilityScheduleWithRunLoop(reachRef, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue) {
                return true
            }
        }
        return false
    }
    

    func stopNotify() {
        guard let reachRef else { return }
        SCNetworkReachabilityUnscheduleFromRunLoop(reachRef, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)
    }
    

    func currentReachStatus() -> TUOKOUXIUSwiftENUM_NetStas {
        guard let reachRef else { return .notReachable }
        var flags = SCNetworkReachabilityFlags()
        if SCNetworkReachabilityGetFlags(reachRef, &flags) {
            return netStatus(for: flags)
        }
        return .notReachable
    }
    

    private func netStatus(for flags: SCNetworkReachabilityFlags) -> TUOKOUXIUSwiftENUM_NetStas {
        if !flags.contains(.reachable) {
            return .notReachable
        }
        
        var status: TUOKOUXIUSwiftENUM_NetStas = .notReachable
        
        if !flags.contains(.connectionRequired) {
            status = .reachWiFi
        }
        
        if (flags.contains(.connectionOnTraffic) || flags.contains(.connectionOnDemand)) &&
            !flags.contains(.interventionRequired) {
            status = .reachWiFi
        }
        
        if flags.contains(.isWWAN) {
            status = .reachWWAN
        }
        
        return status
    }
}
