//
//  GalleryViewModel.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import Foundation
import SwiftUI

class GalleryViewModel: ObservableObject {
    
    @EnvironmentObject var coordinator: Coordinator
    private let galleryRepository: GalleryRepository
    private let tokenRepository: TokenRepository
    private var currentTask: Task<Void, Never>? = nil
    
    @Published var isLoading = false
    @Published var pictures: [Picture] = []
    @Published var error: Error?
    @Published var messageError = "There was an error in the connection"
    @Published var isLoggedIn = false
    @Published var activeAlert: ActiveAlertGallery?
    
    init(galleryRepository: GalleryRepository, tokenRepository: TokenRepository) {
        self.galleryRepository = galleryRepository
        self.tokenRepository = tokenRepository
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
                activeAlert = .showAlertViewModel
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
            activeAlert = .showAlertViewModel
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
            activeAlert = .showAlertViewModel
        }
        
        isLoading = false
    }
    
    @MainActor
    func logout() async {
        error = nil
        isLoading = true
        
        do {
            isLoggedIn = try await tokenRepository.logout()
            if !isLoggedIn {
                isLoggedIn = true
            }
        } catch {
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
