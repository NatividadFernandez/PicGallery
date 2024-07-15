//
//  GalleryViewModel.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation
import SwiftUI

class GalleryViewModel: ObservableObject {
    
    private let galleryRepository: GalleryRepository
    private var currentTask: Task<Void, Never>? = nil
    private let messageError = "There was an error"
    
    @Published var isLoading = false
    @Published var pictures: [Picture] = []
    @Published var error: Error?
    @Published var showAlertError = false
    @Published var isError = false
    
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
                pictures = try await galleryRepository.getGallery()
            } catch {
                self.error = error
                showAlertError = true
                isError = true
            }
            
            isLoading = false
        }
        
        await currentTask?.value
    }
    
    @MainActor
    func addPicture(image: UIImage) async {
        error = nil
        isLoading = true
        
        do {
            let responde = try await galleryRepository.addPicture(image: image)
            if responde.success {
                let newPicture = responde.data
                pictures.insert(newPicture, at: 0)
                print("Image added successfully")
            } else {
                print("Unable to add image")
            }
        } catch {
            self.error = error
            showAlertError = true
            isError = true
        }
        
        isLoading = false
    }
    
    @MainActor
    func deletePicture(picture: Picture) async {
        error = nil
        isLoading = true
        
        do {
            let response = try await galleryRepository.deletePicture(imageHash: picture.deletehash)
            if response.success {
                print("Image deleted successfully with id: \(picture.id)")
                pictures.removeAll{$0.deletehash == picture.deletehash}
            } else {
                print("Unable to delete image with id: \(picture.id)")
            }
        } catch {
            self.error = error
            showAlertError = true
            isError = true
        }
        
        isLoading = false
    }
    
    @MainActor
    func logout() async {
        error = nil
        isLoading = true
        
        do {
            try await galleryRepository.logout()
            exit(0)
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    
    
}
