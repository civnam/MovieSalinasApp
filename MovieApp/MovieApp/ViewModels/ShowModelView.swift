//
//  ShowModelView.swift
//  MovieApp
//
//  Created by MAC on 16/08/22.
//

import Foundation
import SwiftUI

@MainActor
class ShowModelView: ObservableObject {
    
    @Published var showModel: [Show] = []
    @Published var displayFavs = false
    @Published var favShows: Set<Int> = []
    private var db = Database()
    
    var getFavShows: [Show] {
        return showModel.filter { favShows.contains($0.id) }
    }
    
    var getAllShows: [Show] {
        return showModel
    }
    
    init() {
        self.favShows = db.load()
    }
    
    func getShow() async throws {
        guard let url = URL(string: "https://api.tvmaze.com/shows") else { return }
        let (data,_) = try await URLSession.shared.data(from: url)
        let shows = try JSONDecoder().decode([Show].self, from: data)
        self.showModel = shows
    }
    
    func refreshShow() async {
        showModel = []
        do {
            try await getShow()
        } catch {
            print(error, "Error on refresh")
        }
        
    }
    
    // Codigo para Favoritos
    
    func enableFavs() {
        displayFavs = true
    }
    
    func disableFavs() {
        displayFavs = false
    }
    
    func isFav(_ show: Show) -> Bool {
        favShows.contains(show.id)
    }
    
    func makeFav(show: Show) {
        favShows.insert(show.id)
        db.save(shows: favShows)
    }
    
    func undoFav(show: Show) {
        favShows.remove(show.id)
        db.save(shows: favShows)
    }
    
    func toggleFav(show: Show) {
        withAnimation {
            if isFav(show) {
                favShows.remove(show.id)
            } else {
                favShows.insert(show.id)
            }
            db.save(shows: favShows)
        }
    }
    
}
