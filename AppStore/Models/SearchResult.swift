//
//  SearchResult.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/13/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String
    let formattedPrice: String?
    let description: String
    let releaseNotes: String?
}
