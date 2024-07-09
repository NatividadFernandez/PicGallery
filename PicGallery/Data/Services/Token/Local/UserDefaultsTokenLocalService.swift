//
//  UserDefaultsTokenLocalService.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

struct UserDefaultsTokenLocalService: TokenLocalService {
    
    private let tokenKey = "auth_token"
    
    func saveAccessToken(token: TokenResponse) async throws {
        do {
            let data = try JSONEncoder().encode(token)
            UserDefaults.standard.set(data,forKey: tokenKey)
        } catch {
            print("Error al codificar y almacenar el token \(error)")
        }
    }
    
    func getAccessToken() async throws -> String {
        guard let data = UserDefaults.standard.data(forKey: tokenKey) else {
            return "No llega el token maja 1"
        }
        
        let token = try JSONDecoder().decode(TokenResponse.self, from: data)
        return token.accessToken ?? "No llega el token maja 2"
    }
    
    
}
