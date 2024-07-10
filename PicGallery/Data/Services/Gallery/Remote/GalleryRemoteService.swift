//
//  GalleryRemoteService.swift
//  PicGallery
//
//  Created by Patricia Lucia Morillas Alcala on 9/7/24.
//

import Foundation

protocol GalleryRemoteService {
    func getGallery(token: String) async throws -> GalleryResponse
}
