//
//  GalleryViewModel.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation

class GalleryViewModel: ObservableObject {
    
    private let galleryRepository: GalleryRepository
    private var currentTask: Task<Void, Never>? = nil
    
    @Published var isLoading = false
    @Published var pictures: [Picture] = []
    @Published var error: Error?
    
    init(galleryRepository: GalleryRepository) {
        self.galleryRepository = galleryRepository
    }
    
    @MainActor
    func getGallery() async {
        currentTask?.cancel()
        
        currentTask = Task {
            error = nil
            isLoading = true
            
            do {
                pictures = try await galleryRepository.getGallery().data
                print(pictures.count)
            } catch {
                self.error = error
            }
            
            isLoading = false
        }
        
        await currentTask?.value
    }
}
