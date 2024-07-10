//
//  GalleryView.swift
//  PicGallery
//
//  Created by Natividad on 9/7/24.
//

import SwiftUI

struct GalleryView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject private var viewModel: GalleryViewModel
    
    init(viewModel: GalleryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
            VStack {
                ScrollView {
                    VStack {
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

                Spacer()
                VStack(spacing: 10) {
                    Button(action: {
                    }) {
                        Text("Import picture")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                    }) {
                        Text("Take picture")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(8)
                        
                    }
                }
                .padding()
            }
        }
    }

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeGalleryView().environmentObject(coordinator)
}
