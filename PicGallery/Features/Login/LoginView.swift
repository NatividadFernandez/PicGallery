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
    
    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if viewModel.isActive {
            coordinator.makeGalleryView()
        } else {
            VStack {
                Text("Login")
                    .font(.title)
                    .padding(.top, 10)
                
                Spacer()
                
                Image("login")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                
                Spacer()
                
                Button(action: {
                    Task {
                        await viewModel.showWindow()
                    }
                    viewModel.activeAlert = .showAlertView
                }) {
                    Text("Login")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 40)
                
                Spacer()
            }
            .padding()
            .onOpenURL { url in
                Task {
                    await viewModel.saveAccessToken(url: url)
                }
            }
            .alert(item: $viewModel.activeAlert) { activeAlert in
                switch activeAlert {
                case .showAlertView:
                    return Alert(
                        title: Text("Information"),
                        message: Text("Redirect to imgur"),
                        primaryButton: .default(Text("OK")) {
                            if let url = viewModel.authorizationURL {
                                UIApplication.shared.open(url)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                case .showAlertViewModel:
                    return Alert(
                        title: Text("Error"),
                        message: Text(viewModel.messageError),
                        dismissButton: .default(Text("OK"))
                    )              
                }
                
            }
        }
    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeLoginView().environmentObject(coordinator)
}
