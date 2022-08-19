//
//  FavoriteView.swift
//  MovieApp
//
//  Created by MAC on 16/08/22.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var showModel: ShowModelView
    @AppStorage("isDarkMode") private var isDark = true
    
    var body: some View {
        
        NavigationView {
            if showModel.favShows.isEmpty {
                EmptyFavView()
            } else {
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20) {
                            ForEach(showModel.getFavShows) {show in
                                FavCardView(show: show)
                                    .padding(.all)
                            }
                        }
                    }
                }
                .navigationTitle("Favorite View")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        isDark.toggle()
                    } label: {
                        Label("", systemImage: isDark ? "lightbulb.fill" : "lightbulb")
                    }
                }
                .onAppear {
                    showModel.enableFavs()
                }
            }
        }
        .environment(\.colorScheme, isDark ? .dark : .light)
    }
}

/*
struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
*/
