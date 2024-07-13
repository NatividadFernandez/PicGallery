//
//  MockGalleryRemoteService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

struct MockGalleryRemoteService: GalleryRemoteService {
    
    func deletePicture(token: String, imageHash: String) async throws -> GenericPictureResponse<Bool> {
        return GenericPictureResponse(data: true, success: true, status: 200)
    }
    
    func uploadPicture(token: String, uploadBody: [String : String]) async throws -> GenericPictureResponse<Picture> {
        return GenericPictureResponse(data: Picture(
            id: UUID().uuidString,
            title: "Example title",
            description: "Example description",
            datetime: Date().hashValue,
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
            link: "example"
        ), success: true, status: 200)
    }
    
    func getGallery(token: String) async throws -> GalleryResponse {
        .init(data: [Picture(
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
        ),Picture(
            id: "def456",
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
        )], success: true, status: 200)
    }
    
    
}
