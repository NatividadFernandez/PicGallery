//
//  TokenRepository.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

struct TokenRepository {
    
    let remoteService: TokenRemoteService
    let localService: TokenLocalService
    
    init(remoteService: TokenRemoteService, localService: TokenLocalService) {
        self.remoteService = remoteService
        self.localService = localService
    }
    
    func createAccessToken() async throws {
        let token = try await remoteService.createAccessToken()
        try await localService.saveAccessToken(token: token)
    }
}
