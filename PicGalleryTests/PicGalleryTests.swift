//
//  PicGalleryTests.swift
//  PicGalleryTests
//
//  Created by Patricia Lucia Morillas Alcala on 7/7/24.
//

import XCTest
@testable import PicGallery

final class PicGalleryTests: XCTestCase {

    func testLoadImagesInGallery() throws {
        
        let coordinator = Coordinator(mock: true)
        
        let viewModel = coordinator.makeGalleryViewModel()
        
        viewModel.pictures = [
            Picture.example,Picture.example
        ]
        
        for picture in viewModel.pictures {
            XCTAssertNotNil(picture.link)
        }
    }


}
