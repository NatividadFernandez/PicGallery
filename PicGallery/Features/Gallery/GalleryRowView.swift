//
//  GalleryRowView.swift
//  PicGallery
//
//  Created by Patricia Lucia Morillas Alcala on 9/7/24.
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
                        .frame(width: 130, height: 120)
                        .cornerRadius(10)
                        .clipped()
                default:
                    Image("photo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 130, height: 120)
                        .cornerRadius(10)
                        .clipped()
                }
            }
            .frame(width: 130, height: 120)
            .cornerRadius(10)
            .clipped()
        }
        .background(Color(red: 0.88, green: 0.84, blue: 0.96))
        .cornerRadius(10)
        .shadow(radius: 1)
        .frame(width: 130, height: 120)

    }
}

#Preview {
    GalleryRowView(picture: .example)
}
