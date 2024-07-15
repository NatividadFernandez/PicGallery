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
    
    /*func createAccessToken() async throws -> TokenResponse {
        let response: TokenResponse = try await networkClient.postCall(url: NetworkConstants.authNetworkUrl, body: NetworkConstants.bodyParams)
        print("HEMOS LLEGADO")
        print(response)
        return response
    }*/
    
    func authorize() async throws -> URL {
        
        //let urlString = "https://api.imgur.com/oauth2/authorize?client_id=ab890822a4ff63a&response_type=token&state=imgur"
        
        return URL(string: "\(NetworkConstants.autorizeUrl)?client_id=\(NetworkConstants.clientId ?? "")&response_type=token&state=imgur") ?? URL(string: "")!
    }
}
