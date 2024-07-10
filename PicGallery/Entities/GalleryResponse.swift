//
//  GalleryResponse.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

// MARK: - Gallery
struct GalleryResponse: Codable {
    let data: [Picture]
    let success: Bool
    let status: Int
}

// MARK: - Picture
struct Picture: Codable, Identifiable {
    let id: String
    let title: String?
    let description: String
    let datetime: Int
    let type: String
    let animated: Bool
    let width, height, size, views: Int
    let bandwidth: Int
    let favorite: Bool
    let accountURL: String
    let accountID: Int
    let isAd, inMostViral, hasSound: Bool
    let adType: Int
    let adURL: String
    let inGallery: Bool
    let deletehash, name: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case id, title, description, datetime, type, animated, width, height, size, views, bandwidth, favorite
        case accountURL = "account_url"
        case accountID = "account_id"
        case isAd = "is_ad"
        case inMostViral = "in_most_viral"
        case hasSound = "has_sound"
        case adType = "ad_type"
        case adURL = "ad_url"
        case inGallery = "in_gallery"
        case deletehash, name, link
    }
    
    // Ejemplo estático de Picture
    static var example: Picture {
        return Picture(
            id: "abc123",
            title: "Beautiful Landscape",
            description: "A stunning landscape photo taken at sunset.",
            datetime: 1625683200,
            type: "image/jpeg",
            animated: false,
            width: 1920,
            height: 1080,
            size: 1234567,
            views: 1000,
            bandwidth: 987654,
            favorite: true,
            accountURL: "https://imgur.com/user/example",
            accountID: 123456,
            isAd: false,
            inMostViral: true,
            hasSound: false,
            adType: 0,
            adURL: "",
            inGallery: true,
            deletehash: "xyz789",
            name: "landscape",
            link: "https://imgur.com/gallery/abc123"
        )
    }

}
