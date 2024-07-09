//
//  NetworkConstants.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

struct NetworkConstants {
    static let clientId = "bcbf46ca23831b7"
    static let clientSecret = "a6daaa67b9f65051b7c349605ab2006f876a1523"
    static let grantType = "refresh_token"
    static let authNetworkUrl = "https://api.imgur.com/oauth2/token"
    static let refreshToken = "6e777331fcdca99b3d201a4a66cb61601bda54dd"
    static let bodyParams = [
        "refresh_token": refreshToken,
        "client_id": clientId,
        "client_secret": clientSecret,
        "grant_type": grantType
    ]
    
    static let baseUrl = "https://api.imgur.com/3"
    
}
