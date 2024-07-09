//
//  Coordinator.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

class Coordinator: ObservableObject {
    
    private let tokenRepository: TokenRepository
    
    init(mock: Bool = false) {
        
        let networkClient = URLSessionNetworkClient()
        
        self.tokenRepository = TokenRepository(remoteService: LiveTokenRemoteService(networkClient: networkClient), localService: UserDefaultsTokenLocalService())
    }
    
    // MARK: SplashScreenView
    
    func makeSplashScreenView() -> SplashScreenView {
        return SplashScreenView(viewModel: makeSplashScreenViewModel())
    }
    
    func makeSplashScreenViewModel() -> SplashScreenViewModel {
        return .init(tokenRespository: tokenRepository)
    }
}
