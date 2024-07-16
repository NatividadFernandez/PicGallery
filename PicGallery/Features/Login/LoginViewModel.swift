//
//  SplashScreenViewModel.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    private let tokenRepository: TokenRepository
    
    @Published var isLoading = false
    @Published var error: Error?
    @Published var authorizationURL: URL?
    
    @Published var messageError = "Authorization error"
    @Published var isActive = false
    @Published var isLoggedIn = false
    @Published var activeAlert: ActiveAlertLogin?

    
    init(tokenRepository: TokenRepository) {
        self.tokenRepository = tokenRepository
    }
    
    @MainActor
    func showWindow() async {
        error = nil
        isLoading = true
        do {
            let url = try await tokenRepository.authorize()
            self.authorizationURL = url
        } catch (let error) {
            self.error = error
            activeAlert = .showAlertViewModel
        }
        
        isLoading = false
    }
    
    @MainActor
    func saveAccessToken(url: URL) async {
        error = nil
        isLoading = true
        do {
            let saveToken = try await tokenRepository.saveAccessToken(url: url)
            if !saveToken {
                activeAlert = .showAlertViewModel
            } else {
                self.isActive = true
            }
        } catch (let error) {
            self.error = error
            activeAlert = .showAlertViewModel
        }
        
        isLoading = false
    }
    
    @MainActor
    func checkSession() async {
        error = nil
        isLoading = true
        do {
            isLoggedIn = try await tokenRepository.checkSession()
        } catch (let error) {
            self.error = error
            activeAlert = .showAlertViewModel
        }
        
        isLoading = false
    }
  
}




