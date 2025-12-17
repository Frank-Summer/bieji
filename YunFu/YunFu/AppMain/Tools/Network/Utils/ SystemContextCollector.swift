import Foundation
import CoreLocation
import CoreMotion
import HealthKit

/// 系统上下文采集器
/// - 时间
/// - 定位 & 地点类型
/// - 运动状态（行走 / 驾驶 / 静止）
/// - 心率
/// - 天气（❌ 已软禁，保留字段）
final class SystemContextCollector: NSObject {

    static let shared = SystemContextCollector()

    private let locationManager = CLLocationManager()
    private let motionManager = CMMotionActivityManager()
    private let healthStore = HKHealthStore()

    /// CLLocation 回调（不能放 extension）
    private var locationCompletion: (([String: Any]) -> Void)?

    private override init() {
        super.init()
        locationManager.delegate = self
    }

    // MARK: - 对外统一入口
    func collect(completion: @escaping ([String: Any]) -> Void) {

        var result: [String: Any] = [:]

        // 1️⃣ 时间
        let now = Date()
        result["timestamp"] = Int(now.timeIntervalSince1970)
        result["date"] = DateFormatter.readable.string(from: now)

        let group = DispatchGroup()

        // 2️⃣ 定位
        group.enter()
        fetchLocation { info in
            result["location"] = info
            group.leave()
        }

        // 3️⃣ 运动状态
        group.enter()
        fetchMotion { info in
            result["motion"] = info
            group.leave()
        }

        // 4️⃣ 心率
        group.enter()
        fetchHeartRate { rate in
            result["health"] = [
                "heartRate": rate as Any
            ]
            group.leave()
        }

        // 5️⃣ 天气（❌ 已软禁，不再真实获取）
        result["weather"] = [
            "enabled": false,
            "reason": "WeatherKit disabled due to account / entitlement limitation"
        ]

        group.notify(queue: .main) {
            completion(result)
        }
    }
}

// MARK: - DateFormatter
extension DateFormatter {
    static let readable: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return f
    }()
}

// MARK: - 定位
extension SystemContextCollector {

    func fetchLocation(completion: @escaping ([String: Any]) -> Void) {
        locationCompletion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

extension SystemContextCollector: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let loc = locations.first else {
            locationCompletion?([:])
            locationCompletion = nil
            return
        }

        let placeType: String
        if loc.horizontalAccuracy < 100 {
            placeType = "city"
        } else {
            placeType = "unknown"
        }

        locationCompletion?([
            "lat": loc.coordinate.latitude,
            "lng": loc.coordinate.longitude,
            "accuracy": loc.horizontalAccuracy,
            "placeType": placeType
        ])

        locationCompletion = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationCompletion?([:])
        locationCompletion = nil
    }
}

// MARK: - 运动状态
extension SystemContextCollector {

    func fetchMotion(completion: @escaping ([String: Any]) -> Void) {

        guard CMMotionActivityManager.isActivityAvailable() else {
            completion([:])
            return
        }

        motionManager.startActivityUpdates(to: .main) { [weak self] activity in
            guard let a = activity else { return }

            let state: String
            if a.walking {
                state = "walking"
            } else if a.running {
                state = "running"
            } else if a.automotive {
                state = "driving"
            } else if a.stationary {
                state = "stationary"
            } else {
                state = "unknown"
            }

            completion([
                "activity": state,
                "isMoving": !a.stationary
            ])

            self?.motionManager.stopActivityUpdates()
        }
    }
}

// MARK: - 心率
extension SystemContextCollector {

    func fetchHeartRate(completion: @escaping (Double?) -> Void) {

        guard HKHealthStore.isHealthDataAvailable() else {
            completion(nil)
            return
        }

        let type = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let unit = HKUnit(from: "count/min")

        let query = HKSampleQuery(
            sampleType: type,
            predicate: nil,
            limit: 1,
            sortDescriptors: [
                NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            ]
        ) { _, samples, _ in

            guard let sample = samples?.first as? HKQuantitySample else {
                completion(nil)
                return
            }

            completion(sample.quantity.doubleValue(for: unit))
        }

        healthStore.execute(query)
    }
}

// MARK: - async 封装
extension SystemContextCollector {

    /// async 封装，方便直接 await 使用
    func collectAsync() async -> [String: Any] {
        await withCheckedContinuation { continuation in
            collect { result in
                continuation.resume(returning: result)
            }
        }
    }
}
