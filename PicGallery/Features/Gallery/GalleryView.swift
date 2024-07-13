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
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @State private var selectedPicture: Picture?
    @State private var showAlert = false
    
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
                    if viewModel.isLoading && viewModel.pictures.isEmpty {
                        Spacer()
                        ProgressView()
                        Spacer()
                    } else {
                        ForEach(viewModel.pictures) { picture in
                            GalleryRowView(picture: picture) {
                                selectedPicture = picture
                                showAlert = true
                            }
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
        .onChange(of: selectedImage) { oldImage, newImage in
            if let newImage = newImage {
                handleSelectImage(newImage)
            }
            
        }
        .alert(isPresented: $showErrorAlert){
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Delete Picture"),
                message: Text("Are you sure you want to delete this picture?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let picture = selectedPicture{
                        deletePicture(picture)
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func handleSelectImage(_ image: UIImage)  {
        Task {
            await viewModel.addPicture(image: image)
        }
    }
    
    private func deletePicture(_ picture: Picture)  {
        Task {
            await viewModel.deletePicture(picture: picture)
        }
    }
}

#Preview {
    let coordinator = Coordinator(mock: false)
    return coordinator.makeGalleryView().environmentObject(coordinator)
}
