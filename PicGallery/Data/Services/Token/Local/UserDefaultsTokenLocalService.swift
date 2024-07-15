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
            return ""
        }
        
        let token = try JSONDecoder().decode(TokenResponse.self, from: data)
        return token.accessToken ?? ""
    }
    
    func saveAccessToken(url: URL) async throws -> Bool {
        let parameters = url.queryParameters()
        
        if parameters.isEmpty {
            let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems
            if queryItems?.first(where: { $0.name == "error" })?.value != nil {
                return false
            }
        }
        
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
            return true
        } catch {
            print("Error encoding and storing token \(error) or refresh token")
            return false
        }
    }
    
    func logout() async throws {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.synchronize()
    }
    
    
    
    
}
