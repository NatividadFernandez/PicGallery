//
//  GalleryView.swift
//  PicGallery
//
//  Created by Patricia Lucia Morillas Alcala on 9/7/24.
//

import SwiftUI

struct GalleryView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject private var viewModel: GalleryViewModel
    
    init(viewModel: GalleryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView{
            VStack{
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    ForEach(viewModel.pictures) { picture in 
                        GalleryRowView(picture: picture)
                
                    }
                }
            }
        }
        .refreshable {
            await viewModel.getGallery()
        }
        .task {
            await viewModel.getGallery()
        }
    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeGalleryView().environmentObject(coordinator)
}
