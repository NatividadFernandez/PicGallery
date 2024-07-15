//
//  PicGalleryApp.swift
//  PicGallery
//
//  Created by Natividad on 7/7/24.
//

import SwiftUI

@main
struct PicGalleryApp: App {
    let coordinator = Coordinator()
    var body: some Scene {
        WindowGroup {
            coordinator.makeSplashScreenView().environmentObject(coordinator)
            //coordinator.makeContentView().environmentObject(coordinator)
            //ContentView()
        }
    }
}

