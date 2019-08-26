//
//  AppGroup.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/19/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import Foundation

class AppGroup: Decodable {
    let feed: Feed
}

class Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

class FeedResult: Decodable {
    let id, name, artistName, artworkUrl100: String
}
