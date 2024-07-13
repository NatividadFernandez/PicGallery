//
//  LiveGalleryRemoteService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation
import SwiftUI

struct LiveGalleryRemoteService: GalleryRemoteService {
    
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getGallery(token: String) async throws -> GalleryResponse {
        return try await networkClient.getCall(token: token, url: NetworkConstants.galleryUrl, queryParams: nil)
    }
    
    func uploadPicture(token: String, uploadBody: [String : String]) async throws -> GenericPictureResponse<Picture> {
        return try await networkClient.postImageCall(token: token, url: NetworkConstants.uploadImageUrl, body: uploadBody)
    }
    
    func deletePicture(token: String, imageHash: String) async throws -> GenericPictureResponse<Bool> {
        return try await networkClient.deleteImageCall(token: token, url: "\(NetworkConstants.deleteImageUrl)/\(imageHash)")
    }
    
}
