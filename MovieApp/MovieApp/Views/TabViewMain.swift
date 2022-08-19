//
//  TabViewMain.swift
//  MovieApp
//
//  Created by MAC on 16/08/22.
//

import SwiftUI

@MainActor
struct TabViewMain: View {
    
    @AppStorage("isDarkMode") private var isDark = true
    @State private var isLoading = false
    var showModel = ShowModelView()
    
    var body: some View {
        
        VStack {
            if isLoading {
                ZStack {
                    Color(isDark ? .black : .white)
                        .ignoresSafeArea()
                    VStack {
                        VStack {
                            Text("Welcome back to Salinas Home Theater App")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .font(.title.italic())
                                .padding()
                            Text("Please, wait a moment")
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(100)
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                            .scaleEffect(3)
                    }
                }
            } else {
                TabView {
                    ContentView()
                        .environmentObject(showModel)
                        .tabItem {
                            Label("Shows", systemImage: "film")
                        }
                    FavoriteView()
                        .environmentObject(showModel)
                        .tabItem {
                            Label("Favorites", systemImage: "heart.fill")
                        }
                }}
        }
        .onAppear {
            startFakeLoadView()
        }
        .task {
            do {
                try await showModel.getShow()
            } catch {
                print(error, "Error on Getting Shows")
            }
        }
    }
    
    func startFakeLoadView() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isLoading = false
        }
    }
}

/*
struct TabViewMain_Previews: PreviewProvider {
    static var previews: some View {
        TabViewMain()
    }
}
 */
