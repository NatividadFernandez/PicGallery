//
//  PicGalleryTests.swift
//  PicGalleryTests
//
//  Created by Natividad on 7/7/24.
//

import XCTest
@testable import PicGallery

final class PicGalleryTests: XCTestCase {
    
    var coordinator: Coordinator!
    var galleryViewModel: GalleryViewModel!
    var galleryView: GalleryView!

    override func setUpWithError() throws {
        coordinator = Coordinator(mock: true)
        galleryViewModel = coordinator.makeGalleryViewModel()
        galleryView = coordinator.makeGalleryView()
    }
    
    override func tearDownWithError() throws {
        galleryView = nil
        galleryViewModel = nil
        coordinator = nil
    }


    // Imagenes recibidas por la api, se muestran en la galeria
    func testLoadImagesInGallery() throws {
        
        let pictures = [Picture.example,Picture.example]
        
        galleryViewModel.pictures = pictures
        
        for picture in galleryViewModel.pictures {
            XCTAssertNotNil(picture.link)
        }
    }
    
    func testDeleteImageFromGallery() async {
        let pictureToDelete = Picture.example
            
        DispatchQueue.main.async {
            self.galleryViewModel.pictures = [pictureToDelete, Picture.example]
        }
        
        DispatchQueue.main.async {
            XCTAssertNotNil(self.galleryViewModel.pictures.first(where: { $0.id == pictureToDelete.id }))
        }
        
        await galleryViewModel.deletePicture(picture: pictureToDelete)
            
        DispatchQueue.main.async {
            self.galleryViewModel.pictures.removeAll(where: { $0.id == pictureToDelete.id })
            
            XCTAssertNil(self.galleryViewModel.pictures.first(where: { $0.id == pictureToDelete.id }))
        }
        
    }

}
