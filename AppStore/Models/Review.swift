//
//  Review.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/24/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import Foundation

struct Reviews: Decodable {
    let feed: ResultFeed
}

struct ResultFeed: Decodable {
    let entries: [Entry]
    private enum CodingKeys: String, CodingKey {
        case entries = "entry"
    }
}

struct Entry: Decodable {
    let author: Author
    let title: Label
    let content: Label
    let rating: Label

    private enum CodingKeys: String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}

struct Label: Decodable {
    let label: String
}

struct Author: Decodable {
    let name: Label
}
