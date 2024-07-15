//
//  TokenLocalService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

protocol TokenLocalService {
    func saveAccessToken(url: URL) async throws -> Bool
    func getAccessToken() async throws -> String
    func logout() async throws
}
