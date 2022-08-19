//
//  ShowModel.swift
//  MovieApp
//
//  Created by MAC on 16/08/22.
//

import Foundation


struct Show: Decodable, Identifiable{
    var id: Int
    var name: String
    var language: String
    var genres: [String]
    var premiered: String
    var schedule: Schedule
    var rating: Rating
    var externals: Externals
    var image: Image
    var summary: String
}

struct Schedule: Decodable {
    var time: String
    var days: [String]
}

struct Rating: Decodable {
    var average: Double?
}

struct Externals: Decodable {
    var imdb: String?
}

struct Image: Decodable {
    var medium: String
    var original: String
}
