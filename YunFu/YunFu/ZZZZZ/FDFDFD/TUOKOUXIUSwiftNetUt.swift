
import UIKit
import CoreTelephony

class TUOKOUXIUSwiftNetUt: NSObject {

    private static var reachInstan: TUOKOUXIUSwiftReachabi?

    static func tukou_getCurrNetSta() -> Int {
        guard let reach = TUOKOUXIUSwiftReachabi(hostName: "www.apple.com") else {
            return 0
        }
        return reach.currentReachStatus().rawValue
    }

    static func tukou_getNetT() -> String {
        var netType = "unknown"
        switch tukou_getCurrNetSta() {
        case 0:
            netType = "no network"
        case 1:
            netType = "Wifi"
        case 2:
            let info = CTTelephonyNetworkInfo()
            var currentTech: String?
            if #available(iOS 12.0, *) {
                if let statusDict = info.serviceCurrentRadioAccessTechnology, !statusDict.isEmpty {
                    currentTech = statusDict.values.first
                }
            } else {
                currentTech = info.currentRadioAccessTechnology
            }

            if let tech = currentTech {
                    switch tech {
                    case CTRadioAccessTechnologyGPRS:
                        netType = "GPRS"
                    case CTRadioAccessTechnologyEdge:
                        netType = "2.75G EDGE"
                    case CTRadioAccessTechnologyWCDMA:
                        netType = "3G"
                    case CTRadioAccessTechnologyHSDPA:
                        netType = "3.5G HSDPA"
                    case CTRadioAccessTechnologyHSUPA:
                        netType = "3.5G HSUPA"
                    case CTRadioAccessTechnologyCDMA1x:
                        netType = "2G"
                    case CTRadioAccessTechnologyCDMAEVDORev0,
                         CTRadioAccessTechnologyCDMAEVDORevA,
                         CTRadioAccessTechnologyCDMAEVDORevB:
                        netType = "3G"
                    case CTRadioAccessTechnologyeHRPD:
                        netType = "HRPD"
                    case CTRadioAccessTechnologyLTE:
                        netType = "4G"
                    case CTRadioAccessTechnologyNRNSA:
                        netType = "5G NSA"
                    case CTRadioAccessTechnologyNR:
                        netType = "5G"
                    default:
                        netType = "WWAN"
                    }
            }
        default:
            break
        }
        return netType
    }

    static func tukou_regObsNetSta() {
        reachInstan = TUOKOUXIUSwiftReachabi.forInternetConnection()
        reachInstan?.startNotify()
    }

    static func tukou_unregObsNetSta() {
        reachInstan?.stopNotify()
    }
}
