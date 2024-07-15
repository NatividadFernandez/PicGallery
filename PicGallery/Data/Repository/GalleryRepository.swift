//
//  GalleryRepository.swift
//  PicGallery
//
//  Created by Natividad 9/7/24.
//

import Foundation
import SwiftUI

struct GalleryRepository {
    
    let remoteService: GalleryRemoteService
    let localTokenService: TokenLocalService
    
    init(remoteService: GalleryRemoteService, localTokenService: TokenLocalService) {
        self.remoteService = remoteService
        self.localTokenService = localTokenService
    }
    
    func getGallery() async throws -> [Picture] {
        let token = try await localTokenService.getAccessToken()
        return try await remoteService.getGallery(token: token).data
    }
    
    func addPicture(image: UIImage) async throws -> GenericPictureResponse<Picture> {
        let token = try await localTokenService.getAccessToken()
        let imageData = image.jpegData(compressionQuality: 0.1)!
        let base64Image = imageData.base64EncodedString()
        let uploadBody = ["image": base64Image]
        return try await remoteService.uploadPicture(token: token, uploadBody: uploadBody)
    }
    
    func deletePicture(imageHash: String) async throws -> GenericPictureResponse<Bool> {
        let token = try await localTokenService.getAccessToken()
        return try await remoteService.deletePicture(token: token, imageHash: imageHash)
    }
    
    func logout() async throws {
        try await localTokenService.logout()
    }
}
