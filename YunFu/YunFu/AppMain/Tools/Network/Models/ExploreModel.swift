//
//  ExploreModel.swift
//  YunFu
//
//  Created by wanglong on 2026/1/23.
//  Copyright © 2026 DCloud. All rights reserved.
//

import Foundation

struct SceneSection {
    let title: String
    let musics: [MusicItem]
}

struct MusicItem {
    let musicId: Int
    let musicName: String
    let musicDesc: String
    let musicImg: String
}

enum ExploreModel {

    static func parse(body: [String: AnyCodable]) -> [SceneSection]? {

        guard
            let sceneClass = body["sceneClass"]?.value as? [String: AnyCodable]
        else {
            print("❌ sceneClass missing")
            return nil
        }

        var sections: [SceneSection] = []

        for (title, musicListAny) in sceneClass {

            guard let musicList = musicListAny.value as? [AnyCodable] else {
                continue
            }

            var musics: [MusicItem] = []

            for musicAny in musicList {

                guard let dictAny = musicAny.value as? [String: AnyCodable] else {
                    continue
                }

                guard
                    let id = dictAny["music_id"]?.value as? Int,
                    let name = dictAny["music_name"]?.value as? String,
                    let desc = dictAny["music_desc"]?.value as? String,
                    let img = dictAny["music_img"]?.value as? String
                else {
                    continue
                }

                musics.append(
                    MusicItem(
                        musicId: id,
                        musicName: name,
                        musicDesc: desc,
                        musicImg: img
                    )
                )
            }

            sections.append(
                SceneSection(title: title, musics: musics)
            )
        }

        return sections
    }
}
