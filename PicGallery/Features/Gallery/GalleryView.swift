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
    @State private var isFilePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var selectedPicture: Picture?
    @State private var showAlert = false
    @State private var showErrorAlert = false
    @State private var errorMessage: String? = nil
    @State private var showActionSheet = false
    @State private var showAlertLogout = false
    
    init(viewModel: GalleryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.pictures) { picture in
                                GalleryRowView(picture: picture) {
                                    selectedPicture = picture
                                    showAlert = true
                                }
                            }
                        }
                        .padding([.horizontal, .bottom])
                        .padding(.top, 0)
                    }.task {
                        await viewModel.getGallery()
                    }.refreshable {
                        await viewModel.getGallery()
                    }
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    } else if (viewModel.pictures.isEmpty) {
                        Text("No photos to show")
                            .foregroundColor(.gray)
                            .font(.headline)
                        
                    }
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    Button(action: {
                        showActionSheet = true
                    }) {
                        Text("Import picture")
                            .foregroundColor(.white)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        isCameraPresented = true
                    }) {
                        Text("Take picture")
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationTitle("Gallery")
            .navigationBarTitleDisplayMode(.inline)
            //.navigationBarBackButtonHidden(true)
            .toolbar {
                logout()
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage, isPresented: $isImagePickerPresented, sourceType: .photoLibrary)
            }
            .sheet(isPresented: $isCameraPresented) {
                ImagePicker(selectedImage: $selectedImage, isPresented: $isCameraPresented, sourceType: .camera)
            }
            .sheet(isPresented: $isFilePickerPresented) {
                FileDocumentPicker(selectedImage: $selectedImage, isPresented: $isFilePickerPresented, errorMessage: $errorMessage)
            }
            .onChange(of: selectedImage) { oldImage, newImage in
                if let newImage = newImage {
                    handleSelectImage(newImage)
                }
                
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
            }
            .onChange(of: errorMessage) { oldValue, newValue in
                if newValue != nil {
                    showErrorAlert = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete Picture"),
                    message: Text("Are you sure you want to delete this picture?"),
                    primaryButton: .destructive(Text("Delete")) {
                        Task {
                            if let picture = selectedPicture{
                                deletePicture(picture)
                            }
                        }
                        
                    },
                    secondaryButton: .cancel()
                )
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Select an option"),
                    buttons: [
                        .default(Text("Photo Library")) {
                            isImagePickerPresented = true
                        },
                        .default(Text("File Explorer")) {
                            isFilePickerPresented = true
                        },
                        .cancel()
                    ]
                )
            }
            .alert(isPresented: $showAlertLogout) {
                Alert(
                    title: Text("Logout"),
                    message: Text("Are you sure you want to log out?"),
                    primaryButton: .default(Text("OK")) {
                        Task {
                            await viewModel.logout()
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            
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
    
    private func logout() -> some View {
        Button(action: {
            Task {
                showAlertLogout = true
            }
        }) {
            Image(systemName: "person.crop.circle.fill")
                .frame(width: 40, height: 40)
        }
    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeGalleryView().environmentObject(coordinator)
}
