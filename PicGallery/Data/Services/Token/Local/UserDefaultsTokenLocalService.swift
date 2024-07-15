//
//  UserDefaultsTokenLocalService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

struct UserDefaultsTokenLocalService: TokenLocalService {
    
    private let tokenKey = "auth_token"
    
    func getAccessToken() async throws -> String {
        guard let data = UserDefaults.standard.data(forKey: tokenKey) else {
            return "No llega el token"
        }
        
        let token = try JSONDecoder().decode(TokenResponse.self, from: data)
        return token.accessToken ?? "No llega el token"
    }
    
    func saveAccessToken(url: URL) async throws {
        let parameters = url.queryParameters()
        
        let token = TokenResponse(
            accessToken: parameters["access_token"],
            expiresIn: Int(parameters["expires_in"] ?? "0"),
            tokenType: parameters["token_type"],
            scope: "",
            refreshToken: parameters["refresh_token"],
            accountUsername: parameters["account_id"])
        
        do {
            let data = try JSONEncoder().encode(token)
            UserDefaults.standard.set(data,forKey: tokenKey)
        } catch {
            print("Error al codificar y almacenar el token \(error) o el refresh token")
        }
    }
    
    
}
