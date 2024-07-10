//
//  MockGalleryRemoteService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

struct MockGalleryRemoteService: GalleryRemoteService {
    func getGallery(token: String) async throws -> GalleryResponse {
        .init(data: [.example, .example], success: true, status: 200)
    }
    
    
}
