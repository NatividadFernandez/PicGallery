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
    
    
    @Published var messageError = ""
    @Published var showMessage = false
    @Published var isActive = false
    @Published var isLoggedIn = false

    
    init(tokenRespository: TokenRepository) {
        self.tokenRespository = tokenRespository
    }
    
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
            let saveToken = try await tokenRespository.saveAccessToken(url: url)
            if !saveToken {
                messageError = "Authorization error"
                showMessage = true
            } else {
                self.isActive = true
            }
        } catch (let error) {
            self.error = error
        }
        
        isLoading = false
    }
    
    @MainActor
    func checkSession() async {
        error = nil
        isLoading = true
        do {
            isLoggedIn = try await tokenRespository.checkSession()
        } catch (let error) {
            self.error = error
        }
        
        isLoading = false
    }
  
    
}
