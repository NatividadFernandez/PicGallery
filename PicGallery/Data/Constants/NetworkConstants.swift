//
//  NetworkConstants.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

struct NetworkConstants {
    static let grantType = "refresh_token"
    static let clientId = Config.shared.value(forKey: "IMGUR_CLIENT_ID")
    static let clientSecret = Config.shared.value(forKey: "IMGUR_CLIENT_SECRET")
    static let refreshToken = Config.shared.value(forKey:"IMGUR_REFRESH_TOKEN")
    static let bodyParams = [
        "refresh_token": refreshToken,
        "client_id": clientId,
        "client_secret": clientSecret,
        "grant_type": grantType
    ]
    
    static let autorizeUrl = "https://api.imgur.com/oauth2/authorize"
    //static let authNetworkUrl = "https://api.imgur.com/oauth2/token"
    static let baseUrl = "https://api.imgur.com/3"
    static let galleryUrl = "\(baseUrl)/account/me/images"
    static let uploadImageUrl = "\(baseUrl)/image"
    static let deleteImageUrl = "\(baseUrl)/image/"
    
}


