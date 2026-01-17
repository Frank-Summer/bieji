

import Foundation

extension String {
    var iconName: String {
        switch self {
        case "通勤":
            return "commute"
        case "深睡眠":
            return "sleep"
        case "婴儿安睡":
            return "baby-sleep"
        case "睡午觉":
            return "siesta"
        case "图书馆":
            return "book"
        case "健身":
            return "gym"
        case "瑜伽":
            return "yoga"
        case "跑步":
            return "run"
        case "深夜专注":
            return "latenight-focus"
        case "专注":
            return "focus"
        case "工作":
            return "work"
        case "阅读":
            return "read"
        case "减压":
            return "stress-relief"
        case "胎教":
            return "prenatal-education"
        case "宠物陪伴":
            return "pet"
        case "放松":
            return "relax"
        case "经期舒展":
            return "period"
        case "冥想":
            return "meditation"
        case "打游戏":
            return "game"
        case "深夜EMO":
            return "emo"
        default:
            return "sleep"
        }
    }
}
