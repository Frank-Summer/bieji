//
//  SceneModel.swift
//  YunFu
//
//  Created by wanglong on 2025/12/18.
//  Copyright © 2025 DCloud. All rights reserved.
//

import Foundation

struct SceneModel {
    let id: Int
    let sceneName: String
    let sceneCode: String
    let iconName: String
    let backgroundUrl: String
    let displayCopyTitle: String
    let displayCopy: String
    let category: String
    let isActive: Bool
    
    static func parseScenes(body: [String: AnyCodable]) -> [SceneModel] {

        // 1️⃣ 解析 sort
        guard
            let sortAny = body["sort"]?.value as? [AnyCodable]
        else {
            print("❌ sort 解析失败")
            return []
        }

        let sortList: [String] = sortAny.compactMap {
            $0.value as? String
        }

        if sortList.isEmpty {
            print("❌ sortList 为空")
            return []
        }

        // 2️⃣ 解析 detail
        guard
            let detailAny = body["detail"]?.value as? [String: AnyCodable]
        else {
            print("❌ detail 解析失败")
            return []
        }

        // 3️⃣ 按 sort 顺序组装
        var scenes: [SceneModel] = []

        for key in sortList {
            guard
                let sceneAny = detailAny[key]?.value as? [String: AnyCodable]
            else {
                print("⚠️ 找不到 detail[\(key)]")
                continue
            }

            if let model = SceneModel(anyDict: sceneAny) {
                scenes.append(model)
            } else {
                print("⚠️ SceneModel 转换失败：\(key)")
            }
        }

        print("✅ 成功解析 scenes 数量：\(scenes.count)")
        return scenes
    }
}

extension SceneModel {

    init?(anyDict: [String: AnyCodable]) {

        guard
            let id = anyDict["id"]?.value as? Int,
            let sceneName = anyDict["sceneName"]?.value as? String,
            let sceneCode = anyDict["sceneCode"]?.value as? String,
            let iconName = anyDict["iconName"]?.value as? String,
            let backgroundUrl = anyDict["backgroundUrl"]?.value as? String,
            let displayCopyTitle = anyDict["displayCopyTitle"]?.value as? String,
            let displayCopy = anyDict["displayCopy"]?.value as? String,
            let category = anyDict["category"]?.value as? String,
            let isActive = anyDict["isActive"]?.value as? Bool
        else {
            return nil
        }

        self.id = id
        self.sceneName = sceneName
        self.sceneCode = sceneCode
        self.iconName = iconName
        self.backgroundUrl = backgroundUrl
        self.displayCopyTitle = displayCopyTitle
        self.displayCopy = displayCopy
        self.category = category
        self.isActive = isActive
    }
}
