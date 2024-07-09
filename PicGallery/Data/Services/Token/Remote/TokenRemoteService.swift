//
//  TokenRemoteService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

protocol TokenRemoteService {
    func createAccessToken() async throws -> TokenResponse
}
