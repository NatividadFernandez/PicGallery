//
//  TokenLocalService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

protocol TokenLocalService {
    func saveAccessToken(token: TokenResponse) async throws
    func getAccessToken() async throws -> String
}
