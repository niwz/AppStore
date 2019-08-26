//
//  Service.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/13/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import Foundation

class Service {

    static let shared = Service()

    func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }

    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }

    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }

    func fetchTopFree(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }

    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }

    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch objects: ", error)
                completion(nil, error)
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                completion(objects, error)
            } catch {
                print("Failed to decode JSON: ", error)
                completion(nil, error)
            }
        }.resume()
    }
}
