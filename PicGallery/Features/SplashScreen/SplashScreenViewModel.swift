//
//  SplashScreenViewModel.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

class SplashScreenViewModel: ObservableObject {
    private let tokenRespository: TokenRepository
    
    @Published var isLoading = false
    @Published var error: Error?
    
    init(tokenRespository: TokenRepository) {
        self.tokenRespository = tokenRespository
    }
    
    @MainActor
    func createAccessToken() async {
        error = nil
        isLoading = true
        do {
            try await tokenRespository.createAccessToken()
        } catch (let error) {
            self.error = error
        }
        
        isLoading = false
    }
}
