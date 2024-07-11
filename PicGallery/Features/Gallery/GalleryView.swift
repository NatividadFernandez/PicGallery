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
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @State private var isImagePickerPresented = false
    @State private var isCameraPresented = false
    @State private var selectedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    
    
    init(viewModel: GalleryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
            VStack {
                Text("Gallery")
                    .font(.title)
                    .padding(.top, 15)
                ScrollView {
                    LazyVGrid(columns: columns) {
                        if viewModel.isLoading {
                            Spacer()
                            //ProgressView()
                            Spacer()
                        } else {
                            ForEach(viewModel.pictures) { picture in
                                GalleryRowView(picture: picture)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.top, 0)
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
                        sourceType = .photoLibrary
                        isImagePickerPresented = true
                    }) {
                        Text("Import picture")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        sourceType = .camera
                        isCameraPresented = true
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
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage, isPresented: $isImagePickerPresented, sourceType: sourceType)
            }
            .sheet(isPresented: $isCameraPresented) {
                ImagePicker(selectedImage: $selectedImage, isPresented: $isCameraPresented, sourceType: sourceType)
            }
        }
    }


#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeGalleryView().environmentObject(coordinator)
}
