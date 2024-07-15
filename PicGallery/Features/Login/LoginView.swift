//
//  ContentView.swift
//  PicGallery
//
//  Created by Natividad on 7/7/24.
//

import SwiftUI

struct LoginView: View {
    
    //@StateObject private var oauthManager = OAuthManager()
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: LoginViewModel
    @State private var isActive = false
    //@State private var parameterValue: String? = nil
    
    
    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        
        if isActive {
            coordinator.makeGalleryView()
        } else {
            VStack {
                Button(action: {
                    //oauthManager.authorize()
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
                
                
                
                /* let parameters = url.queryParameters()
                 
                 self.parameterValue = parameters["access_token"]
                 
                 print("Parametro: \(parameters)") */
            }
        }
    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makeLoginView().environmentObject(coordinator)
}


/*.onOpenURL { url in
    // Manejar la URL de retorno de Imgur para obtener el código de autorización
    print("ENTRAS aquii")
    /*guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
          let queryItems = components.queryItems else {
        return
    }*/
    
    print(url)
    
    let parameters = url.queryParameters()
    
    self.parameterValue = parameters["access_token"]
    
    print("Parametro: \(parameters)")
    
    //print(components)
    //print("QueryItems: \(queryItems)")
    
    
    /*if let code = queryItems.first(where: { $0.name == "token" })?.value {
        oauthManager.requestAccessToken(with: code)
    }*/
}
}*/
