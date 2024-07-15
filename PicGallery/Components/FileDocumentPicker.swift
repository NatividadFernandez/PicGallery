//
//  FileDocumentPicker.swift
//  PicGallery
//
//  Created by Natividad 13/7/24.
//

import SwiftUI
import UniformTypeIdentifiers


import SwiftUI
import UniformTypeIdentifiers

struct FileDocumentPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool
    @Binding var errorMessage: String?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIDocumentPickerDelegate {
        var parent: FileDocumentPicker

        init(parent: FileDocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else {
                parent.errorMessage = "No file selected."
                parent.isPresented = false
                return
            }
            do {
                let imageData = try Data(contentsOf: url)
                if let image = UIImage(data: imageData) {
                    parent.selectedImage = image
                } else {
                    
                    parent.errorMessage = "The selected file is not an image."
                }
            } catch {
                parent.errorMessage = error.localizedDescription
            }
            parent.isPresented = false
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.isPresented = false
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.image])
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}


