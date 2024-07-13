//
//  MockGalleryRemoteService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

struct MockGalleryRemoteService: GalleryRemoteService {
    
    let pictures: [Picture] = [.example,.example]
    
    func deletePicture(token: String, imageHash: String) async throws -> GenericPictureResponse<Bool> {
        return GenericPictureResponse(data: true, success: true, status: 200)
    }
    
    func uploadPicture(token: String, uploadBody: [String : String]) async throws -> GenericPictureResponse<Picture> {
        return GenericPictureResponse(data: .example, success: true, status: 200)
    }
    
    func getGallery(token: String) async throws -> GalleryResponse {
        .init(data: pictures, success: true, status: 200)
    }
    
    
}
