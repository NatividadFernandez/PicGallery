//
//  Coordinator.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

class Coordinator: ObservableObject {
    
    private let tokenRepository: TokenRepository
    private let galleryRepository: GalleryRepository
    
    init(mock: Bool = false) {
        
        let networkClient = URLSessionNetworkClient()
        
        self.tokenRepository = TokenRepository(remoteService: LiveTokenRemoteService(networkClient: networkClient), localService: UserDefaultsTokenLocalService())
        
        let galleryRemoteService: GalleryRemoteService = mock ? MockGalleryRemoteService() : LiveGalleryRemoteService(networkClient: networkClient)
        
        self.galleryRepository = GalleryRepository(remoteService: galleryRemoteService, localTokenService: UserDefaultsTokenLocalService())
    }
    
    // MARK: SplashScreenView
    func makeSplashScreenView() -> SplashScreenView {
        return SplashScreenView(viewModel: makeSplashScreenViewModel())
    }
    
    func makeSplashScreenViewModel() -> SplashScreenViewModel {
        return .init(tokenRespository: tokenRepository)
    }
    
    // MARK: GalleryView
    func makeGalleryView() -> GalleryView {
        return GalleryView(viewModel: makeGalleryViewModel())
    }
    
    func makeGalleryViewModel() -> GalleryViewModel {
        return .init(galleryRepository: galleryRepository)
    }
}
