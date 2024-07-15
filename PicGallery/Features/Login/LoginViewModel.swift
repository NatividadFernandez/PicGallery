//
//  SplashScreenViewModel.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    private let tokenRespository: TokenRepository
    
    @Published var isLoading = false
    @Published var error: Error?
    @Published var authorizationURL: URL?
    
    init(tokenRespository: TokenRepository) {
        self.tokenRespository = tokenRespository
    }
    
    /*@MainActor
    func createAccessToken() async {
        error = nil
        isLoading = true
        do {
            try await tokenRespository.createAccessToken()
        } catch (let error) {
            self.error = error
        }
        
        isLoading = false
    } */
    
    @MainActor
    func showWindow() async {
        error = nil
        isLoading = true
        do {
            let url = try await tokenRespository.authorize()
            self.authorizationURL = url
        } catch (let error) {
            self.error = error
        }
        
        isLoading = false
    }
    
    @MainActor
    func saveAccessToken(url: URL) async {
        error = nil
        isLoading = true
        do {
            try await tokenRespository.saveAccessToken(url: url)
        } catch (let error) {
            self.error = error
        }
        
        isLoading = false
    }
  
    
}
