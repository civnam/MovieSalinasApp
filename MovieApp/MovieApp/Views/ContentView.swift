//
//  ContentView.swift
//  MovieApp
//
//  Created by MAC on 16/08/22.
//

import SwiftUI

@MainActor
struct ContentView: View {

    @AppStorage("isDarkMode") private var isDark = true
    @EnvironmentObject var showModel: ShowModelView
    @State private var search = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(showModel.getAllShows.filter{ search.isEmpty ? true: $0.name.contains(search) }){ show in
                        ShowRowView(show: show)
                    }.listRowBackground(Color.purple.opacity(0.3))
                }
            }
            .navigationTitle("TV Shows")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    isDark.toggle()
                } label: {
                    Label("", systemImage: isDark ? "lightbulb.fill" : "lightbulb")
                }
            }
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                showModel.disableFavs()
            }
            .refreshable {
                await showModel.refreshShow()
            }
        }
        .environment(\.colorScheme, isDark ? .dark : .light)
    }
    
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
