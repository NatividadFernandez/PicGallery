//
//  GalleryRemoteService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation
import SwiftUI

protocol GalleryRemoteService {
    func getGallery(token: String) async throws -> GalleryResponse
    func uploadPicture(token: String, uploadBody: [String: String]) async throws -> PictureResponse
}
