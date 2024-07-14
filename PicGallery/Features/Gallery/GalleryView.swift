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
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedPicture: Picture?
    @State private var showAlert = false
    @State private var showErrorAlert = false
    @State private var errorMessage: String? = nil
    @State private var isImportingPicture = false
    @State private var isTakingPicture = false
    @State private var showActionSheet = false
    
    
    
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
                    //sourceType = .photoLibrary
                    //isImagePickerPresented = true
                    showActionSheet = true
                }) {
                    Text("Import picture")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .overlay(content: {
                            if isImportingPicture {
                                ProgressView()
                            }
                        })
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
                        .overlay(content: {
                            if isTakingPicture {
                                ProgressView()
                            }
                        })
                }
            }
            .padding()
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
                    if let picture = selectedPicture{
                        deletePicture(picture)
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
                        sourceType = .photoLibrary
                        isImagePickerPresented = true
                    },
                    .default(Text("File Explorer")) {
                        isFilePickerPresented = true
                    },
                    .cancel()
                ]
            )
        }


    }
    
    
    private func handleSelectImage(_ image: UIImage)  {
        Task {
            handleAction(result: true)
            await viewModel.addPicture(image: image)
            handleAction(result: false)
        }
    }
    
    private func deletePicture(_ picture: Picture)  {
        Task {
            await viewModel.deletePicture(picture: picture)
        }
    }
    
    private func handleAction(result : Bool) {
        switch sourceType {
        case .photoLibrary:
            isImportingPicture = result
        case .camera:
            isTakingPicture = result
        default:
            isImportingPicture = result
            break
        }
    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeGalleryView().environmentObject(coordinator)
}
