//
//  LiveGalleryRemoteService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

struct LiveGalleryRemoteService: GalleryRemoteService {
    
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getGallery(token: String) async throws -> GalleryResponse {
        return try await networkClient.getCall(token: token, url: NetworkConstants.galleryUrl, queryParams: nil)
    }
    
}
