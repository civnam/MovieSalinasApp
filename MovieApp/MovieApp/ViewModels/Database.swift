//
//  Database.swift
//  MovieApp
//
//  Created by MAC on 17/08/22.
//

import Foundation

class Database {
    private let FAV_KEY = "fav_key"
    
    func save(shows: Set<Int>) {
        let array = Array(shows)
        UserDefaults.standard.set(array, forKey: FAV_KEY)
    }
    
    func load() -> Set<Int> {
        let array = UserDefaults.standard.array(forKey: FAV_KEY) as? [Int] ?? [Int]()
        return Set(array)
    }
}
