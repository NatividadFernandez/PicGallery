//
//  TokenResponse.swift
//  PicGallery
//
//  Created by Patricia Lucia Morillas Alcala on 9/7/24.
//

import Foundation

struct TokenResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let tokenType: String
    let scope: String
    let refreshToken: String
}
