

import Foundation
import UIKit
import AdSupport
import AVFoundation
import NetworkExtension
import Darwin

class TUOKOUXIUSSApp: NSObject {

    static func tukou_phoDevCo() -> String {
        let tufuh_idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        if !tufuh_idfa.isEmpty && tufuh_idfa != "00000000-0000-0000-0000-000000000000" {
            return tufuh_idfa
        }

        if let tufuh_idfv = UIDevice.current.identifierForVendor?.uuidString, !tufuh_idfv.isEmpty {
            return tufuh_idfv
        }

        return "00000000"
    }

    static func tukou_idfi() -> String {
        return Bundle.main.bundleIdentifier ?? "Unknown"
    }

    static func tukou_appVer() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
    }

    static func tukou_appYuY() -> String {
        let tufuh_yy = UserDefaults.standard.stringArray(forKey: "AppleLanguages")
        return tufuh_yy?.first ?? "0"
    }
    
    static func tukou_appZon() -> String {
        return TimeZone.current.identifier
    }
    
    static func tukou_sysVer() -> String {
        return UIDevice.current.systemVersion
    }
    
    static func tukou_currtimst() -> String {
        let tufuh_timeInterval = Date().timeIntervalSince1970 * 1000
        return String(Int64(tufuh_timeInterval))
    }
    
    static func tukou_conAVASess() {
        let tufuh_session = AVAudioSession.sharedInstance()
        do {
            try tufuh_session.setCategory(.playback, mode: .default)
            try tufuh_session.setActive(true)
        } catch {
            print("⚠️ Failed to set or activate AVAudioSession: \(error)")
        }
    }
    
    static func tukou_locaLang() -> String {
        return Locale.preferredLanguages.first ?? "0"
    }
    
    static func tukou_isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static func tukou_isVPN() -> Bool {
        guard let tufuh_proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
              let tufuh_scoped = tufuh_proxySettings["__SCOPED__"] as? [String: Any] else {
            return false
        }
        
        for tufuh_key in tufuh_scoped.keys {
            if tufuh_key.contains("tap") || tufuh_key.contains("tun") ||
                tufuh_key.contains("ppp") || tufuh_key.contains("ipsec") {
                return true
            }
        }
        return false
    }
    
    static func tukou_phoAdId() -> String {
        let tufuh_manager = ASIdentifierManager.shared()
        if tufuh_manager.isAdvertisingTrackingEnabled {
            let tufuh_idfa = tufuh_manager.advertisingIdentifier.uuidString
            if !tufuh_idfa.isEmpty && tufuh_idfa != "00000000-0000-0000-0000-000000000000" {
                return tufuh_idfa
            }
        }
        return "000000"
    }

    static func tukou_phoIFv() -> String {
        let tufuh_idfv = UIDevice.current.identifierForVendor?.uuidString ?? "00000000"
        return tufuh_idfv.isEmpty ? "00000000" : tufuh_idfv
    }
    
    static func tukou_currRiQiSFM() -> String {
        let tufuh_formatter = DateFormatter()
        tufuh_formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        tufuh_formatter.locale = Locale(identifier: "en_US_POSIX")
        tufuh_formatter.timeZone = TimeZone.current
        return tufuh_formatter.string(from: Date())
    }
    
    static func tukou_currNYR() -> String {
        let tufuh_formatter = DateFormatter()
        tufuh_formatter.dateFormat = "yyyyMMdd"
        tufuh_formatter.locale = Locale(identifier: "en_US_POSIX")
        tufuh_formatter.timeZone = TimeZone.current
        return tufuh_formatter.string(from: Date())
    }
    
    static func tukou_ipAdd() -> String {
        var tufuh_address: String = "0.0.0.0"
        var tufuh_ifaddr: UnsafeMutablePointer<ifaddrs>?

        if getifaddrs(&tufuh_ifaddr) == 0, let firstAddr = tufuh_ifaddr {
            var tufuh_ptr = firstAddr
            while tufuh_ptr.pointee.ifa_next != nil {
                let tufuh_interface = tufuh_ptr.pointee
                let tufuh_addrFamily = tufuh_interface.ifa_addr.pointee.sa_family

                if tufuh_addrFamily == UInt8(AF_INET) {
                    let tufuh_name = String(cString: tufuh_interface.ifa_name)
                    if tufuh_name == "en0" {
                        let tufuh_addr = tufuh_interface.ifa_addr.withMemoryRebound(to: sockaddr_in.self, capacity: 1) {
                            $0.pointee
                        }
                        tufuh_address = String(cString: inet_ntoa(tufuh_addr.sin_addr))
                        break
                    }
                }
                tufuh_ptr = tufuh_interface.ifa_next!
            }
            freeifaddrs(tufuh_ifaddr)
        }
        return tufuh_address
    }
    static func tukou_deviTy() -> String {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad: return "iPad"
        case .phone: return "iPhone"
        default: return "Unknown"
        }
    }
    
    static func tukou_devModN() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String(validatingUTF8: $0) ?? "unknown"
            }
        }

        let modelMap: [String: String] = [
            "iPhone7,1": "iPhone 6 Plus",
            "iPhone8,1": "iPhone 6s", "iPhone8,2": "iPhone 6s Plus",
            "iPhone8,4": "iPhone SE1", "iPhone9,1": "iPhone 7", "iPhone9,3": "iPhone 7",
            "iPhone9,2": "iPhone 7 Plus", "iPhone9,4": "iPhone 7 Plus",
            "iPhone10,1": "iPhone 8", "iPhone10,4": "iPhone 8",
            "iPhone10,2": "iPhone 8 Plus", "iPhone10,5": "iPhone 8 Plus",
            "iPhone10,3": "iPhone X", "iPhone10,6": "iPhone X",
            "iPhone11,2": "iPhone XS", "iPhone11,4": "iPhone XS Max", "iPhone11,6": "iPhone XS Max",
            "iPhone11,8": "iPhone XR", "iPhone12,1": "iPhone 11",
            "iPhone12,3": "iPhone 11 Pro", "iPhone12,5": "iPhone 11 Pro Max",
            "iPhone12,8": "iPhone SE2",
            "iPhone13,1": "iPhone 12 mini", "iPhone13,2": "iPhone 12",
            "iPhone13,3": "iPhone 12 Pro", "iPhone13,4": "iPhone 12 Pro Max",
            "iPhone14,4": "iPhone 13 mini", "iPhone14,5": "iPhone 13",
            "iPhone14,2": "iPhone 13 Pro", "iPhone14,3": "iPhone 13 Pro Max",
            "iPhone14,6": "iPhone SE3", "iPhone14,7": "iPhone 14", "iPhone14,8": "iPhone 14 Plus",
            "iPhone15,2": "iPhone 14 Pro", "iPhone15,3": "iPhone 14 Pro Max",
            "iPhone15,4": "iPhone 15", "iPhone15,5": "iPhone 15 Plus",
            "iPhone16,1": "iPhone 15 Pro", "iPhone16,2": "iPhone 15 Pro Max",
            "iPhone17,1": "iPhone 16 Pro", "iPhone17,2": "iPhone 16 Pro Max",
            "iPhone17,3": "iPhone 16", "iPhone17,4": "iPhone 16 Plus",

            "iPhone18,1": "iPhone 17 Pro", "iPhone18,2": "iPhone 17 Pro Max",
            "iPhone18,3": "iPhone 17", "iPhone18,4": "iPhone 17 Air",

            
            "iPad4,1": "iPad Air","iPad4,2": "iPad Air",
            "iPad4,3": "iPad Air","iPad5,3": "iPad Air 2",
            "iPad5,4": "iPad Air 2","iPad11,3": "iPad Air 3",
            "iPad11,4": "iPad Air 3","iPad13,1": "iPad Air 4",
            "iPad13,2": "iPad Air 4","iPad13,16": "iPad Air 5",
            "iPad13,17": "iPad Air 5","iPad14,8": "iPad Air 6",
            "iPad14,9": "iPad Air 6", "iPad14,10": "iPad Air 7",
            "iPad14,11": "iPad Air 7",
            "iPad4,4": "iPad Mini 2","iPad4,5": "iPad Mini 2",
            "iPad4,6": "iPad Mini 2","iPad4,7": "iPad Mini 3",
            "iPad4,8": "iPad Mini 3","iPad4,9": "iPad Mini 3",
            "iPad5,1": "iPad Mini 4","iPad5,2": "iPad Mini 4",
            "iPad11,1": "iPad Mini 5","iPad11,2": "iPad Mini 5",
            "iPad14,1": "iPad Mini 6","iPad14,2": "iPad Mini 6",
            "iPad6,11": "iPad 5","iPad6,12": "iPad 5",
            "iPad7,5": "iPad 6","iPad7,6": "iPad 6",
            "iPad7,11": "iPad 7","iPad7,12": "iPad 7",
            "iPad11,6": "iPad 8","iPad11,7": "iPad 8",
            "iPad12,1": "iPad 9","iPad12,2": "iPad 9",
            "iPad13,18": "iPad 10", "iPad13,19": "iPad 10",
            
            "iPad6,7": "iPad Pro", "iPad6,8": "iPad Pro",
            "iPad6,3": "iPad Pro", "iPad6,4": "iPad Pro",
            "iPad7,3": "iPad Pro", "iPad7,4": "iPad Pro",
            "iPad8,1": "iPad Pro", "iPad8,2": "iPad Pro",
            "iPad8,3": "iPad Pro", "iPad8,4": "iPad Pro",
            
            "iPad7,1": "iPad Pro2", "iPad7,2": "iPad Pro2",
            "iPad8,9": "iPad Pro2", "iPad8,10": "iPad Pro2",
            
            "iPad8,5": "iPad Pro3", "iPad8,6": "iPad Pro3",
            "iPad8,7": "iPad Pro3", "iPad8,8": "iPad Pro3",
            "iPad13,4": "iPad Pro3", "iPad13,5": "iPad Pro3",
            "iPad13,6": "iPad Pro3", "iPad13,7": "iPad Pro3",
            
            "iPad8,11": "iPad Pro4", "iPad8,12": "iPad Pro4",
            "iPad14,3": "iPad Pro4", "iPad14,4": "iPad Pro4",

            "iPad13,8": "iPad Pro5", "iPad13,9": "iPad Pro5",
            "iPad13,10": "iPad Pro5", "iPad13,11": "iPad Pro5",
            "iPad16,3": "iPad Pro5", "iPad16,4": "iPad Pro5",
            
            "iPad14,5": "iPad Pro6", "iPad14,6": "iPad Pro6",
            
            "iPad16,5": "iPad Pro7", "iPad16,6": "iPad Pro7",
            
            "iMac21,1": "iMac", "iMac21,2": "iMac",
            
            "Macmini9,1": "Mac mini","MacBookAir10,1": "MacBook Air",
            
            "MacBookPro17,1": "MacBook Pro", "MacBookPro18,3": "MacBook Pro",
            "MacBookPro18,4": "MacBook Pro", "MacBookPro18,1": "MacBook Pro",
            "MacBookPro18,2": "MacBook Pro",
        ]

        return modelMap[modelCode] ?? modelCode
    }
}
