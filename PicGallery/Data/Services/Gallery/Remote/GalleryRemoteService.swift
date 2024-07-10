//
//  GalleryRemoteService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

protocol GalleryRemoteService {
    func getGallery(token: String) async throws -> GalleryResponse
}
