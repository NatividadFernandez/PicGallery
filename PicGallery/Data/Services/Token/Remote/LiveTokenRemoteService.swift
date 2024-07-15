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
    
    func authorize() async throws -> URL {
        return URL(string: "\(NetworkConstants.autorizeUrl)?client_id=\(NetworkConstants.clientId ?? "")&response_type=token&state=imgur") ?? URL(string: "")!
    }
}
