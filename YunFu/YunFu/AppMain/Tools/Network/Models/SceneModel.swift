//
//  SceneModel.swift
//  YunFu
//
//  Created by wanglong on 2025/12/18.
//  Copyright © 2025 DCloud. All rights reserved.
//

import Foundation

struct ScenesResponse {
    let sort: [String]
    let scenes: [SceneModel]
    
    static func parseScenesResponse(body: [String: AnyCodable]) -> ScenesResponse? {

        // sort
        guard let sortAny = body["sort"]?.value as? [AnyCodable] else {
            print("❌ sort 解析失败")
            return nil
        }

        let sort = sortAny.compactMap { $0.value as? String }

        // detail
        guard let detailAny = body["detail"]?.value as? [String: AnyCodable] else {
            print("❌ detail 解析失败")
            return nil
        }

        var scenes: [SceneModel] = []

        for key in sort {
            guard
                let sceneAny = detailAny[key]?.value as? [String: AnyCodable],
                let model = SceneModel(anyDict: sceneAny)
            else { continue }

            scenes.append(model)
        }

        return ScenesResponse(sort: sort, scenes: scenes)
    }
}

struct SceneModel {
    let id: Int
    let sceneName: String
    let sceneCode: String
    let accessType: String
    let iconName: String
    let backgroundUrl: String
    let displayCopyTitle: String
    let displayCopy: String
    let isActive: Bool
    let songUuids: [String]
}

extension SceneModel {

    init?(anyDict: [String: AnyCodable]) {

        guard
            let id = anyDict["id"]?.value as? Int,
            let sceneName = anyDict["sceneName"]?.value as? String,
            let accessType = anyDict["accessType"]?.value as? String,
            let sceneCode = anyDict["sceneCode"]?.value as? String,
            let iconName = anyDict["iconName"]?.value as? String,
            let backgroundUrl = anyDict["backgroundUrl"]?.value as? String,
            let displayCopyTitle = anyDict["displayCopyTitle"]?.value as? String,
            let displayCopy = anyDict["displayCopy"]?.value as? String,
            let isActive = anyDict["isActive"]?.value as? Bool
        else {
            return nil
        }

        let songUuids: [String]

        if let array = anyDict["songUuids"]?.value as? [AnyCodable] {
            songUuids = array.compactMap { $0.value as? String }
        } else if let array = anyDict["songUuids"]?.value as? [Any] {
            songUuids = array.compactMap { $0 as? String }
        } else {
            songUuids = []
        }

        self.id = id
        self.sceneName = sceneName
        self.sceneCode = sceneCode
        self.accessType = accessType
        self.iconName = iconName
        self.backgroundUrl = backgroundUrl
        self.displayCopyTitle = displayCopyTitle
        self.displayCopy = displayCopy
        self.isActive = isActive
        self.songUuids = songUuids
    }
}
