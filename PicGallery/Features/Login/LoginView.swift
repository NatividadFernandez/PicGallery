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
    @State private var showAlertLogin = false
    
    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
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
                        showAlertLogin = true
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
                    print(url)
                    Task {
                        await viewModel.saveAccessToken(url: url)
                    }
                }
                .alert(isPresented: Binding(
                    get: { viewModel.showMessage },
                    set: { viewModel.showMessage = $0 }
                )) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.messageError),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .alert(isPresented: $showAlertLogin) {
                    Alert(
                        title: Text("Information"),
                        message: Text("Redirect to imgur"),
                        primaryButton: .default(Text("OK")) {
                            if let url = viewModel.authorizationURL {
                                UIApplication.shared.open(url)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
    }
}

            
           /* VStack {
                Button(action: {
                    Task {
                        await viewModel.showWindow()
                    }
                    
                    print("Hola")
                    
                }) {
                    Text("Login")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Information"),
                        message: Text("Redirect to imgur"),
                        primaryButton: .default(Text("OK")) {
                            if let url = viewModel.authorizationURL {
                                UIApplication.shared.open(url)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .padding() */


#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeLoginView().environmentObject(coordinator)
}
