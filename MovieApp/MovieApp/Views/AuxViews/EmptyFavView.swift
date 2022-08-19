//
//  EmptyFav.swift
//  MovieApp
//
//  Created by MAC on 17/08/22.
//

import SwiftUI

struct EmptyFavView: View {
    @AppStorage("isDarkMode") private var isDark = true
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                Text("Empty Favorites")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Label("", systemImage: "heart.slash.fill")
                    .font(.title)
                    .padding()
                    .foregroundColor(.red)
                Text("Haven't found any interesting yet?")
            }
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
            .padding()
        }
        .environment(\.colorScheme, isDark ? .dark : .light)
        .toolbar {
            Button {
                isDark.toggle()
            } label: {
                Label("", systemImage: isDark ? "lightbulb.fill" : "lightbulb")
            }
        }
    }
}

/*
struct EmptyFav_Previews: PreviewProvider {
    static var previews: some View {
        EmptyFav()
    }
}
*/
