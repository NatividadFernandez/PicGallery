//
//  LiveTokenRemoteService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

struct LiveTokenRemoteService: TokenRemoteService {
    
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func createAccessToken() async throws -> TokenResponse {
        let response: TokenResponse = try await networkClient.postCall(url: NetworkConstants.authNetworkUrl, body: NetworkConstants.bodyParams)
        print("HEMOS LLEGADO")
        print(response)
        return response
    }
}
