//
//  GalleryRowView.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import SwiftUI

struct GalleryRowView: View {
    
    let picture: Picture
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: picture.link)) { imagePhase in
                switch imagePhase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 150)
                        .cornerRadius(10)
                        .clipped()
                        
                default:
        
                    ProgressView()
                }
            }
            .frame(width: 160, height: 150)
            .cornerRadius(10)
            .clipped()
            
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 1)
        .frame(width: 160, height: 150)
        
    }
}

#Preview {
    GalleryRowView(picture: .example)
}
