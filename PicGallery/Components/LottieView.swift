//
//  LottieView.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import SwiftUI
import Lottie
 
struct LottieView: UIViewRepresentable {
    let loopMode: LottieLoopMode
    let animationName: String

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: animationName)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
}

