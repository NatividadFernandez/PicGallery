//
//  PruebasView.swift
//  PicGallery
//
//  Created by Patricia Lucia Morillas Alcala on 15/7/24.
//

import SwiftUI
import OAuthSwift

struct PruebasView: View {
    @State private var isAuthorized = false
     
     
     let oauthswift = OAuth2Swift(
         consumerKey: "ab890822a4ff63a",
         consumerSecret: "d1a443d7da6423f1ed13b3959b4574497904913e",
         authorizeUrl: "https://api.imgur.com/oauth2/authorize",
         accessTokenUrl: "https://api.imgur.com/oauth2/token",
         responseType: "token"
     )
    var body: some View {
          VStack {
              if isAuthorized {
                  Text("You are authorized!")
              } else {
                  Button(action: {
                      self.authorizeWithImgur()
                  }) {
                      Text("Authorize with Imgur")
                          .padding()
                          .foregroundColor(.white)
                          .background(Color.blue)
                          .cornerRadius(10)
                  }
              }
          }
          .padding()
      }
      
      func authorizeWithImgur() {
          guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let rootViewController = windowScene.windows.first?.rootViewController else {
              print("No root view controller found")
              return
          }
                 
          oauthswift.authorizeURLHandler = SafariURLHandler(viewController: rootViewController, oauthSwift: oauthswift)

          let _ = oauthswift.authorize(
              withCallbackURL: URL(string: "picgallery//:oauth/callback/imgur")!,
              scope: "",
              state: "") { result in
              switch result {
              case .success(let (credential, _, _)):
                  print("Access Token: \(credential.oauthToken)")
                  self.isAuthorized = true
                  // Aquí puedes realizar tus solicitudes con el token de acceso
              case .failure(let error):
                  print("Error: \(error.localizedDescription)")
              }
          }
      }
}

#Preview {
    PruebasView()
}


//import SwiftUI
//import OAuth2
/*class OAuth2Manager: ObservableObject {
    @Published var oauth2: OAuth2CodeGrant
    
    init() {
        oauth2 = OAuth2CodeGrant(settings: [
            "client_id": "ab890822a4ff63a",
            "client_secret": "d1a443d7da6423f1ed13b3959b4574497904913e",
            "authorize_uri": "https://api.imgur.com/oauth2/authorize",
            "token_uri": "https://api.imgur.com/oauth2/token",
            "redirect_uris": ["https://gallery.com/oauth/callback/imgur"],
            "scope": "",
            "response_type" : "code",
            "refresh_token" : "123"
        ])
        
        oauth2.authConfig.authorizeEmbedded = true // Permitir la autenticación integrada en la misma aplicación
    }
    
    func authorize() {
        oauth2.authConfig.authorizeContext = UIApplication.shared.windows.first?.rootViewController
        
        oauth2.authorize(callback: { authParameters, error in
            if let params = authParameters {
                // Manejar la respuesta de autorización aquí si es necesario
                print("Authorization parameters: \(params)")
            } else {
                print("Authorization error: \(error?.localizedDescription ?? "Unknown error")")
            }
            
            
        })
    }

}*/


/*struct ContentView: View {
    
    //@StateObject private var oauth2Manager = OAuth2Manager()
    @StateObject private var oauthManager = OAuthManager()

    var body: some View {
        
        VStack {
                    Button(action: {
                        oauthManager.authorize()
                    }) {
                        Text("Iniciar sesión en Imgur")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    if let accessToken = oauthManager.accessToken {
                        
                        Text("Token de acceso: \(accessToken)")
                            .padding()
                    }
                }
                .padding()

                .onOpenURL { url in
                    // Manejar la URL de retorno de Imgur para obtener el código de autorización
                    print("ENTRAS aquii")
                    guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
                          let queryItems = components.queryItems else {
                        return
                    }
                    
                    print(components)
                    
                    if let code = queryItems.first(where: { $0.name == "token" })?.value {
                        oauthManager.requestAccessToken(with: code)
                    }
                }

        /*VStack {
            if oauth2Manager.oauth2.isAuthorizing {
                ProgressView("Authorizing...")
            } else {
                Button("Authorize with Imgur") {
                    oauth2Manager.authorize()
                }
                .padding()
            }
        }
        .onOpenURL { url in
            if url.scheme == "gallery" && url.host == "oauth" {
                oauth2Manager.oauth2.handleRedirectURL(url)
            }
        }
        .onAppear {
            oauth2Manager.oauth2.logger = OAuth2DebugLogger(.trace)
        }*/
    }
}

#Preview {
    ContentView()
}

/*@State private var isAuthorized = false
 //@StateObject private var oauth2Manager = OAuth2Manager()
 
 let oauthswift = OAuth2Swift(
     consumerKey: "ab890822a4ff63a",
     consumerSecret: "d1a443d7da6423f1ed13b3959b4574497904913e",
     authorizeUrl: "https://api.imgur.com/oauth2/authorize",
     accessTokenUrl: "https://api.imgur.com/oauth2/token",
     responseType: "token"
 )

 var body: some View {
       VStack {
           if isAuthorized {
               Text("You are authorized!")
           } else {
               Button(action: {
                   self.authorizeWithImgur()
               }) {
                   Text("Authorize with Imgur")
                       .padding()
                       .foregroundColor(.white)
                       .background(Color.blue)
                       .cornerRadius(10)
               }
           }
       }
       .padding()
   }
   
   func authorizeWithImgur() {
       guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let rootViewController = windowScene.windows.first?.rootViewController else {
           print("No root view controller found")
           return
       }
              
       oauthswift.authorizeURLHandler = SafariURLHandler(viewController: rootViewController, oauthSwift: oauthswift)

       let _ = oauthswift.authorize(
           withCallbackURL: URL(string: "https://gallery.com/oauth/callback/imgur")!,
           scope: "",
           state: "") { result in
           switch result {
           case .success(let (credential, _, _)):
               print("Access Token: \(credential.oauthToken)")
               self.isAuthorized = true
               // Aquí puedes realizar tus solicitudes con el token de acceso
           case .failure(let error):
               print("Error: \(error.localizedDescription)")
           }
       }
   }*/
*/
