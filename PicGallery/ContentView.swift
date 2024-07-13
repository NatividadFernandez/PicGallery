//
//  ContentView.swift
//  PicGallery
//
//  Created by Natividad on 7/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var accessToken: String?
    
    
    var body: some View {
        VStack {
            Image(systemName: "camera.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
