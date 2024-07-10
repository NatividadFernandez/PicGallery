//
//  TokenResponse.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

struct TokenResponse: Codable {
    let accessToken: String?
    let expiresIn: Int?
    let tokenType: String?
    let scope: String?
    let refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case scope
        case refreshToken = "refresh_token"
    }
}
