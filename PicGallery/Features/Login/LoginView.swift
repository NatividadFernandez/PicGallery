//
//  ContentView.swift
//  PicGallery
//
//  Created by Natividad on 7/7/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: LoginViewModel
    @State private var isActive = false
    
    
    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        
        if isActive {
            coordinator.makeGalleryView()
        } else {
            VStack {
                Button(action: {
                    Task {
                        await viewModel.showWindow()
                    }
                    if let url = viewModel.authorizationURL {
                        UIApplication.shared.open(url)
                    }
                    
                }) {
                    Text("Iniciar sesión en Imgur")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .onOpenURL { url in
                Task {
                    await viewModel.saveAccessToken(url: url)
                }
                    self.isActive = true
            }
        }
    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeLoginView().environmentObject(coordinator)
}
