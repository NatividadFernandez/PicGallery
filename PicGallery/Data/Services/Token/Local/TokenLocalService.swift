//
//  TokenLocalService.swift
//  PicGallery
//
//  Created by Patricia Lucia Morillas Alcala on 9/7/24.
//

import Foundation

protocol TokenLocalService {
    func saveAccessToken(token: TokenResponse) async throws
    func getAccessToken() async throws -> String
}
