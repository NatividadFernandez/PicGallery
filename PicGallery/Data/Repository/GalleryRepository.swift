//
//  GalleryRepository.swift
//  PicGallery
//
//  Created by Natividad 9/7/24.
//

import Foundation

struct GalleryRepository {
    
    let remoteService: GalleryRemoteService
    let localTokenService: TokenLocalService
    
    init(remoteService: GalleryRemoteService, localTokenService: TokenLocalService) {
        self.remoteService = remoteService
        self.localTokenService = localTokenService
    }
    
    func getGallery() async throws -> GalleryResponse {
        let token = try await localTokenService.getAccessToken()
        return try await remoteService.getGallery(token: token)
    }
}
