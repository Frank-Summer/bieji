//
//  musicModel.swift
//  YunFu
//
//  Created by wanglong on 2026/1/13.
//  Copyright © 2026 DCloud. All rights reserved.
//

import Foundation

struct MusicModel {
    let id: Int
    let meta: MetaInfo
    let introductions: String
    let explore: [ExploreItem]
    let banners: [BannerItem]
    let acousticTech: AcousticTech?
    let socialProofs: [SocialProof]
    let musicFileUrls: [String]
    let videoFileUrl: String?
    
    static func parseDetail(body: [String: AnyCodable]) -> MusicModel? {
        guard
            let id = body["id"]?.value as? Int
        else {
            print("❌ id 解析失败")
            return nil
        }


        let meta = MetaInfo.parse(
            anyDict: body["meta"]?.value as? [String: AnyCodable]
        )

        let introductions =
            body["introductions"]?.value as? String ?? ""

        let explores =
            ExploreItem.parseArray(any: body["explore"]?.value)

        let banners =
            BannerItem.parseArray(any: body["someLargeAndLuxurious"]?.value)

        let acousticTech =
            AcousticTech.parse(
                anyDict: body["acousticTech"]?.value as? [String: AnyCodable]
            )

        let socialProofs =
            SocialProof.parseArray(any: body["socialProof"]?.value)

        let musicFileUrls =
            parseStringArray(any: body["musicFileUrl"]?.value)

        let videoFileUrl =
            body["videoFileUrl"]?.value as? String

        guard let meta = meta else {
            print("❌ meta 解析失败")
            return nil
        }

        return MusicModel(
            id: id,
            meta: meta,
            introductions: introductions,
            explore: explores,
            banners: banners,
            acousticTech: acousticTech,
            socialProofs: socialProofs,
            musicFileUrls: musicFileUrls,
            videoFileUrl: videoFileUrl
        )
    }
}

func parseStringArray(any: Any?) -> [String] {
    guard let arr = any as? [Any] else { return [] }
    return arr.compactMap { $0 as? String }
}

struct MetaInfo {
    let internalName: String
    let status: String
    let subTitle: String
    let version: String
    let scene: SceneRef?
    let artist: ArtistInfo?
}

struct SceneRef {
    let scenesId: String
    let scenesName: String

    static func parse(anyDict: [String: AnyCodable]?) -> SceneRef? {
        guard let dict = anyDict else { return nil }

        let scenesId = dict["scenesId"]?.value as? String ?? ""
        let scenesName = dict["scenesName"]?.value as? String ?? ""

        return SceneRef(scenesId: scenesId, scenesName: scenesName)
    }
}

struct ArtistInfo {
    let name: String
    let biography: String?
    let avatarUrl: String?
    let socialLinks: String?

    static func parse(anyDict: [String: AnyCodable]?) -> ArtistInfo? {
        guard let dict = anyDict else { return nil }

        let name = dict["name"]?.value as? String ?? ""
        let biography = dict["biography"]?.value as? String
        let avatarUrl = dict["avatarUrl"]?.value as? String
        let socialLinks = dict["socialLinks"]?.value as? String

        return ArtistInfo(
            name: name,
            biography: biography,
            avatarUrl: avatarUrl,
            socialLinks: socialLinks
        )
    }
}


extension MetaInfo {
    static func parse(anyDict: [String: AnyCodable]?) -> MetaInfo? {
        guard let dict = anyDict else { return nil }

        let internalName = dict["internalName"]?.value as? String ?? ""
        let status = dict["status"]?.value as? String ?? ""
        let subTitle = dict["subTitle"]?.value as? String ?? ""
        let version = dict["version"]?.value as? String ?? ""

        let scene = SceneRef.parse(
            anyDict: dict["scenes"]?.value as? [String: AnyCodable]
        )

        let artist = ArtistInfo.parse(
            anyDict: dict["artist"]?.value as? [String: AnyCodable]
        )

        return MetaInfo(
            internalName: internalName,
            status: status,
            subTitle: subTitle,
            version: version,
            scene: scene,
            artist: artist
        )
    }
}
struct ExploreItem {
    let musicId: String
    let headline: String
    let subhead: String
    let musicPic: String
}

extension ExploreItem {
    static func parseArray(any: Any?) -> [ExploreItem] {
        guard let arr = any as? [AnyCodable] else { return [] }

        return arr.compactMap {
            guard
                let dict = $0.value as? [String: AnyCodable],
                let musicId = dict["musicId"]?.value as? String,
                let headline = dict["headline"]?.value as? String,
                let subhead = dict["subhead"]?.value as? String,
                let musicPic = dict["musicPic"]?.value as? String
            else { return nil }

            return ExploreItem(
                musicId: musicId,
                headline: headline,
                subhead: subhead,
                musicPic: musicPic
            )
        }
    }
}

struct BannerItem {
    let headline: String
    let pic: String
}
extension BannerItem {

    static func parseArray(any: Any?) -> [BannerItem] {
        guard let arr = any as? [AnyCodable] else { return [] }

        return arr.compactMap {
            guard
                let dict = $0.value as? [String: AnyCodable],
                let headline = dict["headline"]?.value as? String,
                let pic = dict["pic"]?.value as? String
            else { return nil }

            return BannerItem(
                headline: headline,
                pic: pic
            )
        }
    }
}

struct AcousticTech {
    let principles: [AcousticSection]
    let instruments: [AcousticSection]
}

struct AcousticSection {
    let tag: String
    let items: [AcousticItem]
}

struct AcousticItem {
    let tag: String?
    let name: String?
    let description: String
}
extension AcousticTech {

    static func parse(anyDict: [String: AnyCodable]?) -> AcousticTech? {
        guard let dict = anyDict else { return nil }

        let principles = AcousticSection.parseArray(
            any: dict["principles"]?.value
        )

        let instruments = AcousticSection.parseArray(
            any: dict["instruments"]?.value
        )

        return AcousticTech(
            principles: principles,
            instruments: instruments
        )
    }
}

extension AcousticSection {

    static func parseArray(any: Any?) -> [AcousticSection] {
        guard let arr = any as? [AnyCodable] else { return [] }

        return arr.compactMap {
            guard
                let dict = $0.value as? [String: AnyCodable],
                let tag = dict["tag"]?.value as? String
            else { return nil }

            let items = AcousticItem.parseArray(
                any: dict["items"]?.value
            )

            return AcousticSection(
                tag: tag,
                items: items
            )
        }
    }
}

extension AcousticItem {

    static func parseArray(any: Any?) -> [AcousticItem] {
        guard let arr = any as? [AnyCodable] else { return [] }

        return arr.compactMap {
            guard
                let dict = $0.value as? [String: AnyCodable],
                let description = dict["description"]?.value as? String
            else { return nil }

            let tag = dict["tag"]?.value as? String
            let name = dict["name"]?.value as? String

            return AcousticItem(
                tag: tag,
                name: name,
                description: description
            )
        }
    }
}
struct SocialProof {
    let username: String
    let avatar: String?
    let content: String
    let tags: [String]
    let sceneContext: String?
}

extension SocialProof {

    static func parseArray(any: Any?) -> [SocialProof] {
        guard let arr = any as? [AnyCodable] else { return [] }

        return arr.compactMap {
            guard
                let dict = $0.value as? [String: AnyCodable],
                let username = dict["username"]?.value as? String,
                let content = dict["content"]?.value as? String
            else { return nil }

            let avatar = dict["avatar"]?.value as? String
            let sceneContext = dict["sceneContext"]?.value as? String

            let tags =
                (dict["tags"]?.value as? [Any])?
                .compactMap { $0 as? String } ?? []

            return SocialProof(
                username: username,
                avatar: avatar,
                content: content,
                tags: tags,
                sceneContext: sceneContext
            )
        }
    }
}
